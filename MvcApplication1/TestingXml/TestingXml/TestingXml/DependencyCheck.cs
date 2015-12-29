using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ninject;
using Ninject.Modules;
using System.Collections;

namespace TestingXml
{
    public interface IView
    {
        void GetUsername();
    }

    public interface IService
    {
        void SaveUserInfo(object o);
    }

    public class Model
    {
        
        public void Save()
        { 
        }

        public void Get()
        {}

    }

    public class Presenter
    {
        private IView _view;
        private IService _service;
        private Model _model;

        public Presenter(IView view, IService service)
        {
            this._view = view;
            this._service=service;
        }

        public object CreateModel(Model model)
        {
            object obj = new object();
            this._model = model;
            return obj;
        }
    }

    public class ViewImplementation : IView
    {
        void IView.GetUsername()
        {
            throw new NotImplementedException();
        }
    }

    public class ViewImplementation1 : IView
    {
        void IView.GetUsername()
        {
            throw new NotImplementedException();
        }
    }

    public class PhaseModule : Ninject.Modules.NinjectModule
    {
        public override void Load()
        {
            Bind<IView>().To<ViewImplementation>();
            Bind<IView>().To<ViewImplementation1>();

          
        }
    }

  

    public abstract class TestingAbs
    {
        public void GetData()
        { 
        }
    }

    public class Employee
    {
        public int EmpNo { get; set; }
        public string EmpName { get; set; }
    }

    public class Derived : TestingAbs
    {
        public new void GetData()
        {
            Generic<Employee> g = new Generic<Employee>();
            

        }
    }

    public class Generic<T>
    {
        public T Field;
    }
    public class A
    {
        public T G<T>(T arg)
        {
            T temp = arg;
            return temp;
        }
    }

    public class G1<Tbase, Tbase2, TBase3> where Tbase2: Exception where TBase3: StringComparer
    { }

    public static class CheckFunctions
    {
        private static void CheckTables()
        {
            Hashtable opentable = new Hashtable();
            opentable.Add("v1", 1);
            opentable.Add("v2", "2");
        }

        public static Dictionary<TV, TK> Transpose<TK, TV>(this Dictionary<TK, TV> dicOld)
        {
            return new Dictionary<TV, TK>();
        }

        public static int Truth(params bool[] booleans)
        {
            return booleans.Count(b => b);
        }
    }

    public class TestingFeatures
    {
        public void GetData()
        {
            int[] numbers1 = new int[] { 1, 2, 3 };
            IEnumerable<int> numberssmall = numbers1.Where(p => p < 10);

           // IEnumerator<int> numberEnumerator = new int[] { 1, 2, 3 };
        }
    }

    public static class CheckingThreading
    {
        public static void factor(long x)
        {
            var factors = new List<long>();

            for (long i = 0; i <= Math.Abs(x); i++)
            {
                while (x % i == 0)
                {
                    x /= i;
                }
                factors.Add(i);
            }
            if (x != 1 || factors.Count == 1) factors.Add(x);

            Console.WriteLine(
                "{0} = {1}",
                x,
                string.Join(" x ", factors.Select(i => i.ToString()).ToArray()));
        }
    }
}
