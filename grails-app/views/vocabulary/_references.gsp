<div class="references">
    <ul class="reference-list">
    <g:each var="resource" in="${list.'@graph'}">
        <li><voc:format value="${resource}"/></li>
    </g:each>
    </ul>
    <g:if test="${list.'@count'}"><tb:paginate total="${list.'@count'}" max="${params.max}" action="list"/></g:if>
</div>
