using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace TestingXml
{
    public class PerformanceCounterCheck
    {
        private const string category="aa";
        private const string counterName="aa";
        private static PerformanceCounter pc;

        private readonly Dictionary<string, string> categories = new Dictionary<string, string>();

        public Dictionary<string, string> Categories
        {
            get { return categories; }
        }

        public PerformanceCounterCheck()
        {
            //Categories.Add("aa", "aa");

            //foreach (var a in Categories)
            //{
            //    category = a.Key;
            //    counterName = a.Value;
            //}
        }

        public void CreateNewPerformanceCounter()
        {
            try
            {
                pc = new PerformanceCounter(category, counterName, Process.GetCurrentProcess().ProcessName);
            }
            catch (Exception ex)
            {
                
                throw;
            }
            
        }

    }
}
