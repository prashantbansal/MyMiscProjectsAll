using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Onvia.Services.Proxies.DV;
using Onvia.Library.Utils;

namespace DataVisualizationCaching
{
    class Program
    {
        public static void Main(string[] args)
        {
            try
            {
                DVProxy dvProxy;
                //Console.WriteLine("Calling Service for Get Onvia Cache");
                //dvProxy = DVProxyFactory.GetProxy(GgBinding.NetTcpBinding);
                //dvProxy.SetMyOnviaReportsCache();
                //Console.WriteLine("Called Service for Get Onvia Cache");

                Console.WriteLine("Calling Service for Get reports Cache");
                dvProxy = DVProxyFactory.GetProxy(GgBinding.NetTcpBinding);
                dvProxy.SetAgencyReportsCache();
                Console.WriteLine("Called Service for Get Reports Cache");
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }
    }
}
