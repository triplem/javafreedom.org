<div class="row">
    <div class="col-md-11 col-md-offset-1 card">
        <h5>Search</h5>
<#--
        <form action="//google.com/search" method="get" accept-charset="UTF-8" class="search-form">
            <div class="input-group">
                <input class="form-control" type="search" name="q" />
                <span class="input-group-btn">
                    <button class="btn btn-custom" type="submit"><span class="glyphicon glyphicon-search"></span></button>
                </span>
            </div>
            <input type="hidden" name="q" value="site:${config.site_host}">
        </form>
-->

        <form id="lunrSearchForm" name="lunrSearchForm">
            <label for="search-box">Search</label>
            <input type="text" id="search-box" name="query">
            <input type="submit" value="search">
        </form>

        <ul id="search-results"></ul>

        <script src="https://unpkg.com/lunr/lunr.js"></script>
        <script src="<#if (content.rootpath)??>${content.rootpath}<#else></#if>resources/js/jquery-2.2.1.min.js"></script>

        <script>
            var lunrIndex,
                documents,
                $results;

            function initLunr() {
                console.log("init start")
                // retrieve the index file
                $.getJSON("/lunr-index.json")
                    .done(function(data) {
                        lunrIndex = lunr.Index.load(data)
                    })
                    .fail(function(jqxhr, textStatus, error) {
                        var err = textStatus + ", " + error + ", " + jqxhr.statusCode;
                    });

                $.getJSON("/lunr.json")
                    .done(function(data) {
                        documents = data
                    })
                    .fail(function(jqxhr, textStatus, error) {
                        var err = textStatus + ", " + error;
                        console.error("Error getting Lunr data file:", err);
                    });

                console.log("init.end")
            }

            function search(query) {
                return lunrIndex.search(query).map(function(result) {
                    return documents.filter(function(page) {
                        try {
                            console.log(page)
                            return page.id === result.ref;
                        } catch (e) {
                            console.log('whoops')
                        }
                    })[0];
               });
            }

            function renderResults(results) {
                if (!results.length) {
                    return;
                }

                console.log("results: " + results.length)

                // show first ten results
                results.slice(0, 10).forEach(function(result) {
                    console.log(result)
                    console.log("result-id: " + result.id)
                    console.log("result-title: " + result.title)
                    console.log("result-url: " + result.url)

                    var $result = $("<li>");

                    $result.append($("<a>", {
                        href: result.url,
                        text: "» " + result.title
                    }));

                    $results.append($result);
                });
            }

            function initUI() {
                $results = $("#search-results");

                $("#lunrSearchForm").submit(function() {

                    // empty previous results
                    $results.empty();

                    var query = $("#search-box").val();
                    if (query.length < 4) {
                        return;
                    }

                    console.log("test: " + query)
                    var docs = search(query);

                    renderResults(docs);
                });
            }

            console.log("--init")
            initLunr();
            console.log("init--")

            $(document).ready(function(){
                initUI();
            });
        </script>

    </div>
</div>
