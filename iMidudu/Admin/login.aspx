<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="iMidudu.Admin.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>管理员登陆页面</title>
    <script src="/Scripts/jquery-2.1.3.min.js"></script>
    <script>
        $(function () {
            $("#ok").click(
                function () {
                    var UserName = $("#UserName").val();
                    var PassWord = $("#pwd").val();
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
                            var r = $(data).text();

                            if (r == "OK") {

                                alert("注册成功");
                                var url = "/UseBouns.aspx?bouns=" + bouns + "&acitvity=" + acitvity + "&openid=" + openid;
                                //alert(url);
                                window.location.href = url;
                            }
                            else {
                                alert(r);
                            }

                        });
                });
        });
    </script>
</head>
<body>
    <center>
    <div>
    管理员登陆页面
    <br />
        <br />
     用户名:<input type="text" id="UserName" />
    <br />
        <br />
    密码:<input type="password" id="pwd" />
    <br />
        <br />
    <input type="button" value="确定" id="ok" />
    <input type="reset" value="重置" />
    </div>
    </center>
</body>
</html>
