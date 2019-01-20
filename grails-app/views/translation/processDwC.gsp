<%@page import="groovy.json.StringEscapeUtils" defaultCodec="none" %>
<%@ page contentType="text/turtle" %>
# baseURI: http://ala.org.au/languages/1.0/
# imports: http://purl.org/dc/terms/
# imports: http://www.ala.org.au/format/1.0/
# imports: http://www.ala.org.au/terms/1.0/
# imports: http://www.w3.org/2004/02/skos/core
# prefix: languages

@prefix ala: <fu:turtleIri iri="http://www.ala.org.au/terms/1.0/"/> .
@prefix format: <fu:turtleIri iri="http://www.ala.org.au/format/1.0/"/> .
@prefix languages: <fu:turtleIri iri="http://ala.org.au/languages/1.0/"/> .
@prefix owl: <fu:turtleIri iri="http://www.w3.org/2002/07/owl#"/> .
@prefix rdf: <fu:turtleIri iri="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/> .
@prefix rdfs: <fu:turtleIri iri="http://www.w3.org/2000/01/rdf-schema#"/> .
@prefix skos: <fu:turtleIri iri="http://www.w3.org/2004/02/skos/core#"/> .
@prefix xsd: <fu:turtleIri iri="http://www.w3.org/2001/XMLSchema#"/> .
@prefix dcterms: <fu:turtleIri iri="http://purl.org/dc/terms/"/> .
@prefix dwc: <fu:turtleIri iri="http://rs.tdwg.org/dwc/terms/"/> .
<g:set var="dwc_vocabulary"><fu:turtleIri iri="http://rs.tdwg.org/dwc/terms"/></g:set>
<g:set var="ala_vocabulary"><fu:turtleIri iri="http://www.ala.org.au/dwc/terms"/></g:set>

${dwc_vocabulary}
    rdf:type skos:ConceptScheme ;
    rdfs:label "<g:message code="page.translation.processDwC.dwc.label"/>" ;
    rdfs:comment "<g:message code="page.translation.processDwC.dwc.comment"/>" ;
    dcterms:source <fu:turtleIri iri="http://rs.tdwg.org/dwc/"/> ;
    dcterms:source <fu:turtleIri iri="https://github.com/tdwg/dwc"/> ;
.

${ala_vocabulary}
rdf:type skos:ConceptScheme ;
rdfs:label "<g:message code="page.translation.processDwC.ala.label"/>" ;
    rdfs:comment "<g:message code="page.translation.processDwC.ala.comment"/>" ;
    dcterms:source <fu:turtleIri iri="https://www.ala.org.au"/> ;
.

<g:findAll in="${terms}" expr="${it.current}">
<g:set var="term" value="${it}"/>
<fu:turtleIri iri="${term.iri}"/>
  rdf:type <fu:turtleIri iri="${term.type}"/> ;
  rdf:type format:Term ;
  skos:notation <fu:jsString value="${term.notation}"/> ;
  skos:inScheme ${ala_vocabulary} ;
<g:if test="${term.dwc}">  skos:inScheme ${dwc_vocabulary} ;</g:if>
  rdfs:label <fu:jsString value="${term.label}"/> ;
  ala:status "${term.status}" ;
    <g:if test="${term.version}">  owl:sameAs ${'<' + term.version + '>'} ;</g:if>
<g:if test="${term.definition}">
  dcterms:description <fu:jsString value="${term.definition}"/> ;
</g:if>
<g:if test="${term.comments}">
  skos:note <fu:jsString value="${term.comments}"/> ;
</g:if>
<g:if test="${term.examples}">
  skos:example <fu:jsString value="${term.examples}"/> ;
</g:if>
<g:if test="${term.issued}">
  dcterms:issued <fu:jsString value="${term.issued}"/> ;
</g:if>
<g:if test="${term.solrName}">
  ala:solrName <fu:jsString value="${term.solrName}"/> ;
</g:if>
<g:if test="${term.jsonName}">
  ala:jsonName <fu:jsString value="${term.jsonName}"/> ;
</g:if>
<g:if test="${term.jsonName}">
  ala:csvName <fu:jsString value="${term.csvName}"/> ;
</g:if>
.
</g:findAll>

<g:if test="${complete}">
<g:each var="term" in="${terms}">
<fu:turtleIri iri="${term.version}"/>
  rdf:type <fu:turtleIri iri="${term.type}"/> ;
  rdfs:label <fu:jsString value="${term.label}"/> ;
  ala:status "${term.status}" ;
<g:if test="${term.definition}">
  dcterms:description <fu:jsString value="${term.definition}"/> ;
</g:if>
<g:if test="${term.comments}">
    skos:note <fu:jsString value="${term.comments}"/> ;
</g:if>
<g:each var="r" in="${term.replaces}">
<g:if test="${r}">    dcterms:replaces <fu:turtleIri iri="${r}"/> ;</g:if>
</g:each>
<g:if test="${term.issued}">
    dcterms:issued <fu:jsString value="${term.issued}"/> ;
</g:if>.
</g:each>
</g:if>