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
            if (  code.ToString().Equals(ValidCode)  )
            { 
                try
                {

                    SystemDAO.SqlHelper.ExecteNonQueryText("insert into MembershipInfo(Mobile,OpenId,RegDate,Sex,UserName,RecentLoginDate) values (@Mobile,@OpenId,getDate(),@Sex,@UserName,getDate())",
                    new System.Data.SqlClient.SqlParameter("@Mobile", Mobile),
                    new System.Data.SqlClient.SqlParameter("@OpenId", openid),
                    new System.Data.SqlClient.SqlParameter("@Sex", Sex),
                    new System.Data.SqlClient.SqlParameter("@UserName", UserName));
                }
                catch (Exception ex)
                {
                    return ex.Message;
                }
                return "OK";


            }
            return "验证码不正确";
        }
        [WebMethod(EnableSession =true)]
        public string openBouns(string bouns,string acitvity,string openid )
        {
            double amount = Biz.GenerateRandomAmount();
            if (amount==0)
            {
                return "-1";
            }
          //  amount = 1;
            try
            {

                //return postXML;
                // return responseXML;
                if (!iMidudu.Biz.BounsCanUse(bouns))
                {
                    return "-1";
                }
                SystemDAO.SqlHelper.ExecteNonQueryText("insert into BonusHistory(BonusCode,OpenId,AcitvityId,Amount,ReceiptDate,RecentLoginDate) values (@BonusCode,@OpenId,@AcitvityId,@Amount,getdate(),getDate())",
                 new System.Data.SqlClient.SqlParameter("@BonusCode", bouns),
                 new System.Data.SqlClient.SqlParameter("@OpenId", openid),
                 new System.Data.SqlClient.SqlParameter("@AcitvityId", acitvity),
                 new System.Data.SqlClient.SqlParameter("@Amount", amount)
                );

              //  return amount.ToString();
                //想openid打入真的钱
               string r;
                string responseXML;
                var postXML = WX.SendBounsToOpenId(openid, (int)amount, WX.newBillNo(), Guid.Parse(acitvity), out r, out responseXML);

               // return responseXML;

                return amount.ToString();

            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }


        [WebMethod(EnableSession =true)]
        public bool     Login(string userName,string password)
        {
            var ok = iMidudu.SystemDAO.SqlHelper.Exists("select count(1) from SystemUser where LoginName=@LoginName and Password= @Password", new System.Data.SqlClient.SqlParameter("@LoginName", userName), new System.Data.SqlClient.SqlParameter("@Password", password));
            if (ok)
            {
                System.Web.HttpContext.Current.Session["UserName"] = userName;
            }
            return ok;
        }

		[WebMethod(EnableSession = true)]
		public bool ChangePassword(string oldpwd, string newpwd, string newpwd2)
		{
			var username = HttpContext.Current.Session["UserName"].ToString();
			if (SystemDAO.SqlHelper.Exists("select count(1) from SystemUser where LoginName =@UserName and Password = @Password", new System.Data.SqlClient.SqlParameter("@UserName", username), new System.Data.SqlClient.SqlParameter("@Password", oldpwd)))
			{
				SystemDAO.SqlHelper.ExecteNonQueryText("update SystemUser set Password=@Password where LoginName=@UserName",
				 new System.Data.SqlClient.SqlParameter("@UserName", username),
				 new System.Data.SqlClient.SqlParameter("@Password", newpwd));
				return true;
			}
			return false;
		}

        [WebMethod(EnableSession = true)]
        public bool Logout()
        {
            System.Web.HttpContext.Current.Session["UserName"] = null;
                return true;
        }



        [WebMethod(EnableSession = true)]
        public string UpdateManager( string UserName, string Password)
        {
                try
                {

                    SystemDAO.SqlHelper.ExecteNonQueryText("update SystemUser set LoginName=@UserName,Password=@Password where id='1')",
                    new System.Data.SqlClient.SqlParameter("@UserName", UserName),
                    new System.Data.SqlClient.SqlParameter("@Password", Password));
                }
                catch (Exception ex)
                {
                    return ex.Message;
                }
                return "OK";
        }

        [WebMethod(EnableSession = true)]
        public string DeleteUser(string OpenId)
        {
            try
            {

                SystemDAO.SqlHelper.ExecteNonQueryText("delete from MembershipInfo where OpenId=@OpenId)",
                new System.Data.SqlClient.SqlParameter("@OpenId", OpenId));
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return "OK";
        }

        [WebMethod(EnableSession = true)]
        public string MoveOutOfBlickList(string OpenId)
        {
            try
            {

                SystemDAO.SqlHelper.ExecteNonQueryText("delete from Blacklist where OpenId=@OpenId)",
                new System.Data.SqlClient.SqlParameter("@OpenId", OpenId));
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return "OK";
        }

        [WebMethod(EnableSession = true)]
        public string joinBlacklist(string OpenId)
        {
            string Country = null;
            string Province = null;
            string City = null;
            string NickName = null;
            string Pic = null;
            string UserName = null;
            string Mobile = null;
            int Sex = 1;

            try
            {
                Country = SystemDAO.SqlHelper.ExecuteScalarText("select Country from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)).ToString();
            }
            catch
            {
                 Country = null;
            }
            try
            {
             Province = SystemDAO.SqlHelper.ExecuteScalarText("select Province from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)).ToString();
            }
            catch
            {
                 Province = null;
            }
            try
            {
             City = SystemDAO.SqlHelper.ExecuteScalarText("select City from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)).ToString();
            }
            catch
            {
                City = null;
            }
            try
            {
            NickName = SystemDAO.SqlHelper.ExecuteScalarText("select NickName from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)).ToString();
            }
            catch
            {
                 NickName = null;
            }
            try
            {
             Pic = SystemDAO.SqlHelper.ExecuteScalarText("select Pic from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)).ToString();
            }
            catch
            {
                 Pic = null;
            }
            try
            {
             UserName = SystemDAO.SqlHelper.ExecuteScalarText("select UserName from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)).ToString();
            }
            catch
            {
                 UserName = null;
            }
            try
            {
             Mobile = SystemDAO.SqlHelper.ExecuteScalarText("select Mobile from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)).ToString();
            }
            catch
            {
                 Mobile = null;
            }
            try
            {
             Sex = (int)SystemDAO.SqlHelper.ExecuteScalarText("select Sex from MembershipInfo where OpenId=@OpenId", new System.Data.SqlClient.SqlParameter("@OpenId", OpenId));
            }
            catch
            {
                 Sex = 1;
            }

            SystemDAO.SqlHelper.ExecteNonQueryText("insert into Blacklist(Country,Province,City,NickName,Pic,UserName,Mobile,Sex,OpenId) values (@Country,@Province,@City,@NickName,@Pic,@UserName,@Mobile,@Sex,@OpenId)",
                 new System.Data.SqlClient.SqlParameter("@Country", Country),
                 new System.Data.SqlClient.SqlParameter("@Province", Province),
                 new System.Data.SqlClient.SqlParameter("@City", City),
                 new System.Data.SqlClient.SqlParameter("@Pic", Pic),
                 new System.Data.SqlClient.SqlParameter("@UserName", UserName),
                 new System.Data.SqlClient.SqlParameter("@Mobile", Mobile),
                 new System.Data.SqlClient.SqlParameter("@Sex", Sex),
                 new System.Data.SqlClient.SqlParameter("@OpenId", OpenId)
                );

            try
            {

                SystemDAO.SqlHelper.ExecteNonQueryText("delete from MembershipInfo where OpenId=@OpenId)",
                new System.Data.SqlClient.SqlParameter("@OpenId", OpenId));
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return "OK";
        }





        [WebMethod(EnableSession = true)]
        public string UpdateActivity(string AcitvityId, string BonusGroupId, string BonusLimit, string ActivityName, string BeginDate, string EndDate)
        {
            try
            {

                SystemDAO.SqlHelper.ExecteNonQueryText("insert into Activity(AcitvityId,BonusGroupId,BonusLimit,ActivityName,BeginDate,EndDate) vlues AcitvityId=@AcitvityId，BonusGroupId=@BonusGroupId ,BonusLimit=@BonusLimit，ActivityName=@ActivityName,BeginDate=@BeginDate，EndDate=@EndDate)",
                new System.Data.SqlClient.SqlParameter("@AcitvityId", AcitvityId),
                new System.Data.SqlClient.SqlParameter("@BonusGroupId", BonusGroupId),
                new System.Data.SqlClient.SqlParameter("@BonusLimit", BonusLimit),
                new System.Data.SqlClient.SqlParameter("@ActivityName", ActivityName),
                new System.Data.SqlClient.SqlParameter("@BeginDate", BeginDate),
                new System.Data.SqlClient.SqlParameter("@EndDate", EndDate));
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return "OK";
        }   
    }
}
