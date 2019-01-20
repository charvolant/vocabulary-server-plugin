<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="${grailsApplication.config.skin.layout}"/>
    <title><g:message code-="page.language.index.title"/> | ${grailsApplication.config.skin.orgNameLong}</title>
</head>
<body>
<div class="container">
    <div class="page-header">
        <h1><g:message code="page.translation.index.title"/></h1>
    </div>
    <g:if test="${flash.error}"><div class="row danger"><div class="col-md-12">${flash.error}</div></div></g:if>
    <g:if test="${flash.message}"><div class="row info" ><div class="col-md-12">${flash.message}</div></div></g:if>
    <div class="row">
        <div class="col-md-12">
            <h2><g:message code="label.iso-639-3-upload"/></h2>
            <g:message code="label.iso-639-3-upload.detail"/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <g:uploadForm action="process639">
                <div class="form-group">
                    <label for="nameFile"><g:message code="label.nameFile"/></label>
                    <g:field id="nameFile" name="nameFile" type="file" required="true" class="form-control"/>
                    <small class="form-text text-muted"><g:message code="label.nameFile.detail"/></small>
                </div>
                <div class="form-group">
                    <label for="macroFile"><g:message code="label.macroFile"/></label>
                    <g:field id="macroFile" name="macroFile" type="file" required="true" class="form-control"/>
                    <small class="form-text text-muted"><g:message code="label.macroFile.detail"/></small>
                </div>
                <div class="form-group">
                    <label for="tagLanguages"><g:message code="label.tagLanguages"/></label>
                    <g:field id="tagLanguages" name="tagLanguages" type="text" class="form-control" value="${tagLanguages}"/>
                    <small class="form-text text-muted"><g:message code="label.tagLanguages.detail"/></small>
                </div>
                <div class="form-group">
                    <label for="complete-639" class="form-check-label">
                        <g:checkBox id="complete-639" name="complete" value="${false}"/>
                        <g:message code="label.complete"/>
                    </label>
                    <small class="form-text text-muted"><g:message code="label.complete.detail"/></small>
                </div>
                <button type="submit" class="btn btn-primary"><g:message code="label.process"/></button>
            </g:uploadForm>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h2><g:message code="label.dwc-upload"/></h2>
            <g:message code="label.dwc-upload.detail"/>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <g:uploadForm action="processDwC">
                <div class="form-group">
                    <label for="dwcFile"><g:message code="label.dwcFile"/></label>
                    <g:field id="dwcFile" name="dwcFile" type="file" required="true" class="form-control"/>
                    <small class="form-text text-muted"><g:message code="label.dwcFile.detail"/></small>
                </div>
                <div class="form-group">
                    <label for="biocacheIndexFields"><g:message code="label.biocacheIndexFields"/></label>
                    <g:field id="biocacheIndexFields" name="biocacheIndexFields" type="url" required="true" class="form-control" value="${biocacheIndexFields}"/>
                    <small class="form-text text-muted"><g:message code="label.biocacheIndexFields.detail"/></small>
                </div>
                <div class="form-group">
                    <label for="complete-dwc" class="form-check-label">
                        <g:checkBox id="complete-dwc" name="complete" value="${false}"/>
                        <g:message code="label.complete"/>
                    </label>
                    <small class="form-text text-muted"><g:message code="label.complete.detail"/></small>
                </div>
                 <button type="submit" class="btn btn-primary"><g:message code="label.process"/></button>
            </g:uploadForm>
        </div>
    </div>
</div>
</body>
</html>