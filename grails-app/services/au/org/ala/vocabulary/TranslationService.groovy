package au.org.ala.vocabulary

import au.org.ala.util.ResourceUtils
import au.org.ala.util.TitleCapitaliser
import com.opencsv.CSVParserBuilder
import com.opencsv.CSVReaderBuilder
import groovy.json.JsonSlurper
import org.springframework.web.multipart.MultipartFile

class TranslationService {
    static TYPE_639_MAP = [
            I: 'http://www.ala.org.au/format/1.0/languageTypes/individual',
            M: 'http://www.ala.org.au/format/1.0/languageTypes/macrolanguage',
            S: 'http://www.ala.org.au/format/1.0/languageTypes/special',
            A: 'http://www.ala.org.au/format/1.0/languageTypes/ancient',
            C: 'http://www.ala.org.au/format/1.0/languageTypes/constructed',
            E: 'http://www.ala.org.au/format/1.0/languageTypes/extinct',
            H: 'http://www.ala.org.au/format/1.0/languageTypes/historical',
            L: 'http://www.ala.org.au/format/1.0/languageTypes/living',
            U: 'http://www.ala.org.au/format/1.0/languageTypes/unknown'
    ]
    /**
     * Process ISO-639-3 name and macro-translation file into RDF
     *
     * @param nameFile The name file
     * @param macroFile The macro-translation file
     * @param tagLanguages The list of required translation codes
     */
    def process639(MultipartFile nameFile, MultipartFile macroFile, String tagLanguages) {
        def defaultType = TYPE_639_MAP['U']
        def reader = new InputStreamReader(nameFile.inputStream, 'UTF-8')
        def parser = new CSVParserBuilder().withSeparator('\t' as char).withIgnoreLeadingWhiteSpace(true).build()
        def csv = new CSVReaderBuilder(reader).withSkipLines(1).withCSVParser(parser).build()
        def languages = [:]
        String[] line
        // Read the translation codes
        while ((line = csv.readNext()) != null) {
            def code = line[0]
            def part2b = line[1]
            def part2t = line[2]
            def part1 = line[3]
            def scope = line[4]  // I(ndividual), M(acrolanguage), S(pecial)
            def type = line[5] // A(ncient), C(onstructed), E(xtinct), H(istorical), L(iving), S(pecial)
            def name = line[6]
            def comments = line[7]
            def types = [TYPE_639_MAP[scope] ?: defaultType, TYPE_639_MAP[type] ?: defaultType] as Set
            def alts = [part1, part2t, part2b].findAll({ it && it != code}) as Set
            def tag = part1 && type == 'L'
            def language = [code: code, name: name, types: types, alts: alts, tag: tag]
            if (part1)
                language.part1 = part1
            if (comments)
                language.comments = comments
            languages[code] = language
        }
        // Read the macro languages
        reader = new InputStreamReader(macroFile.inputStream, 'UTF-8')
        csv = new CSVReaderBuilder(reader).withSkipLines(1).withCSVParser(parser).build()
        while ((line = csv.readNext()) != null) {
            def macro = line[0]
            def lang = line[1]
            def status = line[2] // A (active) or R (retired)
            if (status == 'A') {
                lang = languages[lang]
                macro = languages[macro]
                if (lang && macro) {
                    if (!lang.macro)
                        lang.macro = []
                    lang.macro << macro
                }
                macro.tag = true
            }
        }
        // Read the list of taggable languages
        tagLanguages.split(',').each { code ->
            def lang = languages[code]
            if (lang)
                lang.tag = true
        }
        return languages
    }

    /**
     * Process an DwC description
     *
     * @param dwcFile The file containing the Darwin code terms
     * @param biocacheIndexFields URL to a biocache instance that contains
     * @param locale The locale for text info
     *
     * @return The parsed terms
     */
    def processDwC(MultipartFile dwcFile, URL biocacheIndexFields, Locale locale) {
        def terms = []
        def lookup = [:]
        String[] line
        // Read the term defintions
        def reader = new InputStreamReader(dwcFile.inputStream, 'UTF-8')
        def parser = new CSVParserBuilder().withSeparator(',' as char).withQuoteChar('"' as char).withIgnoreLeadingWhiteSpace(true).build()
        def csv = new CSVReaderBuilder(reader).withSkipLines(1).withCSVParser(parser).build()
        while ((line = csv.readNext()) != null) {
            def iri = line[0] // Dated IRI
            def label = line[1]
            def definition = line[2]
            def comments = line[3]
            def examples = line[4]  // separated by commas
            def organised_in = line[5]
            def issued = line[6]
            def status = line[7]
            def replaces = line[8]
            def rdf_type = line[9]
            def term_iri = line[10]
            def abcd_equivalent = line[11]
            def flags = line[12]
            def current = status == 'recommended'
            def term = [
                    iri: term_iri,
                    notation: ResourceUtils.localName(term_iri),
                    label: label,
                    definition: definition,
                    comments: comments,
                    examples: examples,
                    organiser: organised_in,
                    issued: issued,
                    status: status,
                    replaces: replaces.split('\\|'),
                    type: rdf_type,
                    version: iri,
                    abcd: abcd_equivalent,
                    flags: flags,
                    current: current,
                    dwc: true
            ]
            terms << term
            if (current) {
                lookup[term.iri] = term
                lookup[term.notation] = term
            }
        }
        // Read the biocache definitions
        if (biocacheIndexFields) {
            def js = new JsonSlurper()
            def index = js.parse(biocacheIndexFields)
            def capitaliser = TitleCapitaliser.create(locale.language)
            index.each { field ->
                String name = field.name
                def description = field.description
                def info = field.info
                def downloadName = field.downloadName
                def classs = field.classs
                def dwcTerm = field.dwcTerm
                def jsonName = field.jsonName
                //def i18nValues = field.i18nValues
                //def downloadDescription = field.downloadDescription
                def label = capitaliser.capitalise(name.split('_+'))
                def term = null
                if (dwcTerm)
                    term = lookup[dwcTerm]
                if (!term && info)
                    term = lookup[info]
                if (!term) {
                    term = [
                            iri: 'http://www.ala.org.au/terms/1.0/' + name,
                            notation: name,
                            label: label,
                            definition: description ?: info,
                            comments: description && description != info ? info : null,
                            examples: null,
                            organiser: classs,
                            issued: null,
                            status: 'indexes',
                            replaces: null,
                            type: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#Property',
                            version: null,
                            abcd: null,
                            flags: null,
                            current: true,
                            dwc: false
                    ]
                    terms << term
                }
                if (!term.csvName && downloadName)
                    term.csvName = downloadName
                if (!term.jsonName && jsonName)
                    term.jsonName = jsonName
                if (!term.solrName)
                    term.solrName = name
            }
        }
        return terms
    }
}
