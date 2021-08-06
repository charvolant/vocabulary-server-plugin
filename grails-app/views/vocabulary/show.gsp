<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout ?: 'main'}"/>
    <title><voc:title value="${resource}"/></title>
    <meta name="breadcrumbParent" content="/,${message(code: 'vocabulary.title')}"/>
    <asset:javascript src="references.js"/>
    <asset:stylesheet href="vocabulary.css"/>
    <asset:javascript src="gijgo.js"/>
    <asset:stylesheet href="gijgo.css"/>
    <voc:tagHeader/>
    <style>
    </style>
</head>
<body>

<div class="container">
    <div class="page-header">
            <h1><voc:title value="${resource}"/></h1>
    </div>
    <g:render template="/shared/nav"/>
    <div class="row">
        <div class="col-md-12">
            <a href="${resource['@id']}" class="rdf-resource" target="_blank">&lt;${resource['@id']}&gt;&nbsp;<span class="glyphicon glyphicon-new-window"></span></a>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <p><voc:description value="${resource}"/></p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <div class="panel-group">
                <g:each var="category" in="${resource['@categorisation']?.keySet()}">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title"><voc:format value="${category}" style="title"/></h4>
                        </div>
                        <div class="panel-body">
                            <g:each var="property" in="${resource['@categorisation'][category]}">
                                <div class="row">
                                    <div class="col-md-4">
                                        <voc:format value="${property}"/>
                                    </div>
                                    <div class="col-md-8">
                                        <voc:format value="${resource[property]}" property="${property}" language="true"/>
                                    </div>
                                </div>
                            </g:each>
                        </div>
                    </div>
                </g:each>
            </div>
        </div>
        <div class="col-md-4">
            <voc:isSkos value="${resource}">
                <div class="panel panel-default skos-panel">
                    <div class="panel-heading">
                        <h4 class="panel-title"><g:message code="label.classification"/><voc:helpIcon code="help.classification"/>
                        <a role="button" data-toggle="collapse" href="#skos" aria-expanded="false" aria-controls="skos"><span class="glyphicon glyphicon-chevron-down">&nbsp;</span></a>
                        </h4>
                    </div>
                    <div class="panel-body collapse" id="skos">
                    </div>
                </div>
            </voc:isSkos>
            <voc:isTag  value="${resource}">
                <div class="panel panel-default appearance-panel">
                    <div class="panel-heading">
                        <h4 class="panel-title"><g:message code="label.appearence"/><voc:helpIcon code="help.appearance"/>
                        <a role="button" data-toggle="collapse" href="#appearance" aria-expanded="false" aria-controls="appearance"><span class="glyphicon glyphicon-chevron-down">&nbsp;</span></a>
                        </h4>
                    </div>
                    <g:set var="notationSC"><voc:shortCode iri="http://www.w3.org/2004/02/skos/core#notation"/></g:set>
                    <g:set var="notation" value="${resource.get(notationSC)?.get(0)?.get('@value')}"/>
                    <div class="panel-body collapse" id="appearance">
                    <voc:tag iri="${resource['@id']}"/>
                    </div>
                </div>
            </voc:isTag>
            <div class="panel panel-default references-panel">
                <div class="panel-heading">
                    <h4 class="panel-title"><g:link controller="vocabulary" action="references" params="${[iri: params.iri]}"><g:message code="label.references"/></g:link><voc:helpIcon code="help.references"/>
                        <a role="button" data-toggle="collapse" href="#references" aria-expanded="false" aria-controls="references"><span class="glyphicon glyphicon-chevron-down">&nbsp;</span></a>
                    </h4>
                </div>
                <div class="panel-body collapse" id="references">
                </div>
            </div>
        </div>
    </div>
</div>
<asset:script type="application/javascript">
    $(document).ready(function() {
        loadPage($("#references"), "${g.createLink(controller: 'vocabulary', action: 'references', params: [iri: resource['@id']])}", 0, 10);
        <voc:isSkos value="${resource}">
        var skos = $("#skos").tree({
            uiLibrary: "bootstrap",
            dataSource: "${g.createLink(controller: 'vocabulary', action: 'skosTree', params: [iri: resource['@id']])}",
            primaryKey: "iri"
        });
        </voc:isSkos>
});
</asset:script>
</body>
</html>