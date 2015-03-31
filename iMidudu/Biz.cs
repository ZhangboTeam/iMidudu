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
            return SystemDAO.SqlHelper.Exists("select count(*) from MembershipInfo where openid=@openid", new System.Data.SqlClient.SqlParameter("@openid", openId));
        }
        public static int BounsLimt(string activityId)
        {
            var r = SystemDAO.SqlHelper.ExecuteScalarText("select top 1 BonusLimit from Activity where AcitvityId = @AcitvityId", new System.Data.SqlClient.SqlParameter("@AcitvityId", activityId));
            if (r == null)
            {
                return 0;
            }
            return (int)r;

        }

        public static int CountByAcitivtyAndOpenId(string activityId,string openId)
        {
            int count=0;
            var  r = SystemDAO.SqlHelper.ExecuteScalarText("select  isnull(count(1),0) from  BonusHistory where AcitvityId = @AcitvityId and OpenId = @OpenId and DATEPART(year,ReceiptDate) = @Year and DATEPART(month,ReceiptDate) = @Month",
                    new System.Data.SqlClient.SqlParameter("@AcitvityId", activityId),
                    new System.Data.SqlClient.SqlParameter("@OpenId", openId),
                    new System.Data.SqlClient.SqlParameter("@Year", DateTime.Today.Year),
                    new System.Data.SqlClient.SqlParameter("@Month", DateTime.Today.Month));
            count = (int)r;

            return count;

        }

        public static bool BounsCanUse(string BonusCode)
        { 
            return !SystemDAO.SqlHelper.Exists("select count(*) from BonusHistory where BonusCode=@BonusCode", new System.Data.SqlClient.SqlParameter("@BonusCode", BonusCode));
        }

        public static void Log(string log)
        {
            var file = System.Web.HttpContext.Current.Server.MapPath("~/userInfo.txt");
            System.IO.File.AppendAllText(file, "\r\n"); 
            System.IO.File.AppendAllText(file, log);
            System.IO.File.AppendAllText(file, "\r\n");
        }


        public static double GenerateRandomAmount()
        {
            //return new Random().Next(0, 4) == 0 ? 2 : 1;





            int d50 = 6042 -(int)SystemDAO.SqlHelper.ExecuteScalarText(string.Format("select count(1) from BonusHistory where Amount=50"));
           int d2 =  (int)SystemDAO.SqlHelper.ExecuteScalarText(string.Format("select count(1) from Bonus"))
               -(int)SystemDAO.SqlHelper.ExecuteScalarText(string.Format("select count(1) from BonusHistory"))
                ;//d50是50元红包的数量，d2是总共红包数量
            if (d2==0)
            {
                return 0;
            }
            var number = new Random().Next(0, d2);
            var bouns=0;
            if (number < d50)
            {
                //d50 = d50 - 1;
                //d2 = d2 - 1;
                bouns = 50;
            }
            else
            {
                //d2 = d2 - 1;
                bouns = 2;
            }
            return bouns;
           //    return 1;
            //return new Random().Next(0, 10) / 10.0;
        }

    }
}