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
            return Data.Instance.Membership.Count(t => t.OpenId == openId) == 1;
        }
    }
}