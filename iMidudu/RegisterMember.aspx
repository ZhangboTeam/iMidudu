<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <!-- Basic Page Needs
	================================================== -->
    <meta charset="utf-8">
    <title>不凡帝红包--身份验证</title>
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
    <script src="/Scripts/jquery-2.1.3.min.js"></script>
    <script>
        $(function () {
            $("#sendValidCode").click(
               
                function () {
                    $("#sendValidCode").hide();
                    var m = $("#Mobile").val();
                    $.post("/WebService.asmx/sendSMSValid",
                        { mobile: m }, function (data) {
                            if ($(data).text() == "take") {
                                alert("手机号被占用！")
                            } else {
                                var r = $(data).text();
                                var rr = JSON.parse(r);

                                if (rr.code == 0) {
                                    $("#r").html("短信验证码已发送到手机:" + m);
                                    var count = 0;

                                    $("#sendValidCode").hide();

                                    var iii = setInterval(function () {
                                        $("#r").html(60 - ++count);
                                        if (count >= 60) {
                                            $("#sendValidCode").show();
                                            clearInterval(iii); $("#r").html("");
                                        }
                                    }, 1000);
                                    // alert("短信验证码已发送到手机:" + m);

                                }
                                else {
                                    alert(rr.msg);
                                }
                            }
                    });
                });


            $("#ok").click(
                function () {
                    var bouns = $("#bouns").val();
                    var acitvity = $("#acitvity").val();
                    var openid = $("#openid").val();
                    var UserName = $("#UserName").val();
                    var Sex = $("input[name=Sex]:checked").val();
                    var Mobile = $("#Mobile").val();
                    var ValidCode = $("#ValidCode").val();
                    if (UserName =="") {
                        alert("请输入姓名"); return;
                    }
                    if (Mobile == "") {
                        alert("请输入手机"); return;
                    }
                    $("#ok").hide();
                    $.post("/WebService.asmx/Register",
                        {
                            bouns: bouns,
                            acitvity: acitvity,
                            openid: openid,
                            UserName: UserName,
                            Sex: Sex,
                            Mobile: Mobile,
                            ValidCode: ValidCode,
                        }, function (data) {
                            var json = JSON.stringify({
                                b:bouns, a:acitvity
                            });
                            <% var ccc = this.Request["code"];%>
                            var url = "/UseBouns.aspx?bouns=" + bouns + "&acitvity=" + acitvity + "&openid=" + openid;
                            url = "/getUserInfo.aspx?bouns=" + bouns + "&acitvity=" + acitvity + "&openid=" + openid + "&code=<%=ccc%>";
                            url = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx8cabe7121f5369a3&redirect_uri=<%=System.Web.Configuration.WebConfigurationManager.AppSettings["Domain"] %>/getUserInfo.aspx&response_type=code&scope=snsapi_base&state=' +  json + '#wechat_redirect';
                           // alert(acitvity);
                         <%--   alert(url);
                            alert('<%=ccc%>');--%>
                            var r = $(data).text();
                            if (r == "OK") {

                               // alert("注册成功");
                              
                                window.location.href = url;
                            }
                            else {
                                alert(r);
                                $("#ok").show();
                            }

                        });
                });
        });
    </script>
</head>
<body>
    <input id="bouns" value="<%=this.Request["bouns"]  %>" type="hidden" />
    <input id="acitvity" value="<%=this.Request["acitvity"]  %>" type="hidden" />
    <input id="openid" value="<%=this.Request["openid"]  %>" type="hidden" />



    <%--   <hr />
    UserName:<input type="text" id="UserName" />
    <br />

    Sex:<input type="radio" name="Sex" value="1" checked="checked" />男<input type="radio" name="Sex" value="0" />女
    <br />

    Mobile:<input type="text" id="Mobile" value="" /><input type="button" value="发送验证码" id="sendValidCode" />
    <span id="r"></span>
    <br />

    短信验证码:<input type="text" id="ValidCode" />
    <br />

    <input type="button" value="提交验证" id="ok" /> --%>

    <div class="wrap">
        <header>
            <a href="#" class="logo logo01">
                <img src="images/logo-01.png" alt="" /></a>
            <a href="#" class="logo logo02">
                <img src="images/logo-02.png" alt="" /></a>
        </header>
        <section>
            <div class="mainWrap">
                <div class="formWrap">
                    <div class="formList">
                        <span class="title title01"></span>
                        <input type="text" id="UserName" class="txt txt01" placeholder="请输入姓名" />
                    </div>
                    <div class="formList">
                        <span class="title title02"></span>
                        <span class="sexWrap">
                            <input type="radio" class="radio" id="men" name="Sex" value="1" checked="checked" /><label for="men" class="radioBox"><i class="sex men"></i></label></span>
                        <span class="sexWrap">
                            <input type="radio" class="radio" id="women" name="Sex" value="0" /><label for="women" class="radioBox"><i class="sex women"></i></label></span>
                    </div>
                    <div class="formList">
                        <span class="title title03"></span>
                        <input type="text" class="txt txt01" id="Mobile" placeholder="请输入手机号" />
                    </div>
                    <div class="formList">
                        <input type="text" id="ValidCode" class="txt txt02" placeholder="请输入验证码" />
                        <a href="#" class="txt code" id="sendValidCode">获取验证码</a>                                        <p class="codeTips">验证码将在10分钟内发送到手机上，如果10分钟后没有收到验证码请重新获取验证码</p>
            <p class="logTips"><span>请注意：</span>请务必填写您真实准确的姓名及手机号码第二重好礼的兑奖需要提供与您填写的信息一致的证明文件，否则您将无法获得奖品</p>
                    </div>
                    <input type="button" class="btn" id="ok" value="" />
                </div>
            </div>
        </section>
    </div>
    <script src="js/jquery.min.js"></script>
</body>
</html>
