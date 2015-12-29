using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ElmahImplementation
{
    public partial class ErrorTesting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //throw new Exception("An exception has been raised.");
            throw new Exception("This is unhandled error");
        }

        public void RaiseError()
        {
 
        }
    }
}