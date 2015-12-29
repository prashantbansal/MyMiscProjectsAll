using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestingDesignPrinciples
{
    
    public class Singleton
    {
        private static Singleton instance;

        private Singleton()
        {
 
        }

        public static Singleton GetInstance()
        {
            if (instance == null)
            {
                instance = new Singleton();
            }
            return instance;
        }

        public void DoSomething()
        {
 
        }
    }
}
