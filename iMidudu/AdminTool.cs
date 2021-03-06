﻿using System;
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
                return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from Bonus where AcitvityId = '53C9B412-D1A5-44A6-957F-B948CD54CE86'");
            }
        }
        public static int TotalBonusUsed
        {
            get
            {
                return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select count(1) from BonusHistory");
            }
        }
        public static int BonusUsed2
        {
            get
            {
                return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select isnull(count(1),0) from BonusHistory where Amount=2");
            }
        }
        public static int BonusUsed50
        {
            get
            {
                return (int)iMidudu.SystemDAO.SqlHelper.ExecuteScalarText("select isnull(count(1),0) from BonusHistory where Amount=50");
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
