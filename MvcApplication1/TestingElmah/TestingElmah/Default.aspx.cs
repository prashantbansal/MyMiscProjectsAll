using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestingElmah
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            double numerator = 13.0;
            int denominator = 5;
            double value = Math.Round(4.4999);

            throw new Exception("this is exception raised exceptionally");
        }
    }
}
