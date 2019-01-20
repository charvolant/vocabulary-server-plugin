<div class="types">
    <ul class="type-list">
    <g:each var="resource" in="${list.'@graph'}">
        <li><voc:format value="${resource}"/></li>
    </g:each>
    </ul>
    <g:if test="${list.'@count'}"><tb:paginate total="${list.'@count'}" max="${params.max}" params="${[type: params.type]}" action="list"/></g:if>
</div>
