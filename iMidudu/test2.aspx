<%@ Page Language="C#"    %> 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body> 
     <%

         var p = "";
         string responseXML;
         // var r = WX.SendBounsToOpenId("oo-nWs3meUO4Bu_zEWKoZYvpcr2g", 1, "1230283802201503148903532924", Guid.Parse("53c9b412-d1a5-44a6-957f-b948cd54ce86"), out p,out responseXML);
         var ok = false;
         try
         {
             var openid = "oo-nWs3meUO4Bu_zEWKoZYvpcr2g";
             WX.isUserFocused(openid);
         }
         catch (Exception ex)
         {
             this.Response.Write(ex.ToString());

         }
         Response.Write(ok);
          %>
    <%//=p %>
    <br />
    <%// = r %>
    <hr />
    <%//=responseXML %>

   <%
       var d50 = 6042;
       var d2 =604800;
       var c50 = 0;
       var c2 = 0;
       //for (int i = 0; i < d50+d2; i++)
       for (int i = 0; i < d2; i++)
       {
           %>
  <%var m = iMidudu.Biz.GenerateRandomAmount();
      if (m==50)
      {
          c50++;
      }
      if (m==2)
      {
          c2++;
      }
       %><br />
    <%
       } %>
    50:<%=c50 %><br />
    2:<%=c2 %>
    <%=d2 - c50 - c2 %>
 
</body>
</html>
