<%@ Page Language="C#"  Trace="true"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    用户订阅成功
    <br />
    bonus:<%=this.Session["bonus"]  %>
    <br />
    openid:<%=this.Session["openid"]  
    
        
        %>
    <%
        var d = iMidudu.Data.Instance.Activity.ToList();

        foreach (var item in d)
        {
            Response.Write(item.ActivityName);
        }
        //using (iMidudu.iMiduduEntities e = new iMidudu.iMiduduEntities())
        //{
        //}
         %>
</body>
</html>
