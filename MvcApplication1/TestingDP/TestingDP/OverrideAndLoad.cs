using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingDP
{
    class baseClass
    {
        public virtual void GetData(int a)
        {

        }
    }

    class overriddenClass : baseClass
    {
        public override void GetData(int a)
        {

        }
    }

    class OverloadClass
    {
        public int GetData(int a, string b)
        {
            return 0;
        }

        public string GetData(string a, string b)
        {
            return "0";
        }
    }
}
