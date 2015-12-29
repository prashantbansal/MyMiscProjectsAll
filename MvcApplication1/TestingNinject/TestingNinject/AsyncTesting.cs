using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingNinject
{
    public class AsyncTesting
    {
        public string Foo(int callDuration, out int ThreadId)
        {
            System.Threading.Thread.Sleep(10);
            Console.WriteLine("Callduration" + callDuration.ToString());
            ThreadId = AppDomain.GetCurrentThreadId();

            return "my call duration was " + callDuration.ToString();
        }
    }
}