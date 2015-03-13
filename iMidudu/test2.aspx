<%@ Page Language="C#"    %> 
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body> 
     <%

         var p = "";
         //  var r = WX.SendBounsToOpenId("oo-nWs3meUO4Bu_zEWKoZYvpcr2g", 1, "222", Guid.Parse("53c9b412-d1a5-44a6-957f-b948cd54ce86"), out p);


         var file = System.Web.HttpContext.Current.Server.MapPath("~/code2.txt");
         var datas = System.IO.File.ReadAllLines(file);
         foreach (var code in datas)
         {
             Response.Write(code);
             if (string.IsNullOrEmpty(code))
             {
                 continue;
             }
             if (!iMidudu.SystemDAO.SqlHelper.Exists("select * from Bonus where BonusCode=@BonusCode", new System.Data.SqlClient.SqlParameter("@BonusCode", code)))
             {

                 iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("insert into Bonus(BonusCode) values (@BonusCode)",
                             new System.Data.SqlClient.SqlParameter("@BonusCode", code));
             }
         }

          %>
    <%=p %>
    <br />
    <% //= r %>
 
</body>
</html>
