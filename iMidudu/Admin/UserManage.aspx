<%@ Page Title="所有用户" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>

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
            this.LoadData();
            AspNetPager1.RecordCount = totalCount;
            //bindData(); //使用url分页，只需在分页事件处理程序中绑定数据即可，无需在Page_Load中绑定，否则会导致数据被绑定两次
        }
    }

    private System.Data.SqlClient.SqlDataReader LoadData()
    {


        var dr = iMidudu.SystemDAO.SqlHelper.ExecuteReaderFromStoredProcedure("eusp_AllMembershipV2", 
           new System.Data.SqlClient.SqlParameter("@startIndex", AspNetPager1.StartRecordIndex),
           new System.Data.SqlClient.SqlParameter("@endIndex", AspNetPager1.EndRecordIndex) 
           );

        this.totalCount = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(count(*),0) from ViewAllMembership ");
        this.totalCount2 = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(sum(totalcount2),0) from ViewAllMembership  ");
        this.totalCount50 = (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(sum(totalcount50),0) from ViewAllMembership  ");

        this.totalMoney = (double)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(SUM(totalamount),0) from ViewAllMembership ");
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



<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
    <script>
        function dosearchByName() {
            var k = $("#key1").val();
            window.location.href = "UserMangeByName.aspx?key=" + k;
        }
        function dosearchByTel() {
            var k = $("#key1").val();
            window.location.href = "UserMangeByTel.aspx?key=" + k;
        }
        function deleteUser(openid) {
            //alert(openid);
            var data={
                OpenId:openid
            };
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/DeleteUser",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {                  
                    window.location.reload();
                },
                error:function(err){
                    alert("不能删除已经领取过红包的用户");
                }
            });
        }
        function blockUser(openid) {
    
            var data={
                OpenId:openid
            };
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/Webservice.asmx/joinBlacklist",
                data: JSON.stringify(data),
                dataType: 'json',
                success: function (result) {                  
                    window.location.reload();
                },
                error:function(err){
                    alert(err);
                }
            });

        }

    function DownLoad() {
        var k = $("#key1").val();
        var sql = "select UserName as 验证过的用户,Nickname as 微信昵称,Sex as 性别,Mobile as 手机, Country as 国家,Province as 省,City as 市区,TotalAmount as 领取金额,TotalCount as 领取数量,RecentLoginDate as 最近登录时间,RegDate as 注册时间 from ViewAllMembership ";       
        var url = "/Admin/OutExcelDown.ashx?filename=扫码用户<%=DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss")%>.xls&sql=" + sql;
        alert(sql);
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

                var url = "/Admin/OutExcel.ashx?filename=所有用户.xls&ContentFile=" + fn.d;
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
                    <a class="current2">验证过的用户</a>
                </article>
            </div>
        </section>
     <div class="quick_search ">
            <input type="text" id="key1"   style="width:auto;"  />
                <input type="submit" value="按用户名搜索" onclick="dosearchByName();" class="alt_btn"/> 
                <input type="submit" value="按电话搜索" onclick="dosearchByTel();" class="alt_btn"/>
		</div> 
            <article class="module width_full">
            <header>
                <h3 class="tabs_involved">所有用户</h3>

            </header>
            <div class="tab_container">
                <div id="tab1" class="tab_content">
<div  id="content">
                <asp:Repeater ID="Repeater1" runat="server">
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
                                <th>领取金额</th>
                                <th>领取数量</th>
                                <th>最近登录时间</th>
                                <th>注册时间</th>
                                <th></th>
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
                                <td>   <%#Eval("TotalAmount") %> </td>
                                <td>   <%#Eval("TotalCount") %> </td>
                                <td><%#Eval("RecentLoginDate")%></td>
                                <td><%#Eval("RegDate")%></td>
                                   <td><input type="image" src="images/icn_trash.png"  title="删除用户" onclick="deleteUser('<%#Eval("OpenId") %>');">
                                       <input type="image" src="images/icn_logout.png"  title="加入黑名单" onclick="blockUser('<%#Eval("OpenId") %>');"></td>
                           
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
            </div><!-- end of #tab1 -->

                

            </div><!-- end of .tab_container -->
        <footer>
            <div class="post_message">
                <label>汇总：&nbsp&nbsp&nbsp&nbsp 有</label>
                <label><%#totalCount %></label>
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
