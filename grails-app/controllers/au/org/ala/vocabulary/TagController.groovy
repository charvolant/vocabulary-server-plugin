package au.org.ala.vocabulary

/**
 * Get tags for taggable IRIs.
 */
class TagController {
    def vocabularyService

    def tag() {
        def iri = params.iri
        def locale = request.locale
        def resource = vocabularyService.getResource(iri, locale)
        [resource: resource, context: resource.'@context']
    }
}
