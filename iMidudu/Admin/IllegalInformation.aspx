<%@ Page Title="非法领取红包人的信息" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
            <article class="module width_full">
            <header>
                <h3 class="tabs_involved">非法领取红包人的信息</h3>
            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                    <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>
                            <th>用户名</th>
                            <th>微信用户名</th>
                            <th>手机</th>
                            <th>国家</th>
                            <th>省</th>
                            <th>市（区）</th>
                            <th>活动名称</th>
                            <th>领取金额</th>
                            <th>领取时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                            <td>       <%#Eval("UserName") %>   </td>
                            <td>       <%#Eval("Nickname") %>   </td>
                            <td>       <%#Eval("Mobile") %>   </td>
                            <td>       <%#Eval("Country") %>   </td>
                            <td>       <%#Eval("Province") %>   </td>
                            <td>       <%#Eval("City") %>   </td>
                            <td>       <%#Eval("ActivityName") %>   </td>
                            <td>       <%#Eval("Amount") %>   </td>
                            <td>       <%#Eval("ReceiptDate") %>   </td>
                            </tr>
                        </tbody>
                    </table>
                </div><!-- end of #tab1 -->



            </div><!-- end of .tab_container -->

        </article>

</asp:Content>
