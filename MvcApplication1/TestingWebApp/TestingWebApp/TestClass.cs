using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestingWebApp
{
    public class BaseClass
    {
        public int StudentID { get; set; }

        public string StudentName { get; set; }
    }

    public class InheritedClass: BaseClass
    {
        public string StudentSchool { get; set; }
    }
}