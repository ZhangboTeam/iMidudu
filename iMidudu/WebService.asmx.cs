using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace iMidudu
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
      [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {

        [WebMethod(EnableSession =true)]
        public string sendSMSValid(string mobile)
        {
            return SMS.SendValidCode(mobile);
        }

        [WebMethod(EnableSession =true)]
        public string Register(string bouns,string acitvity,string openid,string UserName,int Sex,string Mobile,string ValidCode)
        {
            var code = System.Web.HttpContext.Current.Session["smsCode"];
            if (code == null)
            {
                return "没有发送验证码";
            }
            if (code.ToString().Equals(ValidCode))
            {
                iMidudu.Data.Instance.MembershipInfo.Add(new MembershipInfo() {
                     Mobile= Mobile, OpenId= openid, RegDate= DateTime.Now, Sex= Sex, UserName = UserName
                });
                iMidudu.Data.Instance.SaveChanges();
                return "OK";
            }
            return "验证码不正确";
        }
        [WebMethod(EnableSession =true)]
        public string openBouns(string bouns,string acitvity,string openid )
        {
            double amount = Biz.GenerateRandomAmount();
            try
            {
            SystemDAO.SqlHelper.ExecteNonQueryText("insert into BonusHistory(BonusCode,OpenId,AcitvityId,Amount,ReceiptDate) values (@BonusCode,@OpenId,@AcitvityId,@Amount,getdate())",
                 new System.Data.SqlClient.SqlParameter("@BonusCode", bouns),
                 new System.Data.SqlClient.SqlParameter("@OpenId", openid),
                 new System.Data.SqlClient.SqlParameter("@AcitvityId", acitvity),
                 new System.Data.SqlClient.SqlParameter("@Amount", amount) 
                );

                return amount.ToString();

            }
            catch (Exception ex)
            {
                return "-1";
            }
        }

    }
}
