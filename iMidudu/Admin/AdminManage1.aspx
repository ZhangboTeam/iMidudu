<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<script type="text/javascript">
    $(function () {
        $('.column').equalHeight();
    });



    $("#submit").click(
       function () {
           var UserName = $("#username").val();
           var Password = $("#password").val();
           if (UserName == "") {
               alert("请输入姓名"); return;
           }
           if (PassWord == "") {
               alert("请输入密码"); return;
           }
           $.post("/WebService.asmx/UpdateManager",
               {
                   LoginName: UserName,
                   Password: Password,
               }, function (data) {

               });
           var r = $(data).text();
           if (r == "OK") {
               window.location = "/AdminManage.aspx";
           }
           else {
               alert(r);
           }

       });

</script>



<section id="main" class="column">
		
        <article class="module width_full">
		<header><h3 class="tabs_involved"></h3>
		<ul class="tabs">
   			<li><a href="#tab1">Show</a></li>
    		<%--<li><a href="#tab2">Edit</a></li>--%>
            <a href="WebForm1.aspx" target="_blank">Edit</a>
		</ul>
		</header>


		<div class="tab_container">
			<div id="tab1" class="tab_content">
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT [Password], [LoginName] FROM [SystemUser]"></asp:SqlDataSource>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 

    				<th>用户名</th> 
    				<th>密码</th> 
				</tr> 
			</thead> 
			<tbody> 
                                        </HeaderTemplate>
                        <ItemTemplate>
				<tr> 

    				<td><label><%#Eval("LoginName") %></label></td> 
    				<td><label><%#Eval("Password") %></label></td> 
    				
				</tr> 
				
                        </ItemTemplate>
                        <FooterTemplate>


                        </tbody>
                    </table>
                        </FooterTemplate>
                                    </asp:Repeater>
			</div><!-- end of #tab1 -->
			
			<div id="tab2" class="tab_content">
			<table class="tablesorter" cellspacing="0"> 
			    <fieldset>
                                <label>用户名</label>
                                <input type="text" id="username" style="width:30%"><br /><br />
                                <p></p>
                                <p></p>
                                <label>密码</label>
                                <input type="text"id="password" style="width:30%">
                            </fieldset>


                            <footer>
                                <div class="submit_link">
                                    <input type="submit" id="submit" value="确定" class="alt_btn">
                                </div>
                            </footer> 
			</table>

			</div><!-- end of #tab2 -->
			
		</div><!-- end of .tab_container -->
		
		</article><!-- end of content manager article -->
		
	    
		
	</section>

</asp:Content>
