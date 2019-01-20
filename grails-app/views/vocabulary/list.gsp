<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout ?: 'main'}"/>
    <title><g:message code="resource.list.title"/></title>
    <meta name="breadcrumbParent" content="/,${message(code: 'vocabulary.title')}"/>
    <voc:tagHeader/>
</head>
<body>

<div class="container">
    <div class="page-header">
        <h1><g:message code="page.vocabulary.list.title"/></h1>
    </div>
    <g:render template="/shared/nav"/>
    <div class="row">
        <div class="col-md-12">
<table class="table">
    <thead>
    <tr>
        <th><g:message code="label.vocabulary"/></th>
        <th><g:message code="label.resource"/></th>
        <th><g:message code="label.description"/></th>
        <th></th>
    </tr>
    </thead>
    <tbody>
<g:each var="resource" in="${list.'@graph'}">
    <tr>
        <td><voc:format value="${resource.'skos:inScheme'}"/></td>
        <td><voc:format value="${resource}"/></td>
        <td>${resource.'@description'}</td>
        <td><voc:isTag value="${resource}"><voc:concept iri="${resource['@id']}"/></voc:isTag></td>
    </tr>
</g:each>
    </tbody>
</table>
    </div>
        <div class="row">
            <div class="col-md-12">
                    <tb:paginate total="${list.'@count'}" max="${params.max}"
                                 action="list"
                    />
            </div>
        </div>
    </div>
</div>
</body>
</html>