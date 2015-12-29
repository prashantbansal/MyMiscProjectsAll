using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestingDesignPrinciples
{
    public interface IProduct
    {
        void GetId();
    }

    public abstract class Creator
    {
        public void DoOperation()
        {
            IProduct product = FactoryMethod();
        }

        protected abstract IProduct FactoryMethod();
    }

    public class ConcreateProduct : IProduct
    {
        #region IProduct Members

        public void GetId()
        {
            throw new NotImplementedException();
        }

        #endregion
    }

    public class ConcreateCreator : Creator
    {
        protected override IProduct FactoryMethod()
        {
            return new ConcreateProduct();
        }
    }

    public class Client
    {
        public void GetData()
        {
            ConcreateCreator creator1 = new ConcreateCreator();
            creator1.DoOperation();
        }
        
    }
}
