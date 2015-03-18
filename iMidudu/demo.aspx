<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<!-- Basic Page Needs
	================================================== -->
	<meta charset="utf-8">
	<title>不凡帝红包</title>
	<meta name="description" content="">
	<meta name="author" content="PaulWang">
	<meta content="telephone=no" name="format-detection" />
	<!-- 让IE浏览器用最高级内核渲染页面 还有用 Chrome 框架的页面用webkit 内核
	================================================== -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<!-- IOS6全屏 Chrome高版本全屏
	================================================== -->
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="mobile-web-app-capable" content="yes"> 
	<!-- 让360双核浏览器用webkit内核渲染页面
	================================================== -->
	<meta name="renderer" content="webkit">
	<!-- Mobile Specific Metas
	================================================== -->
	<!-- !!!注意 minimal-ui 是IOS7.1的新属性，最小化浏览器UI，但是在iOS8.1突然被取消 -->
	<meta name="viewport" content="width=device-width,maximum-scale=1, maximum-scale=1">
	<meta content="telephone=no" name="format-detection" />
	<!-- CSS
	================================================== -->
	<link href="css/reset.css" rel="stylesheet" type="text/css">
	<link href="css/style.css" rel="stylesheet" type="text/css">
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
    <script>
        function weixinAddContact(name) {
            WeixinJSBridge.invoke("addContact", { webtype: "1", username: name }, function (e) {
                alert(e.err_msg);
                WeixinJSBridge.log(e.err_msg);
                //e.err_msg:add_contact:added 已经添加
                //e.err_msg:add_contact:cancel 取消添加
                //e.err_msg:add_contact:ok 添加成功
                if (e.err_msg == 'add_contact:added' || e.err_msg == 'add_contact:ok') {
                    //关注成功，或者已经关注过
                    // alert(message);
                }
            })
        }
    </script>
</head>
<body> 

        <div hidden>
           
            code:<%=this.Request["code"] %>
    acitvity:<%=this.Request["acitvity"] %>
            bonus:<%= this.Request["state"]%>
        </div> 

        <%
            var rr = WX.getOpenId();
            var r = WX.getUserInfo(rr);// WX.getOpenId();
                                       //TODO:1.判断openid是否关注过本公众号

/*            var sql2 = string.Format("select count(*) from TMembershipInfo where OpenId='{0}'", r.openid);
            //Response.Write(sql);
            //Response.End();
            var exists2 = iMidudu.SystemDAO.SqlHelper.Exists(sql2);

            if (exists2)
            {
                iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("update TMembershipInfo set Country=@Country,Province=@Province,City=@City,NickName=@NickName,Pic=@Pic where OpenId=@OpenId)",
                new System.Data.SqlClient.SqlParameter("@Country", r.country),
                new System.Data.SqlClient.SqlParameter("@Province", r.province),
                new System.Data.SqlClient.SqlParameter("@City", r.city),
                new System.Data.SqlClient.SqlParameter("@NickName", r.nickname),
                new System.Data.SqlClient.SqlParameter("@Pic", r.headimgurl),
                new System.Data.SqlClient.SqlParameter("@OpenId", r.openid));

            }
            else
            {
                iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("insert into TMembershipInfo(OpenId,Country,Province,City,NickName,Pic) values (@OpenId,@Country,@Province,@City,@NickName,@Pic)",
                new System.Data.SqlClient.SqlParameter("@OpenId", r.openid),
                new System.Data.SqlClient.SqlParameter("@Country", r.country),
                new System.Data.SqlClient.SqlParameter("@Province", r.province),
                new System.Data.SqlClient.SqlParameter("@City", r.city),
                new System.Data.SqlClient.SqlParameter("@NickName", r.nickname),
                new System.Data.SqlClient.SqlParameter("@Pic", r.headimgurl));
            }*/



            FocusedUserResponse users = null;
            WX.FocusedUser(ref users);

            bool focused = WX.isUserFocused(rr.openid);

            var code = this.Request["code"];
            var bouns = this.Request["state"];
            if (bouns == null) {
                bouns = "df019e14ec7b2fc3fd29834451b1865e";
            }
            var acitvity = this.Request["acitvity"];//第一次的二维码没有这个参数

            //   Response.Write(bouns);
            //   Response.End();
            //bouns += "1";//测试错误代码
            var sql = string.Format("select count(*) from Bonus where BonusCode='{0}'", bouns);
            //Response.Write(sql);
            //Response.End();
            var exists = iMidudu.SystemDAO.SqlHelper.Exists(sql);

            if (!exists)
            {
                Response.Write("红包码非法！");
                Response.End();

            }
            if (string.IsNullOrEmpty(acitvity))
            {
                acitvity = System.Web.Configuration.WebConfigurationManager.AppSettings["defaultActivityId"];
            }
            var param = "?bouns=" + bouns + "&acitvity=" + acitvity + "&openid=" + rr.openid;
            var toUrl = "";

            // rr = new OpenIdResponse() { openid = "oo-nWs8BdPXDWSKODck-1TtlMa3c" };
            if (!iMidudu.Biz.IsMembership(rr.openid))
            {
                toUrl = "/RegisterMember.aspx" + param;
                //     Response.Redirect("/RegisterMember.aspx"+param);
            }
            else
            {
                toUrl = "/UseBouns.aspx" + param;
                // Response.Redirect("/UseBouns.aspx"+param);
            }

        %>

        <% if (focused == false)
            {
                //Response.Redirect("http://mp.weixin.qq.com/s?__biz=MzAxNzIwNjE3OQ==&mid=208231695&idx=1&sn=53351b0f3592d82509d8bc8be170fae4#rd");
        %>
        <%  }
        %>
        <fieldset hidden>
        <h1>当前用户有没有关注?<%=focused %></h1>
            <legend>关注的用户信息</legend>
            total :<%=users.total %>
            <br />
            <%foreach (var item in users.data.openid)
                {%>
            <%=item  %><br />
            <%} %>
        </fieldset>

        <div hidden>
            静默授权:(不点授权按钮):  <% =rr.openid %>
            <hr />
            以下信息需要点击授权才可获取:
            <br />
            openid <%=r.openid %><br />
            country <%=r.country %><br />
            province <%=r.province %><br />
            city <%=r.city %><br />
            headimgurl <%=r.headimgurl %>
            <img src="<%=r.headimgurl %>" width="100" />
            <br />
            language <%=r.language %><br />
            nickname <%=r.nickname %><br />
            sex <%=r.sex==1?"男" :"女" %><br />
            <%-- subscribe <%=r.subscribe %><%=r.subscribe==0?"No":"Yes" %><br />--%>
           unionid <%=r.unionid %><br />
        </div> 



    
<div class="wrap">
    <header>
        <a href="#" class="logo logo01"><img src="images/logo-01.png" alt=""></a>
        <a href="#" class="logo logo02"><img src="images/logo-02.png" alt=""></a>
    </header>
    <section>
        <div class="txtWrap">
            <h2 class="title tc f-s-01">阿尔卑斯、曼妥思零售渠道促销送好礼</h2>
            <p class="titleInfo tc filter-02">2015年双重好礼等着您</p>
            <div class="txtCon">
                <h3 class="title f-s-02 filter-01">第一重”红包好礼，人人有奖”</h3>
                <p class="titleInfo filter-02 filter-02">活动时间： 2015年4月1日至2015年9月30日</p>
                <dl>
                    <dt><i class="icoDot"></i>活动参与方式：</dt>
                    <dd>微信扫二维码，点击“关注”服务号</dd>
                    <dd>根据系统提示用户输入姓名，手机号并获取短信验证.输入验证通过即可获得微信红包</dd>
                </dl>
                <dl>
                    <dt><i class="icoDot"></i>活动红包好礼：</dt>
                    <dd>红包金额随机，面值人民币2元和人民币50元。红包自动存入微信钱包</dd>
                    <dd>查询：点击钱包 - 微信红包  -我的红包  -收到的红包，即可查询红包金额每个手机号或微信号每月领取的红包数量不能超过30个</dd>
                </dl>
                <dl>
                    <dt><i class="icoDot"></i>活动产品：</dt>
                    <dd>阿尔卑斯焦香源味牛奶硬糖条形、田园草莓牛奶硬糖条形、焦香源形牛奶软糖条形、巧克溢夹心太妃糖条形 ；曼妥思劲嚼充气糖霓虹糖条型、薄荷条形</dd>
                </dl>
                <dl>
                    <dt class="filter-01"><i class="icoDot"></i>备注：２元及50元的红包税费是由不凡帝代缴</dt>
                    <dd>每月超级大奖公布情况，敬请关注不凡帝官方微信号“PVM中国”！</dd>
                </dl>
            </div>
            <input type="button" class="btn" value="" onclick="window.location='<%=toUrl%>';">
        </div>
    </section>
</div>
<script src="js/jquery.min.js"></script>
</body>
</html>
