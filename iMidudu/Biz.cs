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
            var r = SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from  BonusHistory where AcitvityId = @AcitvityId and OpenId = @OpenId", new System.Data.SqlClient.SqlParameter("@AcitvityId", activityId), new System.Data.SqlClient.SqlParameter("@OpenId", openId));
            if (r == null)
            {
                return 0;
            }
            return (int)r;

        }

        public static bool BounsCanUse(string BonusCode)
        { 
            return !SystemDAO.SqlHelper.Exists("select count(*) from BonusHistory where BonusCode=@BonusCode", new System.Data.SqlClient.SqlParameter("@BonusCode", BonusCode));
        }

        private static int d50 = 6042;
        private static int d2 = 604801;//d50是50元红包的数量，d2是总共红包数量
        public static double GenerateRandomAmount(string bouns)
        {
            var amount = new Random().Next(1, 604801);
            if (amount <= d50)
            {
                d50 = d50 - 1;
                d2 = d2 - 1;
            }
            else
            {
                d2 = d2 - 1;
            }
           // return amount;
               return 1;
            return new Random().Next(0, 10) / 10.0;
        }

    }
}