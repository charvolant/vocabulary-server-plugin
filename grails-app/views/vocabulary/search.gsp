<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout ?: 'main'}"/>
    <title><g:message code="page.resource.search.title"/></title>
    <meta name="breadcrumbParent" content="/,${message(code: 'vocabulary.title')}"/>
    <asset:stylesheet href="vocabulary.css"/>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1><g:message code="page.vocabulary.search.title"/></h1>
    </div>
    <g:render template="/shared/nav"/>
    <div class="row">
        <div class="col-md-12">
            <g:render template="search"/>
        </div>
    </div>
</div>
</body>
</html>