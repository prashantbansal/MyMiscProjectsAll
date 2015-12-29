using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ninject;

namespace TestingNinject
{
    public class Sales1
    {
        private readonly ITaxCalculator _taxCalculator;

        public Sales1()
        {

        }

        public Sales1(ITaxCalculator taxCalculator)
        {
            this._taxCalculator = taxCalculator;
        }

        public double GetTotal(double amount)
        {
            return _taxCalculator.CalculateTax(amount);
        }
    }
}