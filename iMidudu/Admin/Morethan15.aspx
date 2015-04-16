<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script runat="server">
            private int totalCount;
            private string ky = "";
            protected override void OnLoad(EventArgs e)
            {
                base.OnLoad(e);
                if (!IsPostBack)
                {
                    this.LoadData();
                    AspNetPager1.RecordCount = totalCount;
                    //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
                }
            }
            private System.Data.SqlClient.SqlDataReader LoadData()
            {
                totalCount = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from ViewMembershipInfo where TotalCount>=15  ");
                var dr = iMidudu.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("Morethan_Procedures",
                   new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
                   new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex)
                   );
                return dr;
            }
            public override void DataBind()
            {
                this.Repeater1.DataSource = this.LoadData();
                base.DataBind();

            }


            protected void AspNetPager1_PageChanged(object src, EventArgs e)
            {
                this.DataBind();
            }
        </script>


    <script>
        function DownLoad() {
            var sql = "select UserName as 验证用户名,Nickname as 微信昵称,Mobile as 手机, Country as 国家,Province as 省,City as 市区,ActivityName as 活动名称,TotalAmount as 领取总金额,TotalCount as 领取总次数 from ViewMembershipInfo where TotalCount>=15 order by TotalCount DESC";
            var url = "/Admin/OutExcelDown.ashx?filename=领取次数超过15次<%=DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss")%>.xls&sql=" + sql;
           // alert(sql);
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

                    var url = "/Admin/OutExcel.ashx?filename=领取次数超过15次.xls&ContentFile=" + fn.d;
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
                    <a class="current2">领取金额超过15</a>
                </article>
            </div>
        </section>
        <article class="module width_full">
            <header>
                <h3 class="tabs_involved">领取金额超过15 </h3>
            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
                                    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT [UserName], [Nickname], [TotalAmount], [TotalCount], [Mobile], [Country], [Province], [City], [ActivityName] FROM [ViewMembershipInfo] WHERE ([TotalCount] &gt;= @TotalCount) ORDER BY [TotalCount] DESC">
                                        <SelectParameters>
                                            <asp:Parameter DefaultValue="15" Name="TotalCount" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>--%>
                <div id="content">                  
                    <asp:Repeater ID="Repeater1" runat="server" >
                        <HeaderTemplate>
   <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>
                                <th>验证用户名</th>
                                <th>微信昵称</th>
                                <th>手机</th>
                                <th>国家</th>
                                <th>省</th>
                                <th>市(区)</th>
                                <th>活动名称</th>
                                <th>领取总金额</th>
                                <th>领取总次数</th>
                            </tr>
                        </thead>
                        <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                              <tr>
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

                    <webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" ShowPageIndexBox="Always" PageIndexBoxType="DropDownList" ShowCustomInfoSection="Left"
                    FirstPageText="【首页】"
                    LastPageText="【尾页】" NextPageText="【后页】"
                    PrevPageText="【前页】" NumericButtonTextFormatString="【{0}】" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到第" HorizontalAlign="right" PageSize="10" OnPageChanged="AspNetPager1_PageChanged" EnableTheming="true" CustomInfoHTML="当前第  <font color='red'><b>%CurrentPageIndex%</b></font> 页,共  %PageCount%  页 ,总共:%RecordCount% 条数据">
                </webdiyer:AspNetPager>
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
