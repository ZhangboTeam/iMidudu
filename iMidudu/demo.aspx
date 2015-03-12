<%@ Page Language="C#"   %>

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

            %>  
        <h1>当前用户有没有关注?<%=focused %></h1>
        <fieldset   >
            <legend>关注的用户信息</legend>
          total :<%=users.total %> <br />
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
