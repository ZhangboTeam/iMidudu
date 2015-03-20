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

                    var sql = string.Format("select count(*) from SystemUser where LoginName='UserName' and Password='PassWord'");
                    //Response.Write(sql);
                    //Response.End();
                    var exists = iMidudu.SystemDAO.SqlHelper.Exists(sql);

                    if (exists) {
                        Response.Redirect("/ViewBounsHistory.aspx");
                    }
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
