
<div class="col-md-8 col-xs-6">
    <ul class="list-inline links">
       <#list config.site_menus_footer as menuItem1>
		<li>
	        <a href="${config['site_menus_footer_' + menuItem1 + '_url']}">
	           <i class="${config['site_menus_footer_' + menuItem1 + '_icon']}">&nbsp;</i>${config['site_menus_footer_' + menuItem1 + '_label']}
	        </a>
		 </li>
	  </#list>
    </ul>
</div>
