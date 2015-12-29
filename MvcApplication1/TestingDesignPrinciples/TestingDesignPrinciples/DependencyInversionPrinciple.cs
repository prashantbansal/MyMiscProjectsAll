using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

//namespace TestingDesignPrinciples
//{
//    public class DependencyInversionPrinciple
//    {
//        public class Worker
//        {
//            public void Work()
//            {

//            }
//        }

//        public class Manager
//        {
//            Worker worker;

//            public void SetWorker(Worker w)
//            {
//                worker = w;
//            }

//            public void manage()
//            {
//                worker.Work();
//            }
//        }

//        public class SuperWorker
//        {
//            public void Work()
//            {
 
//            }
//        }
//    }
//}

namespace TestingDesignPrinciples
{
    public interface IWorkable
    {
        void Work();
    }

    public interface IEatable
    {
        void Eat();
    }

    public class Worker : IWorkable, IEatable
    {
        #region IWorker Members

        public void Work()
        {
            throw new NotImplementedException();
        }
        public void Eat()
        {
            throw new NotImplementedException();
        }

        #endregion
    }

    public class Robot : IEatable
    {
        #region IWorker Members

        public void Eat()
        {
            throw new NotImplementedException();
        }

        #endregion
    }

    public class Manager
    {
        IWorkable worker;

        public void SetWorker(IWorkable w)
        {
            this.worker = w;
        }

        public void Manage()
        {
            this.worker.Work();
        }
    }
}