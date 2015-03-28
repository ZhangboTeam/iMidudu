<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="/Scripts/jquery-2.1.3.min.js"></script>
    	<!-- Basic Page Needs
	================================================== -->
	<meta charset="utf-8"/>
	<title>不凡帝红包--已领取</title>
	<meta name="description" content=""/>
	<meta name="author" content="PaulWang"/>
	<meta content="telephone=no" name="format-detection" />
	<!-- 让IE浏览器用最高级内核渲染页面 还有用 Chrome 框架的页面用webkit 内核
	================================================== -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<!-- IOS6全屏 Chrome高版本全屏
	================================================== -->
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<meta name="mobile-web-app-capable" content="yes"/> 
	<!-- 让360双核浏览器用webkit内核渲染页面
	================================================== -->
	<meta name="renderer" content="webkit"/>
	<!-- Mobile Specific Metas
	================================================== -->
	<!-- !!!注意 minimal-ui 是IOS7.1的新属性，最小化浏览器UI，但是在iOS8.1突然被取消 -->
	<meta name="viewport" content="width=device-width,maximum-scale=1, maximum-scale=1"/>
	<meta content="telephone=no" name="format-detection" />
	<!-- CSS
	================================================== -->
	<link href="css/reset.css" rel="stylesheet" type="text/css"/>
	<link href="css/style.css" rel="stylesheet" type="text/css"/>
	<!-- Favicons
	================================================== -->
<!--	<link rel="shortcut icon" href="favicon.ico" >-->
	<!-- Android 主屏图标
	================================================== -->	
<!--	<link rel="icon" sizes="196x196" href="images/apple-touch-icon-114x114.png">-->
	<!-- IOS 主屏图标
	================================================== -->
<!--	<link rel="apple-touch-icon" sizes="57x57" href="images/apple-touch-icon-57x57.png">-->
<!--	<link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png">-->
<!--	<link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png">-->
</head>
<body>
    <form runat="server">
        <input id="bouns" value="<%=this.Request["bouns"]  %>" type="hidden" /><%//=this.Request["bouns"]  %>
        <input id="acitvity" value="<%=this.Request["acitvity"]  %>" type="hidden" /><%//=this.Request["acitvity"]  %>
        <input id="openid" value="<%=this.Request["openid"]  %>" type="hidden" /><%//=this.Request["openid"]  %>
        <%

            var rr = WX.getOpenId(this.Request["code"]);
            var r = WX.getUserInfo(rr);// WX.getOpenId();


            var sql = string.Format("select count(*) from Bonus where BonusCode='{0}'", this.Request["bouns"]);
            //Response.Write(sql);
            //Response.End();
            var exists = iMidudu.SystemDAO.SqlHelper.Exists(sql);
            var openid = this.Request["openid"];
            var bounscode = this.Request["bouns"];
            var activityid = this.Request["acitvity"];

            activityid = iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select AcitvityId from Bonus where BonusCode=@BonusCode", new System.Data.SqlClient.SqlParameter("@BonusCode", bounscode)).ToString();
            if (!exists)
            {
                //insert bad.....
                iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("insert into BadBonusHistory(HistoryId,OpenId,BonusCode,AcitvityId,ReceiptDate) values (newid(),@OpenId,@BounsCode,@ActivityId,getdate())",
                    new System.Data.SqlClient.SqlParameter("@OpenId", openid),
                    new System.Data.SqlClient.SqlParameter("@BounsCode", bounscode),
                    new System.Data.SqlClient.SqlParameter("@ActivityId", activityid));
                Response.Redirect("/illegal.aspx");
                //   Response.Write(bounscode + "红包码非法！");
                //   Response.End();

            }
            var limit = 30;
            var usedCount = iMidudu.Biz.CountByAcitivtyAndOpenId(this.Request["acitvity"], this.Request["openid"]);

            if (usedCount < limit)
            {
                var xml = "";
                var rrr = WX.openBouns(this.Request["bouns"], this.Request["acitvity"], this.Request["openid"], out xml);
                // Response.Write(xml);
                var amount = int.Parse(rrr);
                if (amount == -3)
                {
                    Response.Write("余额不足");
                    Response.End();

                }
                else
                {
                    if (amount > 0)
                    {

                        // alert("红包开出金额:" + amount);
                        // alert("转到公众号首页");
                        // window.location.href = "http://mp.weixin.qq.com/s?__biz=MzAxNzIwNjE3OQ==&mid=208231695&idx=1&sn=53351b0f3592d82509d8bc8be170fae4#rd";
                        if (amount == 50)
                        {
                            Response.Redirect("/perfetti50.aspx");
                        }
                        else
                        {
                            Response.Redirect("/perfetti2.aspx");
                        }
                    }
                    else
                    {

                        Response.Write("红包领取失败,您可能下手慢了");
                    }
                }
            }
            else
            {
                Response.Redirect("/limit.aspx");
            }
    %>
        <br />
    </form>
</body>
</html>
