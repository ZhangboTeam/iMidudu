<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>  
    <script src="/Scripts/jquery-2.1.3.min.js"></script>
    <script>
        $(function () {
            $("#openBouns").click(function () {                
                 // window.location = "/perfetti50.aspx";               
                   window.location = "/perfetti2.aspx";
                    return;

                var bouns = $("#bouns").val();
                var acitvity = $("#acitvity").val();
                var openid = $("#openid").val();
                //alert(openid);
                //alert(acitvity);
                //alert(bouns);
                //return false;
                $.post("/WebService.asmx/openBouns",
                    {
                        bouns: bouns,
                        acitvity: acitvity,
                        openid: openid
                    }, function (data) {
                        var r = $(data).text();
                         alert(r);
                        

                        var amount = parseFloat(r);
                        if (amount>0) {
    
                           // alert("红包开出金额:" + amount);
                           // alert("转到公众号首页");
                            // window.location.href = "http://mp.weixin.qq.com/s?__biz=MzAxNzIwNjE3OQ==&mid=208231695&idx=1&sn=53351b0f3592d82509d8bc8be170fae4#rd";
                            if (amount==50) {
                                window.location = "/perfetti50.aspx";
                            } else {
                                window.location = "/perfetti2.aspx";
                            }
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
    <input id="bouns" value="<%=this.Request["bouns"]  %>" type="hidden" /><%//=this.Request["bouns"]  %>
    <input id="acitvity" value="<%=this.Request["acitvity"]  %>" type="hidden" /><%//=this.Request["acitvity"]  %>
    <input id="openid" value="<%=this.Request["openid"]  %>" type="hidden" /><%//=this.Request["openid"]  %>
    <%
           var sql = string.Format("select count(*) from Bonus where BonusCode='{0}'", this.Request["bouns"]);
            //Response.Write(sql);
            //Response.End();
            var exists = iMidudu.SystemDAO.SqlHelper.Exists(sql);
            var openid = this.Request["openid"];
            var bounscode = this.Request["bouns"];
            var activityid = this.Request["acitvity"];

            if (!exists)
            {
            //insert bad.....
                iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("insert into BadBonusHistory(OpenId,BounsCode,ActivityId,ReceiptDate) values (@OpenId,@BounsCode,@ActivityId,getdate())",
                    new System.Data.SqlClient.SqlParameter("@OpenId", openid),
                    new System.Data.SqlClient.SqlParameter("@BounsCode", bounscode),
                    new System.Data.SqlClient.SqlParameter("@ActivityId", activityid));
                
                Response.Write("红包码非法！");
                Response.End();

            }
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
