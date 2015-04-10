<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">

        <script>
            function DownLoad() {
                var k = $("#key").val();
                var sql = "select GroupName as 用户分组,UserName as 验证用户名,Mobile as 手机,RecentLoginDate as 最近登录时间,Amount as 领取金额,ReceiptDate as 领取时间 from ViewActivityGroup  ";
                var url = "/Admin/OutExcelDown.ashx?filename=活动分组用户<%=DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss")%>.xls&sql=" + sql;
                 //alert(sql);
            window.open(url);
            return;
                var content = $("#content").html();
                var data = { body: content };
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "/Webservice.asmx/ExcelContentSaveToTemp",
                    data: JSON.stringify(data),
                    dataType: 'json',
                    success: function (fn) {

                        var url = "/Admin/OutExcel.ashx?filename=用户分组.xls&ContentFile=" + fn.d;
                        window.open(url, "_blank");
                    }
                });


            }
    </script>


    <section id="secondary_bar">

            <div class="breadcrumbs_container">
                <article class="breadcrumbs">
                    <a class="current">数据管理</a>
                    <div class="breadcrumb_divider"></div>
                    <a class="current2">活动分组查看</a>
                </article>
            </div>
        </section>


        <div class="submit_link2">
					<select>
						<option>不凡帝1</option>
						
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
                    <div  id="content">            
          <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>                 
                    <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>

                                <th>用户分组</th>
                                <th>验证用户名</th>
                                <th>手机</th>
                                <th>登录时间</th>
                                <th>领取金额</th>
                                <th>领取时间</th>

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
                 
                          </div>
                    <footer>
                        <div class="submit_link">
                            <input type="submit" value="导出表格" class="alt_btn" onclick="DownLoad();">
                        </div>
                    </footer>              </div><!-- end of #tab1 -->

                

            </div><!-- end of .tab_container -->
		


        </article>


</asp:Content>
