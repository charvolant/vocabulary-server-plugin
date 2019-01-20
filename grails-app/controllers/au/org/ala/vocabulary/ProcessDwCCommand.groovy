package au.org.ala.vocabulary

import grails.validation.Validateable
import org.springframework.web.multipart.MultipartFile

/**
 * Command for processing an ISO 639 dataset
 *
 * @author Doug Palmer &lt;Doug.Palmer@csiro.au&gt;
 * @copyright Copyright &copy; 2019 Atlas of Living Australia
 */
class ProcessDwCCommand implements Validateable {
    /** The CSV file containing darwin core terms */
    MultipartFile dwcFile
    /** The biocache index fields */
    URL biocacheIndexFields
    /** Include all terms */
    boolean complete

    static constraints = {
        def fileValidator = { val, obj ->
            if ( val == null ) {
                return false
            }
            if ( val.empty ) {
                return false
            }

            ['csv', 'txt'].any { extension ->
                val.originalFilename?.toLowerCase()?.endsWith(extension)
            }
        }
        dwcFile validator: fileValidator
        biocacheIndexFields nullable: true, url: true
    }
}
