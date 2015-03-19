<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="/Scripts/jquery-2.1.3.min.js"></script>
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

            if (!exists)
            {
                //insert bad.....
                iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("insert into BadBonusHistory(HistoryId,OpenId,BonusCode,AcitvityId,ReceiptDate) values (newid(),@OpenId,@BounsCode,@ActivityId,getdate())",
                    new System.Data.SqlClient.SqlParameter("@OpenId", openid),
                    new System.Data.SqlClient.SqlParameter("@BounsCode", bounscode),
                    new System.Data.SqlClient.SqlParameter("@ActivityId", activityid));

                Response.Write(bounscode + "红包码非法！");
                Response.End();

            }
            var limit = iMidudu.Biz.BounsLimt(this.Request["acitvity"]);
            var usedCount = iMidudu.Biz.CountByAcitivtyAndOpenId(this.Request["acitvity"], this.Request["openid"]);


            //var rr = WX.getOpenId(this.Request["code"]);
            //var r = WX.getUserInfo(rr);// WX.getOpenId(); 
            // var r = (UserInfo)this.Session["r"];


            // iMidudu.Biz.Log(sql2);
            //iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText(sql2);
            //    iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("update MembershipInfo set Country=@Country,Province=@Province,City=@City,NickName=@NickName,Pic=@Pic where OpenId=@OpenId",
            //new System.Data.SqlClient.SqlParameter("@Country", Server.UrlDecode(this.Request["C"])) { SqlDbType = System.Data.SqlDbType.NVarChar },
            //new System.Data.SqlClient.SqlParameter("@Province", Server.UrlDecode(this.Request["P"])) { SqlDbType = System.Data.SqlDbType.NVarChar },
            //new System.Data.SqlClient.SqlParameter("@City", Server.UrlDecode(this.Request["City"])) { SqlDbType = System.Data.SqlDbType.NVarChar },
            //new System.Data.SqlClient.SqlParameter("@NickName", Server.UrlDecode(this.Request["Nickname"]) + "ttttt") { SqlDbType = System.Data.SqlDbType.NVarChar },
            //new System.Data.SqlClient.SqlParameter("@Pic", this.Request["Pic"]) { SqlDbType = System.Data.SqlDbType.NVarChar },
            //new System.Data.SqlClient.SqlParameter("@OpenId", this.Request["openid"]));

            var data = iMidudu.SystemDAO.SqlHelper.ExecuteDataSetText("select * from MembershipInfo");
            foreach (System.Data.DataRow item in data.Tables[0].Rows)

            {
                //   Response.Write(item["Nickname"]);
            }
    %>
        <%//=sql2 %>
           
   <% //上限: %><%//=limit %>
        <br />
        <script>
        </script>
        <% //已领取:%> <%//=usedCount %>
        <%if (usedCount < limit)
            {%>
   <% // 没有超出领取上限%>
       
        <%
            var canUse = iMidudu.Biz.BounsCanUse(this.Request["bouns"]);
            if (canUse)
            {

                // Response.Redirect("/perfetti2.aspx");
                // Response.End();
                %>
        <%--  红包可用--%>
        <input type="button" id="openBouns" value="打开红包" hidden />

        <script>
            // window.location = "/perfetti50.aspx";               
            //  window.location = "/perfetti2.aspx"; 
            //   return;
            $(function () {
               tikeIt();
            });

            function tikeIt() {

                var bouns = $("#bouns").val();
                var acitvity = $("#acitvity").val();
               // alert(acitvity);
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



                        var amount = parseFloat(r);
                        if (amount > 0) {

                            // alert("红包开出金额:" + amount);
                            // alert("转到公众号首页");
                            // window.location.href = "http://mp.weixin.qq.com/s?__biz=MzAxNzIwNjE3OQ==&mid=208231695&idx=1&sn=53351b0f3592d82509d8bc8be170fae4#rd";
                            if (amount == 2) {
                                window.location = "/perfetti50.aspx";
                            } else {
                                window.location = "/perfetti2.aspx";
                            }
                        }
                        else {
                            alert(r);
                            alert("红包领取失败,您可能下手慢了");
                        }

                    });
            } 
    </script>
        <%}
            else
            {%>
        <br />
         红包已被领取
                
        <%}


            }
            else
            {%>
    超出领取上限<%// ,上限:<%=limit ,当前:=usedCount %>
        <%}
    %>
    </form>
</body>
</html>
