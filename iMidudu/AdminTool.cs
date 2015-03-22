using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iMidudu
{
  public  class AdminTool
    {
        public static int TotalBonus
        {
            get
            {
                return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from Bonus");
            }
        }
        public static int TotalBonusUsed
        {
            get
            {
                return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from BonusHistory");
            }
        }
        public static double TotalBonusMoneyUsed
        {
            get
            {
                return (double)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select sum(Amount) from BonusHistory");
            }
        }
    }
}
