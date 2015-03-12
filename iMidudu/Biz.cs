using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace iMidudu
{
    public class Biz
    {
        
        public static bool IsMembership(string openId)
        {
            //   System.Web.HttpContext.Current.Response.Write(openId);return false;
            return SystemDAO.SqlHelper.Exists("select count(*) from MembershipInfo where openid=@openid", new System.Data.SqlClient.SqlParameter("@openid", openId));
        }
    }
}