<%@ Page Title="领取次数TOP10" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
            
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="Data Source=121.40.166.159\SQLExpress;Initial Catalog=iMidudu;User ID=sa;Password=123456" ProviderName="System.Data.SqlClient" SelectCommand="SELECT top 10 [Nickname], [UserName], [Mobile], [Country], [Province], [City], [ActivityName], [TotalAmount], [TotalCount] FROM [ViewMembershipInfo] ORDER BY [TotalCount] DESC"></asp:SqlDataSource>
            <article class="module width_full">
            <header>
                <h3 class="tabs_involved">领取次数TOP10</h3>
            </header>                
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                                <HeaderTemplate>
   <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>
                                <th>排名</th> 
                                <th>用户名</th>
                                <th>微信用户名</th>
                                <th>手机</th>
                                <th>国家</th>
                                <th>省</th>
                                <th>市(区)</th>
                                <th>活动名称</th>
                                <th>领取总金额</th>
                                <th>领取次数</th>
                            </tr>
                        </thead>
                        <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                              <tr>
                                <td><%# Container.ItemIndex+1 %></td> 
                                <td>   <%#Eval("UserName") %> </td>
                                <td>   <%#Eval("NickName") %> </td>
                                <td>   <%#Eval("Mobile") %> </td>
                                <td>   <%#Eval("Country") %> </td>
                                <td>   <%#Eval("Province") %> </td>
                                <td>   <%#Eval("City") %> </td>
                                <td>   <%#Eval("ActivityName") %> </td>
                                <td>   <%#Eval("TotalAmount") %> </td>
                                <td>   <%#Eval("TotalCount") %> 
                                </td>
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
                    </footer>
                </div><!-- end of #tab1 -->



            </div><!-- end of .tab_container -->

        </article>
</asp:Content>
