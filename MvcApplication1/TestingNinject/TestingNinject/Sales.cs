using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingNinject
{
    public class Sales
    {
        private readonly ITaxCalculator _taxCalculator;

        public Sales(ITaxCalculator taxCalculator)
        {
            this._taxCalculator = taxCalculator;
        }

        public double GetTotal(double amount)
        {
            return _taxCalculator.CalculateTax(amount);
        }
    }
}