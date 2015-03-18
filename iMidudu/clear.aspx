<%@ Page Language="C#"  %>

<!DOCTYPE html>
<script runat="server">

    protected void Button1_Click(object sender, EventArgs e)
    {
        iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("delete from BonusHistory;");
    }
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="Button1" runat="server" Text="delete from BonusHistory;" OnClick="Button1_Click" />
    
    </div>
    </form>
</body>
</html>
