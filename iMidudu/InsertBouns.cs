using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Text;
using System.Web.Services;

public  class  InsertBouns
{
    public static  void  Insert()
    {
        // string txt_str = String.Empty;

        var file = System.Web.HttpContext.Current.Server.MapPath("~/code.txt");
        var datas = System.IO.File.ReadAllLines(file);
        foreach (var code in datas)
        {
            if(!iMidudu.SystemDAO.SqlHelper.Exists("select * from Bouns where bounsCode=BonusCode", new System.Data.SqlClient.SqlParameter("@BonusCode", code))){
                iMidudu.SystemDAO.SqlHelper.ExecteNonQueryText("insert into Bonus(BonusCode) values (@BonusCode)",
                            new System.Data.SqlClient.SqlParameter("@BonusCode", code));
            }
        }
        return;
        // FileStream fs;
        // fs = new FileStream("./Code.txt",FileMode.OpenOrCreate);
        //StreamReader sr = new StreamReader(fs);

        //while (txt_str!=null)
        //  while(sr.Peek()!=-1)
        //  {

        //     try
        //    {
        //        txt_str = sr.ReadLine().Trim();

        //         double amount = Biz.GenerateRandomAmount();
        //         try
        //         {
        //              SystemDAO.SqlHelper.ExecteNonQueryText("insert into Bonus(BonusCode) values (@BonusCode)",
        //                   new System.Data.SqlClient.SqlParameter("@BonusCode", txt_str));

        //           }
        //catch (Exception ex)
        //       {

        //       }
        //   }
        //   catch (Exception e)
        //    {

        //    }

        //  }

        //  sr.Close();
        //   fs.Close();


        // }
    }
}
