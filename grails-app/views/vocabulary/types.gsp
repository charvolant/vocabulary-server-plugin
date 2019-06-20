<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout ?: 'main'}"/>
    <title><g:message code="page.vocabulary.types.title"/></title>
    <meta name="breadcrumbParent" content="/,${message(code: 'vocabulary.title')}"/>
    <voc:tagHeader/>
</head>
<body>

<div class="container">
    <div class="page-header">
        <h1><g:message code="page.vocabulary.types.title"/></h1>
    </div>
    <g:render template="/shared/nav"/>
    <div class="row">
        <div class="col-md-12">
            <g:render template="types"/>
        </div>
    </div>
</div>
</body>
</html>