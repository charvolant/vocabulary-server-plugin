package au.org.ala.vocabulary
/**
 * Routines for helping with translation between vocabularies.
 *
 * The main use is to take a set of translation defintions and generate an ontology for those
 * definitions.
 */
class TranslationController {
    def translationService

    def index() {
        def tagLanguages = params.tagLanguages ?: grailsApplication.config.languages.tag.default
        [tagLanguages: tagLanguages]
    }

    /**
     * Process ISO-639-3 data from https://iso639-3.sil.org into RDF
     */
    def process639(Process639Command cmd) {
        if (!cmd || cmd.hasErrors()) {
            flash.message = message(code: 'error.iso-639-3.noFiles')
            redirect action: 'index'
            return
        }
        def languages = translationService.process639(cmd.nameFile, cmd.macroFile, cmd.tagLanguages)
        response.setHeader('Content-Disposition', 'Attachment;Filename="iso639.ttl"')
        render(view: 'process639', model: [languages: languages, complete: cmd.complete], contentType: 'text/turtle', encoding: 'UTF-8')
    }

    def processDwC(ProcessDwCCommand cmd) {
        if (!cmd || cmd.hasErrors()) {
            flash.message = message(code: 'error.dwc.noFiles')
            redirect action: 'index'
            return
        }
        def terms = translationService.processDwC(cmd.dwcFile, cmd.biocacheIndexFields, request.locale)
        response.setHeader('Content-Disposition', 'Attachment;Filename="darwin-core.ttl"')
        render(view: 'processDwC', model: [terms: terms, complete: cmd.complete], contentType: 'text/turtle', encoding: 'UTF-8')
    }
}
