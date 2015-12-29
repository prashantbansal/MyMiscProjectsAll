using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml;
using System.Diagnostics;
using System.Threading;

namespace TestingXml
{
    class Program
    {
        static void Main(string[] args)
        {
            //CheckPerformanceCounter();

            Dictionary<string, string> dic = new Dictionary<string, string>();

            if (!dic.ContainsKey("a"))
            {
 
            }
        }

        private static void CheckPerformanceCounter()
        {
            PerformanceCounterCheck check = new PerformanceCounterCheck();
            check.CreateNewPerformanceCounter();
        }

        [Trace("MyCategory1")]
        private static void SayHello()
        {
            Console.WriteLine("SayHello");
        }

        [Trace("MyCategory2")]
        private static void SayGoodBye()
        {
            Console.WriteLine("SayGoodBye");
        }

        public static void Check()
        {
            //Console.WriteLine("Hello");

            //int count;
            //count = CheckFunctions.Truth(new bool[3] { true, true, false });

            //string[] filePaths = Directory.GetFiles(@"D:\Prashant\Code\TestingXml\TestingXml\TestingXml\SearchXmls\");
            //List<XmlDocument> xmls = new List<XmlDocument>();

            //if (filePaths != null && filePaths.Count() > 0)
            //{
            //    foreach (string xmlPath in filePaths)
            //    {
            //        StreamReader streamReader = new StreamReader(xmlPath);
            //        string text = streamReader.ReadToEnd();
            //        streamReader.Close();

            //        XmlDocument doc = new XmlDocument();
            //        doc.LoadXml(text);
            //        xmls.Add(doc);
            //    }
            //}


            // PhaseModule module = new PhaseModule();
            //Trace.Listeners.Add(new TextWriterTraceListener(Console.Out));

            //SayHello();
            //SayGoodBye();

            TransactionScopeCheck scopeCheck = new TransactionScopeCheck();
            scopeCheck.CheckTransaction();

            //while (true)
            //{
            //    string line = Console.ReadLine();
            //    long x = long.Parse(line);
            //    ThreadPool.QueueUserWorkItem((o) => CheckingThreading.factor(x));
            //}

        }
    }
}