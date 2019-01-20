<g:set var="snippet"><voc:shortCode iri="http://www.openrdf.org/contrib/lucenesail#snippet"/></g:set>
<div class="search-results">
    <dl class="search-result-list dl-horizontal">
    <g:each var="resource" in="${list.'@graph'}">
        <dt><voc:format value="${resource}"/></dt><dd>${raw(resource[snippet]?.get('@value'))}</dd>
    </g:each>
    </dl>
    <g:if test="${list.'@count'}"><tb:paginate total="${list.'@count'}" max="${params.max}" params="${[q: params.q]}" action="search"/></g:if>
</div>
