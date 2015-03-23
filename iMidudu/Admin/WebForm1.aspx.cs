using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace iMidudu.Admin
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string userName = TextBox1.Text.ToString();
            string userPwd = TextBox2.Text.ToString();



            SystemDAO.SqlHelper.ExecteNonQueryText("update SystemUser set LoginName=@userName,Password=@userPwd where id='1'",
            new System.Data.SqlClient.SqlParameter("@userName", userName),
            new System.Data.SqlClient.SqlParameter("@userPwd", userPwd));
            Response.Redirect("/Admin/AdminManage1.aspx");

        }
    }
}