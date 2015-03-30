<%@ Page Title="黑名单" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<script>
    function MoveOutBlickList(openid) {
        //alert(openid);
        var data={
            OpenId:openid
        };
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/Webservice.asmx/MoveOutOfBlickList",
            data: JSON.stringify(data),
            dataType: 'json',
            success: function (result) {                  
                window.location.reload();
            },
            error:function(err){
                alert(err);
            }
        });
    }


</script>
    <section id="secondary_bar">

            <div class="breadcrumbs_container">
                <article class="breadcrumbs">
                    <a class="current">数据管理</a>
                    <div class="breadcrumb_divider"></div>
                    <a class="current2">黑名单管理</a>
                </article>
            </div>
        </section>
		<article class="module width_full">
		<header>
           <h3 class="tabs_involved">黑名单</h3>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT * FROM [Blacklist]"></asp:SqlDataSource>                		                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th>OpenID</th> 
    				<th>验证用户名</th> 
    				<th>微信昵称</th> 
                    <th>手机</th>
                    <th>头像</th>
                    <th>国家</th>
                    <th>城市</th>
                    <th>市（区）</th>
                    <th></th>
                    
				</tr> 
			</thead> 
                </HeaderTemplate>
                <ItemTemplate>
			<tbody> 
				<tr> 
    				<td><%#Eval("OpenId") %></td> 
    				<td><%#Eval("UserName") %></td> 
    				<td><%#Eval("Nickname") %></td> 
                    <td><%#Eval("Mobile") %></td> 
                    <td><a href="<%#Eval("Pic") %>" target="_blank" ><img src='<%#Eval("Pic") %>' width="30" /> </a> </td>
                    <td><%#Eval("Country") %></td>
                    <td><%#Eval("Province") %></td>
                    <td><%#Eval("City") %></td>
    	<td><input type="image" src="images/icn_trash.png"  title="移出黑名单" onclick="MoveOutBlickList('<%#Eval("OpenId") %>');">
				</tr> 
                        </ItemTemplate>
                        <FooterTemplate>


                        </tbody>
                    </table>
                        </FooterTemplate>
                                    </asp:Repeater>
			</div><!-- end of #tab1 -->				
		</article><!-- end of content manager article -->
		
</asp:Content>
