<%@ Page Title="按时间查询" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>
<script runat="server"> 

    private int totalCount;
    private int totalCount2;
    private int totalCount50;
    private int totalOpenId;
    private double totalMoney;

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        if (!IsPostBack)
        {
            if (string.IsNullOrEmpty(this.Request["key1"]) ||string.IsNullOrEmpty(this.Request["key2"]))
            {
                return;
            }
            this.LoadData();
            AspNetPager1.RecordCount = totalCount;
            //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
        }
    }

    private System.Data.SqlClient.SqlDataReader LoadData()
    {
        var keyb = new System.Data.SqlClient.SqlParameter("@beginDate", DateTime.Parse(this.Request["key1"]));
        var keye = new System.Data.SqlClient.SqlParameter("@endDate", DateTime.Parse(this.Request["key2"]).AddDays(1));;
        Console.WriteLine(DateTime.Parse(this.Request["key2"]));
        var cmd = new System.Data.SqlClient.SqlCommand();
        var cn = new System.Data.SqlClient.SqlConnection(System.Web.Configuration.WebConfigurationManager.AppSettings["con"]);
        cmd.Connection = cn;
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        cmd.CommandText = "usp_UserSearchByDate1";
        cmd.Parameters.AddRange(new System.Data.SqlClient.SqlParameter[] {
           new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
           new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex),
           keyb,keye
        });
        cn.Open();
        var dr = cmd.ExecuteReader(System.Data.CommandBehavior.CloseConnection);
        var key4=this.Request["key2"];
        DateTime key3 = Convert.ToDateTime(key4);
        key3 = key3.AddDays(1);
        //string sql1 = string.Format("select  count(*) from ViewBonusHistory where receiptdate >='{0}' and receiptdate <'{1}'", this.Request["key1"], key3);
        string sql2 = string.Format("select  isnull(count(*),0) from ViewBonusHistory where receiptdate >='{0}' and receiptdate <'{1}'", this.Request["key1"], key3);
        string sql3 = string.Format("select  isnull(count(*),0) from ViewBonusHistory where Amount=2 and receiptdate >='{0}' and receiptdate <'{1}'", this.Request["key1"], key3);
        string sql4 = string.Format("select  isnull(count(*),0) from ViewBonusHistory where Amount=50 and receiptdate >='{0}' and receiptdate <'{1}'", this.Request["key1"], key3);
        string sql5 = string.Format("select  isnull(count(distinct([OpenId] )),0) from ViewBonusHistory  where receiptdate >='{0}' and receiptdate <'{1}'", this.Request["key1"], key3);
        string sql6 = string.Format("select  isnull(SUM(amount),0) from ViewBonusHistory where receiptdate >='{0}' and receiptdate <'{1}'", this.Request["key1"], key3);
        //this.totalCount = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText(sql1);

        this.totalCount = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText(sql2);
         this.totalCount2 = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText(sql3);
         this.totalCount50 = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText(sql4);
         this.totalOpenId = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText(sql5);
         try
         {
             this.totalMoney = (double)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText(sql6);
         }
         catch
         {
             this.totalMoney = 0;
         }
        return dr;
    }
    public override void DataBind()
    {
        if (string.IsNullOrEmpty(this.Request["key1"]) ||string.IsNullOrEmpty(this.Request["key1"]))
        {
            return;
        }
        if (string.IsNullOrEmpty(this.Request["key2"]) ||string.IsNullOrEmpty(this.Request["key2"]))
        {
            return;
        }
        this.Repeater1.DataSource = this.LoadData();
        base.DataBind();

    }


    protected void AspNetPager1_PageChanged(object src, EventArgs e)
    {
        this.DataBind();
    }
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script>

        function dosearch() {
            var key1 = $("#key1").val();
            var key2 = $("#key2").val();
            if (key1 == "" || key1 == null) {
               // return;
            }
            if (key2 == "" || key2 == null) {
               // return;
            }
            window.location = "TimeSearch.aspx?key1=" + key1 + "&key2=" + key2;
        }

        function DownLoad() {
            var k1 = $("#key1").val();
            var k2 = $("#key2").val();
            var sql = "select UserName as 验证用户名,Nickname as 微信昵称,Sex as 性别,Mobile as 手机, Country as 国家,Province as 省,City as 市, ActivityName as 活动名称,ReceiptDate as 领取时间,Amount as 领取金额 from ViewBonusHistory  where  ReceiptDate >=' " + k1 + "'   and ReceiptDate < '" + k2 + "'  ";
            var url = "/Admin/OutExcelDown.ashx?filename=扫码用户<%=DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss")%>.xls&sql=" + sql;
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

                var url = "/Admin/OutExcel.ashx?filename=时间搜索用户.xls&ContentFile=" + fn.d;
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
                    <a class="current2">按时段查询</a>
                </article>
            </div>
        </section>
        <div class="quick_search ">
            <%
                var d1=DateTime.Today.AddDays(-7).ToString("yyyy-MM-dd");
                var d2 = DateTime.Today.AddDays(0).ToString("yyyy-MM-dd");
                if (Request["key1"] != null) {
                    d1 = Request["key1"];
                    
                }
                if (Request["key2"] != null)
                {
                    d2 = Request["key2"];

                }
                 %>
            <input type="text" id="key1" value="<%=d1 %>" style="width:auto;" />
			<input type="text"id="key2" value="<%=d2 %>"  style="width:auto;"/>
                <input type="submit" value="搜索" onclick="dosearch();" class="alt_btn"/>
		</div> 
    <article class="module width_full">
        <header>
            <h3 class="tabs_involved">按时间查询 <%=d1 %>--<%=d2 %></h3>
        </header>
        <div class="tab_container">
            <div id="tab1" class="tab_content">
                 

<div  id="content">
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                            <table class="tablesorter" cellspacing="0">
                    <thead>
                        <tr>

                          <%--  <th>红包码</th>
                            <th>用户ID</th>--%>
                            <th>验证用户名</th>
                            <th>微信昵称</th>
                            <th>性别</th>
                            <th>头像</th>
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
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                           <%-- <td>       <%#Eval("BonusCode") %>   </td>
                            <td>       <%#Eval("OpenId") %>   </td>--%>
                            <td>       <%#Eval("UserName") %>   </td>
                            <td>       <%#Eval("Nickname") %>   </td>
                            <td>       <%#Eval("Sex").ToString()=="1"?"男":"女" %>  </td>
                            <td> <a href="<%#Eval("Pic") %>" target="_blank" ><img src='<%#Eval("Pic") %>' width="30" /> </a>  </td>
                            <td>       <%#Eval("Mobile") %>   </td>
                            <td>       <%#Eval("Country") %>   </td>
                            <td>       <%#Eval("Province") %>   </td>
                            <td>       <%#Eval("City") %>   </td>
                            <td>       <%#Eval("ActivityName") %>   </td>
                            <td>       <%#Eval("Amount") %>   </td>
                            <td>       <%#Eval("ReceiptDate") %>   </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        
                    </tbody>
                </table>
                    </FooterTemplate>
                </asp:Repeater>
    </div>
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" Width="100%" UrlPaging="true" ShowPageIndexBox="Always" PageIndexBoxType="DropDownList"  
                    FirstPageText="【首页】"
    LastPageText="【尾页】" NextPageText="【后页】"
        PrevPageText="【前页】" NumericButtonTextFormatString="【{0}】"   TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到第"  HorizontalAlign="right" PageSize="10" OnPageChanged="AspNetPager1_PageChanged" EnableTheming="true" CustomInfoHTML="Page  <font color='red'><b>%CurrentPageIndex%</b></font> of  %PageCount%  Order %StartRecordIndex%-%EndRecordIndex%">
                </webdiyer:AspNetPager>
            </div>
            <!-- end of #tab1 -->



        </div>
        <!-- end of .tab_container -->
        <footer>
            <div class="post_message">
                <label>汇总：&nbsp&nbsp&nbsp&nbsp 有</label>
                <label><%#totalOpenId %></label>
                <label>人领取红包&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 共领取</label>
                <label><%#totalMoney %></label>
                <label>元&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 2元的</label>
                <label><%#totalCount2 %></label>
                <label>份&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 50元的 </label>
                <label><%#totalCount50 %></label>
                <label>份</label>

            </div>
            <div class="submit_link">
                <input type="submit" value="导出表格" class="alt_btn" onclick="DownLoad();"/>
            </div>
        </footer>
    </article>


</asp:Content>
