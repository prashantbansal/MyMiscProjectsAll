using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingDP
{
    #region exampleOld
    public class Worker
    {
        public void DoWork()
        {
        }
    }

    public class Manager
    {
        Worker w;

        public void SetWorker(Worker worker)
        {
            w = worker;
        }

        public void Manage()
        {
            w.DoWork();
        }
    }

    public class SuperWorker
    {
        public void DoSomeWork()
        {
        }
    }

    #endregion exampleOld

    #region DP Example
    public interface IWorker
    {
        void DoWork();
    }

    public class DPWorker : IWorker
    {
        public void DoWork()
        { 

        }
    }

    public class DPSuperWorker : IWorker
    {
        public void DoWork()
        {

        }
    }

    public class DPManager
    {
        IWorker worker;

        public void SetWorker(IWorker w)
        {
            worker = w;
        }

        public void Manage()
        {
            worker.DoWork();
        }
    }

    #endregion DP Example
}
