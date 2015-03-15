<%@ Page Language="C#" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
    <form id="form1" runat="server">
        <div>
           
            code:<%=this.Request["code"] %>
    acitvity:<%=this.Request["acitvity"] %>
        </div>
        <div>
            bonus:<%= this.Request["state"]%>
        </div>

        <%
            var rr = WX.getOpenId();
            var r = WX.getUserInfo(rr);// WX.getOpenId();
                                       //TODO:1.判断openid是否关注过本公众号

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
           // Response.Write(sql);
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
            if (!iMidudu.Biz.IsMembership(rr.openid))
            {

                Response.Redirect("/RegisterMember.aspx"+param);
            }
            else
            {
                Response.Redirect("/UseBouns.aspx"+param);
            }

        %>

        <% if (focused == false)
            {
                //Response.Redirect("http://mp.weixin.qq.com/s?__biz=MzAxNzIwNjE3OQ==&mid=208231695&idx=1&sn=53351b0f3592d82509d8bc8be170fae4#rd");
        %>
        <%  }
        %>
        <h1>当前用户有没有关注?<%=focused %></h1>
        <fieldset>
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
    </form>
</body>
</html>
