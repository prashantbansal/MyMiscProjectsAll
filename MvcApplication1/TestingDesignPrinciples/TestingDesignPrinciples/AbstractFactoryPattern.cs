using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace TestingDesignPrinciples
{
    public class AbstractFactoryPattern
    {
        abstract class AbstractProductA
        {
            public abstract void Operation1A();
            public abstract void Operation2A();
        }

        class ProductA1 : AbstractProductA
        {
            public ProductA1(string arg)
            {
 
            }
            public override void Operation1A()
            {
                throw new NotImplementedException();
            }

            public override void Operation2A()
            {
                throw new NotImplementedException();
            }
        }

        class ProductA2 : AbstractProductA
        {
            ProductA2(string arg)
            { 
            }

            public override void Operation1A()
            {
                throw new NotImplementedException();
            }

            public override void Operation2A()
            {
                throw new NotImplementedException();
            }
        }

        abstract class AbstractProductB
        {
            public abstract void Operation1B();
            public abstract void Operation2B();
        }

        class ProductB1 : AbstractProductB
        {
            public ProductB1(string arg)
            { 
            }
            public override void Operation1B()
            {
                throw new NotImplementedException();
            }

            public override void Operation2B()
            {
                throw new NotImplementedException();
            }
        }

        class ProductB2 : AbstractProductB
        {
            public ProductB2(string arg)
            { 
            }
            public override void Operation1B()
            {
                throw new NotImplementedException();
            }

            public override void Operation2B()
            {
                throw new NotImplementedException();
            }
        }

        abstract class AbstractFactory
        {
            public abstract AbstractProductA CreateProductA();
            public abstract AbstractProductB CreateProductB();
        }

        class ConcreateFactory1 : AbstractFactory
        {

            public override AbstractProductA CreateProductA() 
            {
                return new ProductA1("qq");
            }
            

            public override AbstractProductB CreateProductB()
            {
                return new ProductB1("sdad");
            }
        }
    }

    public class Customer
    {
        public int CustId { get; set; }

        public string Name { get; set; }
    }

    public class CheckData
    {
        public void GetData()
        {
            List<Customer> custColln = new List<Customer>();

            //List<Customer> cust2 = custColln.Distinct((c1,c2)=> c1.CustId == c2.CustId).ToList();
        }
    }
}
