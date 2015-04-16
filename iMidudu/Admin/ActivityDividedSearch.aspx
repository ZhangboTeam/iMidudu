<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script runat="server">
        private int totalCount;
        private string ky = "";
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            ky = this.Request["key"];
            if (!IsPostBack)
            {
                this.LoadData();
                AspNetPager1.RecordCount = totalCount;
                //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
            }
        }
        private System.Data.SqlClient.SqlDataReader LoadData()
        {

            var key = (ky == null ? "" : ky);
            totalCount = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(*) from ViewBonusHistory where ActivityName=@key", new System.Data.SqlClient.SqlParameter("@key", key));
            var dr =iMidudu.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("ActivityDivideSearch_Procedure",
               new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
               new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
               new System.Data.SqlClient.SqlParameter("@key", key)
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
            function change() {
                var k = $("#Name").val();
                if (k == null || k == "") {
                }

                window.location.href = "ActivityDividedSearch.aspx?key=" + k;
            }
            function DownLoad() {
                var k = $("#key").val();
                var sql = "select GroupName as 用户分组,ActivityName as 活动名,UserName as 验证用户名,Mobile as 手机,RecentLoginDate as 登录时间,Amount as 领取金额,ReceiptDate as 领取时间 from ViewBonusHistory where ActivityName='<%=this.Request["key"]%>' order by ReceiptDate desc  ";
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

    <div align="center">

             <td>
          </td>
           <%--<td>
                        	<div class="smgSelectWrap" id="issueSmg">
                        		<div class="smgSelectText f-toe f-usn"></div>
                                <input type="hidden" />
                                <div class="smgSelectListWrap">
                                </div>
                        	</div>
          </td>--%>
    </div>
    <div align="center">
    <select name="" onchange="change();" id="Name" class="form_select">
                            <option value="" selected="">请选择活动</option>
                            <%
                                var data1 = iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select ActivityName from Activity where AcitvityId='53c9b412-d1a5-44a6-957f-b948cd54ce86'").ToString();
                                var data2 = iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select ActivityName from Activity where AcitvityId='53c9b412-d1a5-44a6-957f-b948cd54ce87'").ToString();
                                //foreach (var item in data)
                              {%>
                            <option value="<%=data1%>"><%=data1%></option>
                            <option value="<%=data2%>"><%=data2%></option>
                            <%} %>
                        </select>
    </div>
        <div  class="submit_link2" >
                        
				</div>
		
         <article class="module width_full">
            <header>
                <h3 class="tabs_involved">按活动查询/h3>

            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
         <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT [Amount], [UserName], [Mobile], [ReceiptDate], [RecentLoginDate], [GroupName] FROM [ViewBonusHistory] WHERE ([ActivityName] = @ActivityName)">--%>
                    <%--DataSourceID="SqlDataSource1"--%>
           <%-- <SelectParameters>
                <asp:Parameter DefaultValue="不凡帝1" Name="ActivityName" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource> --%>  
                    <div  id="content">            
          <asp:Repeater ID="Repeater1" runat="server" >
                <HeaderTemplate>                 
                    <table class="tablesorter" cellspacing="0">
                        <thead>
                            <tr>

                                <th>用户分组</th>
                                <th>活动名</th>
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
                                <td><%#Eval("ActivityName") %></td>
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
                    </footer>              </div><!-- end of #tab1 -->

                

            </div><!-- end of .tab_container -->
		


        </article>


</asp:Content>
