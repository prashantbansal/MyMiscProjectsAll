using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using TestingDP.ObserverPattern;

namespace TestingDP
{
    class Program
    {
        static void Main(string[] args)
        {
            //Rectangle r = GetObject.GetNewRectangle();
            //r.SetHeight(10);
            //r.SetWidth(5);

            //int area = r.GetArea();

            //Singleton ra = Singleton.Instance();

            ConcreteSubject s = new ConcreteSubject();
            s.Attach(new ConcreteObserver(s,"X"));
            s.Attach(new ConcreteObserver(s,"Y"));
            s.Attach(new ConcreteObserver(s,"Z"));

            s.SubjectState = "ABC";
            s.Notify();

            Console.ReadKey();
        }
    }
}
