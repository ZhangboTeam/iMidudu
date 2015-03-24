<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">



   <section id="main" class="column">
        <div class="submit_link2">
					<select>
						<option>不凡帝</option>
						
					</select>
					
				</div>
		
         <article class="module width_full">
            <header>
                <h3 class="tabs_involved">Show</h3>

            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
         <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT [Amount], [UserName], [Mobile], [ReceiptDate], [RecentLoginDate], [GroupName] FROM [ViewBonusHistory] WHERE ([ActivityName] = @ActivityName)">
            <SelectParameters>
                <asp:Parameter DefaultValue="不凡帝1" Name="ActivityName" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>               
          <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>                 
                    <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>

                                <th>用户分组</th>
                                <th>用户姓名</th>
                                <th>电话</th>
                                <th>登录时间</th>
                                <th>获取红包金额</th>
                                <th>获取时间</th>

                            </tr>
                        </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                        <tbody>
                            <tr>

                                <td><%#Eval("GroupName") %></td>
                                <td><%#Eval("UserName") %></td>
                                <td><%#Eval("Mobile") %></td>
                                <td><%#Eval("RecentLoginDate") %></td>
                                <td><%#Eval("Amount") %></td>
                                <td><%#Eval("ReceiptDate") %></td>


                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>


                        </tbody>
                    </table>
                        </FooterTemplate>
                                    </asp:Repeater>
                 
                          
                    <footer>
                        <div class="submit_link">
                            <input type="submit" value="导出表格" class="alt_btn">
                        </div>
                    </footer>              </div><!-- end of #tab1 -->

                

            </div><!-- end of .tab_container -->
		
	</section>

        </article>


</asp:Content>
