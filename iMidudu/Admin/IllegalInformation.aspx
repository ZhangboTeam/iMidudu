<%@ Page Title="非法领取红包人的信息" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">


    <script>
        function DownLoad() {
            var content = $("#content").html();
            var data = { body: content };
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/ExcelContentSaveToTemp",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (fn) {

                    var url = "/Admin/OutExcel.ashx?filename=非法领取.xls&ContentFile=" + fn.d;
                    window.open(url, "_blank");
                }
            });


        }
    </script>



    <section id="secondary_bar">

            <div class="breadcrumbs_container">
                <article class="breadcrumbs">
                    <a class="current">红包历史查看</a>
                    <div class="breadcrumb_divider"></div>
                    <a class="current2">非法领取人的信息</a>
                </article>
            </div>
        </section>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT MembershipInfo.UserName, MembershipInfo.Sex, MembershipInfo.Mobile, MembershipInfo.Country, MembershipInfo.Province, MembershipInfo.City, MembershipInfo.Nickname, MembershipInfo.RecentLoginDate, MembershipInfo.RegDate, Activity.ActivityName, BadBonusHistory.ReceiptDate, BadBonusHistory.BonusCode FROM BadBonusHistory INNER JOIN Activity ON BadBonusHistory.AcitvityId = Activity.AcitvityId INNER JOIN MembershipInfo ON BadBonusHistory.OpenId = MembershipInfo.OpenId"></asp:SqlDataSource>
            <article class="module width_full">
            <header>
                <h3 class="tabs_involved">非法领取红包人的信息</h3>
            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <div  id="content">
         <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            
                    <HeaderTemplate>
                           <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>
                            <th>非法码</th>
                            <th>验证用户名</th>
                            <th>微信昵称</th>
                            <th>性别</th>
                            <th>手机</th>
                            <th>国家</th>
                            <th>省</th>
                            <th>市（区）</th>
                            <th>活动名称</th>
                            <th>领取时间</th>
                            <th>最近登录时间</th>
                            <th>注册时间</th>
                            </tr>
                        </thead>
                        </HeaderTemplate>
                        <ItemTemplate>
                        <tbody>
                            <tr>
                            <td>       <%#Eval("BonusCode") %>   </td>
                            <td>       <%#Eval("UserName") %>   </td>
                            <td>       <%#Eval("Nickname") %>   </td>
                            <td>       <%#Eval("Sex").ToString()=="1"?"男":"女" %>  </td>
                            <td>       <%#Eval("Mobile") %>   </td>
                            <td>       <%#Eval("Country") %>   </td>
                            <td>       <%#Eval("Province") %>   </td>
                            <td>       <%#Eval("City") %>   </td>
                            <td>       <%#Eval("ActivityName") %>   </td>
                            <td>       <%#Eval("ReceiptDate") %>   </td>
                            <td>       <%#Eval("RecentLoginDate") %>   </td>
                            <td>       <%#Eval("RegDate") %>   </td>
                            </tr>
                        </tbody>
                        </ItemTemplate>
                        <FooterTemplate>


                        </tbody>
                    </table>
                        </FooterTemplate>
                                    </asp:Repeater>
            </div>

                    <footer>
                        <div class="submit_link">
                            <input type="submit" value="导出表格" class="alt_btn" onclick="DownLoad();">
                        </div>
                    </footer>
                </div><!-- end of #tab1 -->



            </div><!-- end of .tab_container -->

        </article>
</asp:Content>
