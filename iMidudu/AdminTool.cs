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
                return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from Bonus where AcitvityId  in (select AcitvityId from Activity where ActivityName='不凡帝1')");
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
        /// <summary>
        /// 按日期和金额查询领取数量
        /// </summary>
        /// <param name="date">开始日期</param>
        /// <param name="Amount">金额</param>
        /// <param name="Step">跨度几天？当天就写1，最近一周就写7，最近30天就写30</param>
        /// <returns></returns>
        public static int CountBonusByDateAndAmount(DateTime date,int Amount,int Step)
        {

            return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from BonusHistory where ReceiptDate>=@datebegin and ReceiptDate<@dateend and Amount=@Amount",
                 new System.Data.SqlClient.SqlParameter("@datebegin", date),
                 new System.Data.SqlClient.SqlParameter("@dateend", date.AddDays(Step)),
                 new System.Data.SqlClient.SqlParameter("@Amount", Amount)
                );

        }
    }
}
