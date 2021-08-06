<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout ?: 'main'}"/>
    <title><g:message code="page.vocabulary.references.title" args="${[params.iri]}"/></title>
    <meta name="breadcrumbParent" content="/,${message(code: 'vocabulary.title')}"/>
</head>
<body>

<div class="container">
    <div class="page-header">
        <h1><g:link controller="vocabulary" action="show" params="${[iri: params.iri]}"><g:message code="page.vocabulary.references.title" args="${[params.iri]}"/></g:link></h1>
    </div>
    <g:render template="/shared/nav"/>
    <div class="row">
        <div class="col-md-12">
            <g:render template="references"/>
        </div>
    </div>
</div>
</body>
</html>