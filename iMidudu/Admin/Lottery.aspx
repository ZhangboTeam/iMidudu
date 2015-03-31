<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<script>
        $(function () {
            $("#doLottery").click(
             function () {
                 $("#doLottery").hide();
                 $.post("/WebService.asmx/Lottery",
                      function (data) {
                          var OpenId1 = $(data).text().toString();
                          window.location.reload();
                      });
             });
        })
</script>
    <input type="submit" value="抽奖" id="doLottery"  class="alt_btn"/>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT * FROM [MembershipInfo] WHERE ([OpenId] = @OpenId)">
        <SelectParameters>
            <asp:SessionParameter Name="OpenId" SessionField="OpenId" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    
      <article class="module width_full">
            <header>
                <h3 class="tabs_involved">中奖用户</h3>

            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">

                <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                    <HeaderTemplate>
                    <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>

                                <th>验证用户名</th>
                                <th>微信昵称</th>
                                <th>性别</th>
                                <th>手机</th>
                                <th>国家</th>
                                <th>省</th>
                                <th>市（区）</th> 
                                <th>最近登录时间</th>
                                <th>注册时间</th>
                            </tr>
                        </thead>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tbody>
                            <tr>

                            <td>       <%#Eval("UserName") %>   </td>
                            <td>       <%#Eval("Nickname") %>   </td>
                            <td>       <%#Eval("Sex").ToString()=="1"?"男":"女" %>  </td>
                            <td>       <%#Eval("Mobile") %>   </td>
                            <td>       <%#Eval("Country") %>   </td>
                            <td>       <%#Eval("Province") %>   </td>
                            <td>       <%#Eval("City") %>   </td> 
                                <td><%#Eval("RecentLoginDate")%></td>
                                <td><%#Eval("RegDate")%></td>
                           
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        
                    </tbody>
                </table>
                    </FooterTemplate>
           </asp:Repeater>

        </article>

&nbsp;
</asp:Content>
