using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingDP.InterfaceSeggreation
{
    #region exampleOld
    public interface IWorker
    {
        void Work();
        void Eat();
    }

    class Worker : IWorker
    {
        public void Work()
        { 
        }

        public void Eat()
        { 
        }
    }

    class Robot : IWorker
    {
        public void Work()
        {
        }

        public void Eat()
        {
            throw new NotImplementedException();
        }
    }

    class Manager
    {
        IWorker worker;

        public void SetWorker(IWorker w)
        {
            this.worker = w;
        }

        public void Manage()
        {
            worker.Work();
        }
    }
    #endregion exampleOld

    #region WorkingExmaple
    interface Workable
    {
        void Work();
    }

    interface Feedable
    {
        void Eat();
    }

    interface IWorkerWE : Workable, Feedable
    { 

    }

    class WorkerWE : Workable, Feedable
    {
        public void Work() { }

        public void Eat() { }
    }

    class RobotWE : Workable
    {
        public void Work() { }
    }

    class SuperWorkerWE : Workable, Feedable
    {
        public void Work() { }

        public void Eat() { }
    }

    class ManagerWE
    {
        IWorker worker;
        public void SerWorker(Worker w)
        {
            worker = w;
        }

        public void Manage()
        {
            worker.Work();
        }
    }

    #endregion WorkingExmaple

}
