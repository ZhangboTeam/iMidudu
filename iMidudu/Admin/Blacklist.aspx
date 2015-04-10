<%@ Page Title="黑名单" Language="C#" MasterPageFile="~/Admin/SiteAdmin.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageBody" runat="server">
<script>
    function MoveOutBlickList(openid) {
        //alert(openid);
        var data={
            OpenId:openid
        };
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "/Webservice.asmx/MoveOutOfBlickList",
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
        var sql = "select OpenID,UserName as 验证用户名,Nickname as 微信昵称,Mobile as 手机, Country as 国家,Province as 省,City as 市 from Blacklist  where OpenId=OpenId and UserName=UserName and NickName=NickName and Mobile=Mobile and Country=Country and Province=Province and City=City ";
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

                var url = "/Admin/OutExcel.ashx?filename=黑名单.xls&ContentFile=" + fn.d;
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
                    <a class="current2">黑名单管理</a>
                </article>
            </div>
        </section>
		<article class="module width_full">
		<header>
           <h3 class="tabs_involved">黑名单</h3>
		</header>

		<div class="tab_container">
			<div id="tab1" class="tab_content">
                <div  id="content">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:iMiduduConnectionString %>" SelectCommand="SELECT * FROM [Blacklist]"></asp:SqlDataSource>                		                        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                <HeaderTemplate>
			<table class="tablesorter" cellspacing="0"> 
			<thead> 
				<tr> 
    				<th>OpenID</th> 
    				<th>验证用户名</th> 
    				<th>微信昵称</th> 
                    <th>手机</th>
                    <th>国家</th>
                    <th>城市</th>
                    <th>市（区）</th>
                    <th></th>
                    
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
                    <td><%#Eval("Country") %></td>
                    <td><%#Eval("Province") %></td>
                    <td><%#Eval("City") %></td>
    	<td><input type="image" src="images/icn_trash.png"  title="移出黑名单" onclick="MoveOutBlickList('<%#Eval("OpenId") %>');"></td>
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
		</article><!-- end of content manager article -->
		
</asp:Content>
