package au.org.ala.vocabulary

import grails.converters.JSON

class VocabularyController {
    static RDF_TYPE = "http://www.w3.org/1999/02/22-rdf-syntax-ns#Type"
    def vocabularyService

    def index() {
    }

    def types() {
        def offset = params.offset as Integer ?: 0
        def max = params.max as Integer ?: 10
        def locale = request.locale
        def list = vocabularyService.listTypes(offset, max, locale)
        def model = [list: list, context: list.'@context']
        if (request.xhr) {
            render(template: 'types', model: model)
        } else {
            model
        }
    }

    def list() {
        def offset = params.offset as Integer ?: 0
        def max = params.max as Integer ?: 10
        def type = params.type ?: "http://www.w3.org/2000/01/rdf-schema#Resource"
        def locale = request.locale
        def list = vocabularyService.listResources(type, offset, max, locale)
        def model = [list: list, context: list.'@context']
        if (request.xhr) {
            render(template: 'list', model: model)
        } else {
            model
        }
    }

    def show() {
        def iri = params.iri
        def locale = request.locale
        def resource = vocabularyService.getResource(iri, locale)
        [resource: resource, context: resource.'@context']
    }

    /**
     * XHR produces a reference list suitable for embedding
     */
    def references() {
        def iri = params.iri
        def offset = params.offset as Integer ?: 0
        def max = params.max as Integer ?: 10
        def locale = request.locale
        def list = vocabularyService.listReferences(iri, offset, max, locale)
        def model = [list: list, context: list.'@context']

        if (request.xhr) {
            render(template: 'references', model: model)
        } else {
            model
        }
    }


    /**
     * XHR produces a reference list suitable for embedding
     */
    def search() {
        def q = params.q
        def offset = params.offset as Integer ?: 0
        def max = params.max as Integer ?: 10
        def locale = request.locale
        def list = vocabularyService.search(q, offset, max, locale)
        def model = [list: list, context: list.'@context']

        if (request.xhr) {
            render(template: 'search', model: model)
        } else {
            model
        }
    }

}
