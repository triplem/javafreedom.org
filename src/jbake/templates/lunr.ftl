<#include "commons/striptags-functions.ftl">

[
    <#list published_posts as post>
        {
            "id": "${post?counter}",
            "title": "${striptags(post.title)}",
            <#compress>
                <#if (striptags(post.body)?length > 1000)>
                    "content": "${striptags(post.body)?substring(0, 1000)}",
                <#else>
                    "content": "${striptags(post.body)}",
                </#if>
            </#compress>

            "url": "/${post.uri}",
            "author": "${post.author!config.site_author}",
            "categories": "<#list post.tags as tag>${tag}<#sep>, </#sep> </#list>"
        }<#sep>, </#sep>
    </#list>
]
