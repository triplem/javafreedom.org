<#function striptags body>
    <#local target = body?replace(config.remove_tag_regex, "", "r")>
    <#local target = target?replace("\"", "", "r")>
    <#local target = target?replace("\\n", " ", "r")>
    <#local target = target?replace("[", " ")?replace("]", " ")>
    <#local target = target?replace("{", " ")?replace("}", " ")>
    <#local target = target?replace("\\", " ")>
    <#local target = target?replace("  ", " ", "r")>
    <#return target>
</#function>