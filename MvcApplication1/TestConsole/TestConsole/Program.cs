using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Linq;


namespace TestConsole
{
    class Program
    {
        private static void ParseXml()
        {
            XmlDocument xDoc = new XmlDocument();
            using(streamReader
            xDoc.LoadXml(@"C:\Users\Administrator\Desktop\Enrollment.Xml");

            var xmlStudentSchoolNodes = xDoc.SelectNodes("//studentSchool[school/schoolType='law']").
                Cast<XmlElement>().OrderByDescending(xElement => xElement["createdOn"].Value);
        }

        static void Main(string[] args)
        {
            ParseXml();

            //GetData();
            //List<Employee> empCollection = new List<Employee>();

            //var result = from res in empCollection
            //             group res by res.firstName into g
            //             select new
            //             {
            //                 EmpName = g.Key,
            //                 EmpCount = g.Count()
            //             };

            //DataTable table = new DataTable();
            //table.Columns.Add("txtAppDescription", typeof(String));
            //table.Columns.Add("txtAppUrl", typeof(decimal));
            //table.Columns.Add("txtMailType", typeof(String));
            //table.Columns.Add("intGBID", typeof(int));
            //table.Rows.Add("Etransfer", 4.0M, "A", 1234);
            //table.Rows.Add("Etransfer", 5.0M, "A", 1234);
            //table.Rows.Add("Performagic", 1.0M, "I", 1244);
            //table.Rows.Add("Performagic", 2.0M, "I", 1244);
            //table.Rows.Add("Amanat", 3.0M, "I", 1255);

            //var query = from row in table.AsEnumerable()
            //            group row by row.Field<String>("txtAppDescription") into grp
            //            orderby grp.Key
            //            select new 
            //            {
            //                Id = grp.Key,
            //                Sum = grp.Sum(r => r.Field<decimal>("txtAppUrl")),
            //                //MailType = row.Field<String>("txtMailType")
            //            }; 

            //foreach (var grp in query)
            //{
            //    Console.WriteLine("{0}\t{1}", grp.Id, grp.Sum);
            //}


            //List<Employee> abc =  empCollection.FindAll(r=> r.firstName.Equals("priyanka"));
            //Console.ReadLine();
        }

        public static void GetData()
        {
            List<Employee> empColln = new List<Employee>();
            Employee emp = null;
            
            emp = new Employee();
            emp.Weightage = 10;
            empColln.Add(emp);

            emp = new Employee();
            emp.Weightage = 20;
            empColln.Add(emp);

            emp = new Employee();
            emp.Weightage = 60;
            empColln.Add(emp);

            emp = new Employee();
            emp.Weightage = 40;
            empColln.Add(emp);

            emp = new Employee();
            emp.Weightage = 30;
            empColln.Add(emp);

            emp = new Employee();
            emp.Weightage = 20;
            empColln.Add(emp);

            var distinctValues = empColln.Select(x => x.Weightage).Distinct();
            int counter = 1;

            var values = empColln.Select(item => new { Key = item.Weightage, value = item.Weightage })
                .Distinct().
                OrderBy(item=>item.value).ToDictionary(item => counter++, item => item.value);
            //var values1 = empColln.Select(item => item.Weightage).Distinct().ToDictionary(item => counter++, item => item.value);

            int rowCounter = Convert.ToInt32(Math.Round(13 * 20.0 / 100.0));

            string s = "there, is, a, cat";
            if (!string.IsNullOrEmpty(s) && (s.Split(',').Count() > 1))
            {
 
            }
            string[] words = s.Split(' ');
            //foreach (string word in words)
            //{
            //    Console.WriteLine(word);
            //}


        }
    }

    public class Employee
    {
        public string firstName;
        
        public string LastName { get; set; }

        public int EmpCount;

        public decimal Weightage;

    }

    
}
