/**
 * Scripts to handle AJAX-loadable pagination
 */

function loadPage(element, url, offset, max) {
    element.html("<div class=\"loading\">Loading...</div>");
    var loadurl = url + (/\?/.test(url) ? "&" : "?") + "offset=" + offset + "&max=" + max;
    element.load(loadurl, function(response, status, xhr) {
        if (status == "success") {
            element.find("ul.pagination a.step").each(function() {
                var elt = $(this);
                var href = elt.attr("href");
                var hrefRe=/offset=(\d+).*max=(\d+)/;
                var match=hrefRe.exec(href);
                var o = offset;
                var m = max;
                if (match) {
                    o = match[1];
                    m = match[2];
                }
                elt.attr("href", "#");
                elt.on("click", function() {
                    loadPage(element, url, o, m);
                });
            });
        }
    });
}