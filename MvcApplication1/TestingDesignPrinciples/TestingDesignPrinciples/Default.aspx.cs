using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TestingDesignPrinciples
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //GraphicEditor gd = new GraphicEditor();
            //Rectangle r = new Rectangle();
            //gd.DrawShape(r);

            //Manager manager = new Manager();
            //Worker sw = new Worker();
            //manager.SetWorker(sw);
            //manager.Manage();

            //Singleton.GetInstance().DoSomething();

            IOrder o = new Order("2");


        }
    }
}
