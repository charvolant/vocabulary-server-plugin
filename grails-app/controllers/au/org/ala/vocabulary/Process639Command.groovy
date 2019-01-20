package au.org.ala.vocabulary

import grails.validation.Validateable
import org.springframework.web.multipart.MultipartFile

/**
 * Command for processing an ISO 639 dataset
 *
 * @author Doug Palmer &lt;Doug.Palmer@csiro.au&gt;
 * @copyright Copyright &copy; 2019 Atlas of Living Australia
 */
class Process639Command implements Validateable {
    /** The TSV file containing translation codes and names */
    MultipartFile nameFile
    /** The TSV file containing macrolangiage definitions */
    MultipartFile macroFile
    /** The list of taggable translation codes */
    String tagLanguages
    /** Include all languages */
    boolean complete

    static constraints = {
        def fileValidator = { val, obj ->
            if ( val == null ) {
                return false
            }
            if ( val.empty ) {
                return false
            }

            ['tab', 'tsv', 'txt'].any { extension ->
                val.originalFilename?.toLowerCase()?.endsWith(extension)
            }
        }
        nameFile validator: fileValidator
        macroFile validator: fileValidator
        tagLanguages blank: true, matches: '[a-z]{3}?(,[a-z]{3})*'
    }
}
