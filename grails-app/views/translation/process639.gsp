<%@page defaultCodec="none" %>
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
@prefix xsd:<fu:turtleIri iri="http://www.w3.org/2001/XMLSchema#"/> .
@prefix dcterms: <fu:turtleIri iri="http://purl.org/dc/terms/"/> .

languages:iso639
    rdf:type skos:ConceptScheme ;
    rdfs:label "<g:message code="page.translation.process639.iso639.label"/>" ;
    rdfs:comment "<g:message code="page.translation.process639.iso639.comment"/>" ;
    dcterms:source <fu:turtleIri iri="http://www.iso639-3.sil.org"/> ;
.

<g:findAll in="${languages.values()}" expr="${it.part1 || it.tag || complete}">
<g:set var="lang" value="${it}"/>
<fu:turtleIri iri="http://iso639-3.sil.org/code/${lang.code}"/>
  rdf:type dcterms:ISO639-3 ;
<g:if test="${lang.tag}">
  rdf:type format:Language ;
</g:if>
  skos:notation "${lang.code}" ;
  rdfs:label "${lang.name}" ;
<g:if test="${lang.part1}">
  owl:sameAs <fu:turtleIri iri="http://www.infoterm.info/iso639-1/${lang.part1}"/> ;
</g:if>
<g:if test="${lang.comment}">
  rdfs:comment <fu:jsString value="${lang.comment}"/> ;
</g:if>
<g:each var="type" in="${lang.types}">
  format:languageType <fu:turtleIri iri="${type}"/> ;
</g:each>
    dcterms:source <fu:turtleIri iri="http://www.iso639-3.sil.org"/> ;
<g:each var="alt" in="${lang.alts}">
  skos:altLabel "${alt}" ;
</g:each>
<g:each var="macro" in="${lang.macro}">
  skos:broader <fu:turtleIri iri="http://ala.org.au/languages/1.0/iso639-3/${macro.code}"/> ;
</g:each>
  skos:inScheme languages:iso639 ;
.

</g:findAll>

<g:findAll in="${languages.values()}" expr="${it.part1}">
<g:set var="lang" value="${it}"/>
<fu:turtleIri iri="http://www.infoterm.info/iso639-1/${lang.part1}"/>
  rdf:type dcterms:RFC4646 ;
<g:if test="${lang.tag}">
  rdf:type format:Language ;
</g:if>
  owl:sameAs <fu:turtleIri iri="http://iso639-3.sil.org/code/${lang.code}"/> ;
  skos:notation "${lang.part1}" ;
  rdfs:label "${lang.name}" ;
<g:each var="type" in="${lang.types}">
  format:languageType <fu:turtleIri iri="${type}"/> ;
</g:each>
  dcterms:source <fu:turtleIri iri="http://www.iso639-3.sil.org"/> ;
  skos:inScheme languages:iso639
.
</g:findAll>