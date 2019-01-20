<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button class="navbar-toggle collapsed" type="button" data-toggle="collapse"
                    data-target="#navbar-content" aria-expanded="false" aria-label="Toggle navigation">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="${createLink(controller: 'vocabulary', action: 'index')}" title="${message(code: 'page.vocabulary.index.title')}" class="navbar-brand"><span  class="glyphicon glyphicon-link"></span></a>
        </div>

        <div class="collapse navbar-collapse" id="navbar-content">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a class="dropdown-toggle" href="#" id="navbar-resources" role="button" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false"><g:message code="label.vocabulary"/></a>
                    <ul class="dropdown-menu" aria-labelledby="navbar-resources">
                        <li><a href="${createLink(controller: 'vocabulary', action: 'list')}"
                               class="dropdown-item"><g:message code="page.vocabulary.list.menu"/></a></li>
                        <li><a href="${createLink(controller: 'vocabulary', action: 'types')}"
                               class="dropdown-item"><g:message code="page.vocabulary.types.menu"/></a></li>
                    </ul>
                </li>
             </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" href="#" id="navbar-admin" role="button" data-toggle="dropdown"
                       aria-haspopup="true" aria-expanded="false"><g:message code="label.admin"/></a>
                    <ul class="dropdown-menu" aria-labelledby="navbar-admin">
                        <li><a href="${createLink(controller: 'translation', action: 'index')}"
                               class="dropdown-item"><g:message code="page.translation.index.menu"/></a></li>
                    </ul>
                </li>
            </ul>

            <div class="navbar-form navbar-right">
                <g:form controller="vocabulary" action="search" method="GET">
                    <div class="form-group">
                        <input class="form-control" name="q" id="q" type="search"
                               placeholder="${message(code: 'label.search')}"
                               aria-label="Search">

                    </div>
                </g:form>
            </div>
        </div>
</nav>
