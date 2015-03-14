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
         var r = WX.SendBounsToOpenId("oo-nWs3meUO4Bu_zEWKoZYvpcr2g", 1, "1230283802201503148903532924", Guid.Parse("53c9b412-d1a5-44a6-957f-b948cd54ce86"), out p,out responseXML);



          %>
    <%=p %>
    <br />
    <% = r %>
    <hr />
    <%=responseXML %>
 
</body>
</html>
