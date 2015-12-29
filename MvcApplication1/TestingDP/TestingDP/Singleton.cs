using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingDP
{
    public class Singleton
    {
        private static volatile Singleton _instance;
        
        private Singleton()
        { 
        }

        public static Singleton Instance()
        {
            if (_instance == null)
            {
                lock (typeof(Singleton))
                {
                    if (_instance == null)
                    {
                        _instance = new Singleton();
                    }
                }
            }
            return _instance;
        }
    }
}
