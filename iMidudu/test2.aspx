<%@ Page Language="C#"    %> 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body> 
     <%

         var p = "";
         var r = WX.SendBounsToOpenId("oo-nWs3meUO4Bu_zEWKoZYvpcr2g", 1, "222", Guid.Parse("53c9b412-d1a5-44a6-957f-b948cd54ce86"), out p);

 

          %>
    <%=p %>
    <br />
    <% = r %>
 
</body>
</html>
