<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout ?: 'main'}"/>
    <title><g:message code="page.vocabulary.index.title"/></title>
    <asset:javascript src="references.js"/>
    <asset:stylesheet href="vocabulary.css"/>
</head>
<body>

<div class="container">
    <div class="page-header">
        <h1><g:message code="page.vocabulary.index.title"/></h1>
    </div>
    <g:render template="/shared/nav"/>

    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-default vocabularies-panel">
                <div class="panel-heading">
                    <h2 class="panel-title"><g:message code="label.vocabularies"/></h2>
                </div>
                <div id="vocabularies"></div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-default concepts-panel">
                <div class="panel-heading">
                    <h2 class="panel-title"><g:message code="label.concepts"/></h2>
                </div>
                <div id="concepts"></div>
            </div>
        </div>
    </div>
</div>
<asset:script type="application/javascript">
    $(document).ready(function() {
        loadPage($("#vocabularies"), "${g.createLink(controller: 'vocabulary', action: 'list', params: [type: 'http://www.w3.org/2004/02/skos/core#ConceptScheme'])}", 0, 10);
        loadPage($("#concepts"), "${g.createLink(controller: 'vocabulary', action: 'list', params: [type: 'http://www.w3.org/2004/02/skos/core#Concept'])}", 0, 10);
    });
</asset:script>
</body>
