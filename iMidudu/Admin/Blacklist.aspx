<%@ Page Title="黑名单" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">

		<article class="module width_full">
		<header>
		<ul class="tabs">
   			<li><a href="#tab1">Show</a></li>
    		<li><a href="#tab2">Create</a></li>
		</ul>



		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT TMembershipInfo.OpenId, MembershipInfo.UserName, MembershipInfo.Mobile, MembershipInfo.Nickname, MembershipInfo.RecentLoginDate FROM TMembershipInfo INNER JOIN MembershipInfo ON TMembershipInfo.OpenId = MembershipInfo.OpenId"></asp:SqlDataSource>                		                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th>OpenID</th> 
    				<th>用户名</th> 
    				<th>微信名</th> 
                    <th>电话</th>
                    <th>最近登录时间</th>
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
                    <td><%#Eval("RecentLoginDate") %></td>
    			
				</tr> 
                        </ItemTemplate>
                        <FooterTemplate>


                        </tbody>
                    </table>
                        </FooterTemplate>
                                    </asp:Repeater>
			</div><!-- end of #tab1 -->
			
			<div id="tab2" class="tab_content">
			<table class="tablesorter2" cellspacing="0"> 
			    
                <fieldset>
                                <label>OpenID</label>
                                <input type="text" id="AcitvityId"style="width:30%"/><br /><br />
                            </fieldset>


                            <footer>
                                <div class="submit_link">
                                    <input type="submit" value="确定" id="createactivity" class="alt_btn"/>
                                </div>
                            </footer>
			</table>

			</div><!-- end of #tab2 -->
			
		</div><!-- end of .tab_container -->
		
		</article><!-- end of content manager article -->
		
</asp:Content>
