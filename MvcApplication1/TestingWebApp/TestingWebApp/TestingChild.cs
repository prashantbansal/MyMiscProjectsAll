using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestingWebApp
{
    public class TestingChild: TestingBase
    {

        public override void GetData()
        {
            throw new NotImplementedException();
        }


        public new void GetInfo()
        {
            string a = "cdd";
        }
    }
}
