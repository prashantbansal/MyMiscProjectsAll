using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ninject;

namespace TestingNinject
{
    class Program
    {
        static void Main(string[] args)
        {
            using (IKernel kernel = new StandardKernel())
            {
                kernel.Bind<ITaxCalculator>().To<TaxCalculator>().WithConstructorArgument("rate", 0.2);

                var tc = kernel.Get<ITaxCalculator>();

                var result = tc.CalculateTax(200);
            }

            using (IKernel kernel = new StandardKernel())
            {
                kernel.Bind<ITaxCalculator>().To<TaxCalculator>().WithConstructorArgument("rate", 0.2);

                var sale = new Sales(kernel.Get<ITaxCalculator>());

                var result = sale.GetTotal(200);
            }

            using (IKernel kernel = new StandardKernel())
            {
                kernel.Bind<ITaxCalculator>().To<TaxCalculator>().WithConstructorArgument("rate", 0.2);

                var sale = new Sales(kernel.Get<ITaxCalculator>());

                var result = sale.GetTotal(200);
            }

            using (IKernel kernel = new StandardKernel())
            {
                kernel.Bind<ITaxCalculator>().To<TaxCalculator>().WithConstructorArgument("rate", 0.2);

                var sale = kernel.Get<Sales>();

                var result = sale.GetTotal(200);
            }

            using (IKernel kernel = new StandardKernel())
            {
                kernel.Bind<ITaxCalculator>().To<TaxCalculator>().WithConstructorArgument("rate", 0.2);

                var sale1 = kernel.Get<Sales1>();

                var result = sale1.GetTotal(200);
            }

            using (IKernel kernel = new StandardKernel())
            {
                kernel.Bind<ITaxCalculator>().To<TaxCalculator>().WithConstructorArgument("rate", 0.2);

                var lineItem1 = new SalesLineItem() { TotalPrice = 200 };
                var lineItem2 = new SalesLineItem() { TotalPrice = 200 };

                var sale2 = kernel.Get<Sales2>();
                sale2.AddItem(lineItem1);
                sale2.AddItem(lineItem2);

                var result = sale2.GetTotal();
            }

            AsyncCalls();
        }

        public delegate string AsyncDelegate(int callDuration, out int ThreadId);
        private static int ThreadId;
        public static void AsyncCalls()
        {
            AsyncTesting at = new AsyncTesting();
            AsyncDelegate asyncDelete = new AsyncDelegate(at.Foo);
            for (int i = 0; i < 10; i++)
            {
                IAsyncResult ar = asyncDelete.BeginInvoke(i, out ThreadId, new AsyncCallback(CallBackMethod), asyncDelete);
                //string ret = asyncDelete.Invoke(10,out ThreadId);
                //string ret=asyncDelete.EndInvoke(out ThreadId, ar);
                //Console.WriteLine(ret);
            }
        }

        public static void CallBackMethod(IAsyncResult ar)
        {
            AsyncDelegate dlgt = (AsyncDelegate)ar.AsyncState;

            string ret = dlgt.EndInvoke(out ThreadId, ar);

            Console.WriteLine(ret);
            Console.WriteLine(ThreadId);
        }
    }
}
