using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace iMidudu
{
  public  class Data
    {
        private static readonly iMidudu.iMiduduEntities instance = null;
        static Data()
        {
            instance = new iMiduduEntities();
        }
        public static iMiduduEntities Instance
        {
            get
            {
                return instance;
            }
        }
    }
}
