<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="/Scripts/jquery-2.1.3.min.js"></script>
    <script>
        $(function () {
            $("#sendValidCode").click(
                function () {
                    var m = $("#Mobile").val();
                    $.post("/WebService.asmx/sendSMSValid", { mobile: m }, function (data) {
                        var r = $(data).text();
                        var rr = JSON.parse(r);
                        
                        if (rr.code == 0) {
                            $("#r").html("短信验证码已发送到手机:" + m);
                            alert("短信验证码已发送到手机:" + m);

                        }
                        else {
                            alert(rr.msg);
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
                    $.post("/WebService.asmx/Register",
                        {
                            bouns: bouns,
                            acitvity: acitvity,
                            openid: openid,
                            UserName: UserName,
                            Sex: Sex,
                            Mobile: Mobile,
                            ValidCode: ValidCode
                        }, function (data) {
                            var r = $(data).text();
                            if (r == "OK") {
                                
                                alert("注册成功");
                               
                                var url = "/UseBouns.aspx?bouns=" + bouns + "&acitvity=" + acitvity + "&openid=" + rr.openid;
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
    用户验证  
    <input id="bouns" value="<%=this.Request["bouns"]  %>" type="hidden" />
    <input id="acitvity" value="<%=this.Request["acitvity"]  %>" type="hidden" />
    <input id="openid" value="<%=this.Request["openid"]  %>" type="hidden" />
    <hr />
    UserName:<input type="text" id="UserName" />
    <br />

    Sex:<input type="radio" name="Sex" value="1" checked="checked" />男<input type="radio" name="Sex" value="0" />女
    <br />

    Mobile:<input type="text" id="Mobile" value="15000208834" /><input type="button" value="发送验证码" id="sendValidCode" />
    <span id="r"></span>
    <br />

    短信验证码:<input type="text" id="ValidCode" />
    <br />

    <input type="button" value="提交验证" id="ok" />
</body>
</html>
