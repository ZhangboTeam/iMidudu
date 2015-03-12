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
        public static double GenerateRandomAmount()
        {
            return new Random().Next(0, 10) / 10.0;
        }

    }
}