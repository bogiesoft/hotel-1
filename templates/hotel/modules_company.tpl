<!DOCTYPE html>
<html lang="en">
<head>
<%include file="hotel/inc/head.tpl"%>
</head>
<body>
<%include file="hotel/inc/top_menu.tpl"%>
<div id="content">
<%include file="hotel/inc/navigation.tpl"%>
<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12">
            <div class="widget-box">
                <div class="widget-title">
                    <span class="icon">
                        <i class="icon-th-list"></i>
                    </span>
                    <h5><%$arrayLaguage['list_of_companies']['page_laguage_value']%></h5>
                    <%if $arrayRoleModulesEmployee['role_modules_action_permissions']> 0%>
                    <div class="buttons">
                    	<%if $addCompanyPermission['role_modules_action_permissions'] > 1%>
                        <a class="btn btn-primary btn-mini" href="<%$addCompanyUrl%>" id="add_company"><i class="am-icon-plus-square"></i> <%$arrayLaguage['company_add']['page_laguage_value']%></a>
                        <%/if%>
                    </div>
                    <%/if%>
                </div>
                <div class="widget-content nopadding">
                    <ul class="recent-posts">
                      <%section name=company loop=$arrayCompany%>
                      <li>
                        <div class="user-thumb"> <img width="50" height="50" alt="User" src="<%$__RESOURCE%>img/icons/50/company.jpg"> </div>
                        <div class="article-post">
                          <div class="fr">
                          	<a href="<%$arrayCompany[company].view_url%>" class="btn btn-primary btn-mini"><i class="am-icon-eye"></i> 
                            	<%$arrayLaguage['view']['page_laguage_value']%>
                            </a> 
                            <%if $arrayRoleModulesEmployee['role_modules_action_permissions'] > 1%>
                          	<a href="<%$arrayCompany[company].edit_url%>" class="btn btn-primary btn-mini"><i class="am-icon-edit"></i> Edit</a> 
                            <%/if%>
                            <%if $arrayRoleModulesEmployee['role_modules_action_permissions'] > 2%>
                            <a href="#modal_delete" url="<%$arrayCompany[company].delete_url%>" class="btn btn-danger btn-mini" data-toggle="modal"><i class="am-icon-trash-o"></i> Delete</a>
                            <%/if%>
                          </div>
                          <h5><%$arrayCompany[company].company_name%></h5>
                          <p>
                          	<span class="icon-time" title="添加时间"></span> <%$arrayCompany[company].company_add_date%> 　
                          	<%if $arrayCompany[company].company_phone!=''%><span class="am-icon-phone"></span> <%$arrayCompany[company].company_phone%><%/if%> 　
                          	<%if $arrayCompany[company].company_mobile!=''%><span class="am-icon-mobile"></span> <%$arrayCompany[company].company_mobile%><%/if%> 　
                          </p>
                          
                        </div>
                      </li>
                      <%/section%>
                      
                      <li></li>
                    </ul> 
  					<div class="pagination  pagination-centered">
                      <ul>
                      <%section name=pn loop=$page%>
                      	<%if $smarty.section.pn.first%>
                      		<li<%if $page[pn].pn==''%> class="active"<%/if%>><a href="<%$page[pn].url%>">Prev</a></li>
                        <%elseif $smarty.section.pn.last%>
                            <li<%if $page[pn].pn==''%> class="active"<%/if%>><a href="<%$page[pn].url%>">Next</a></li>
                         <%else%>
                         	<li<%if $page[pn].pn==$pn%> class="active"<%/if%>><a href="<%$page[pn].url%>"><%$page[pn].pn%></a></li>
                        <%/if%>
                      <%/section%>
                      </ul>
                    </div>
                </div>
            </div>

            
        </div>
					
	  </div>
    
    </div>
</div>
</div>
<%include file="hotel/inc/footer.tpl"%>
<%include file="hotel/inc/modal_box.tpl"%>
<script laguage="javascript">
$(document).ready(function(){
	var company_delete_url = '';
	// Form Validation
    $("#delete_sumbit").click(function(){
		$.getJSON(company_delete_url,function(data, status){
			//alert("Data: " + data + "\nStatus: " + status);
			if(data.success == 1) {
				$('#modal_success').modal('show');
				$('#modal_success_message').html(data.message);
			} else {
				$('#modal_fail').modal('show');
				$('#modal_fail_message').html(data.message);
			}
		});
	});
	$(".btn.btn-danger.btn-mini").click(function(){
		company_delete_url = $(this).attr("url");
	});
	$('#myModal').on('hide.bs.modal', function() {
        window.location.reload();
    });
})
</script>
</body>
</html>