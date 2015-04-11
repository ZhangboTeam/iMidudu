<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">

    <script>
        function DownLoad() {
            var sql = "select OpenId as OpenID,UserName as 验证用户名,Nickname as 微信昵称,Mobile as 手机,LotteryDate as 中奖时间,Country as 国家,Province as 省,City as 市 ,RecentLoginDate as 最近登录时间,RegDate as 注册时间 from ViewAllPrize ";
            var url = "/Admin/OutExcelDown.ashx?filename=抽中纪录<%=DateTime.Now.ToString("yyyy-MM-dd-HH-mm-ss")%>.xls&sql=" + sql;
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

                    var url = "/Admin/OutExcel.ashx?filename=中奖用户.xls&ContentFile=" + fn.d;
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
                    <a class="current2">抽中纪录</a>
                </article>
            </div>
        </section>
		<article class="module width_full">
		<header>
           <h3 class="tabs_involved">抽中纪录</h3>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT Lottery.LotteryDate, MembershipInfo.OpenId, MembershipInfo.UserName, MembershipInfo.Mobile, MembershipInfo.RegDate, MembershipInfo.Country, MembershipInfo.Province, MembershipInfo.City, MembershipInfo.Nickname, MembershipInfo.Pic, MembershipInfo.RecentLoginDate, MembershipInfo.Sex FROM MembershipInfo INNER JOIN Lottery ON MembershipInfo.OpenId = Lottery.OpenId"></asp:SqlDataSource>      
                <div  id="content">          		                       
                 <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th>OpenID</th> 
    				<th>验证用户名</th> 
    				<th>微信昵称</th> 
                    <th>手机</th>
                    <th>中奖时间</th>
                    <th>国家</th>
                    <th>城市</th>
                    <th>市（区）</th>
                    <th>最近登陆时间</th>
                    <th>注册时间</th>
                    
				</tr> 
			</thead> 
                </HeaderTemplate>
                <ItemTemplate>
			<tbody> 
				<tr> 
    				<td><%#Eval("OpenId") %></td> 
    				<td><%#Eval("UserName") %></td> 
    				<td><%#Eval("Nickname") %></td> 
                    <td><%#Eval("Mobile") %></td> 
                    <td><%#Eval("LotteryDate") %></td>
                    <td><%#Eval("Country") %></td>
                    <td><%#Eval("Province") %></td>
                    <td><%#Eval("City") %></td>
                    <td><%#Eval("RecentLoginDate") %></td>
                    <td><%#Eval("RegDate") %></td>

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
                </footer>
			</div><!-- end of #tab1 -->				
		</article>
</asp:Content>
