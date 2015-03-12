<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="/Scripts/jquery-2.1.3.min.js"></script>
    <script>
        $(function () {
            $("#openBouns").click(function () {

                var bouns = $("#bouns").val();
                var acitvity = $("#acitvity").val();
                var openid = $("#openid").val();
                $.post("/WebService.asmx/openBouns",
                    {
                        bouns: bouns,
                        acitvity: acitvity,
                        openid: openid
                    }, function (data) {
                        var r = $(data).text();
                        //alert(r);
                        

                        var amount = parseFloat(r);
                        if (amount>0) {
    
                            alert("红包开出金额:" + amount);
                        } 
                        else {
                            alert("红包领取失败,您可能下手慢了");
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
    <%
        var limit = iMidudu.Biz.BounsLimt(this.Request["acitvity"]);
        var usedCount = iMidudu.Biz.CountByAcitivtyAndOpenId(this.Request["acitvity"], this.Request["openid"]);
    %>
   上限: <%=limit %>
    <br />
    已领取: <%=usedCount %>
    <%if (usedCount < limit)
        {%>
    没有超出领取上限
        <%
            var canUse = iMidudu.Biz.BounsCanUse(this.Request["bouns"]);
            if (canUse)
            {%>
    红包可用
    <input type="button" id="openBouns" value="打开红包" />
    <%}
        else
        {%>
    <br />
    但是, 红包已被领取
                 <%}


                     }
                     else
                     {%>
    超出领取上限,上限:<%=limit %>,当前:<%=usedCount %>
    <%}
    %>
</body>
</html>
