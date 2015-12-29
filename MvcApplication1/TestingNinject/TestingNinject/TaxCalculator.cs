using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingNinject
{
    public class TaxCalculator: ITaxCalculator
    {
        private readonly double _rate;

        public TaxCalculator(double rate)
        {
            this._rate = rate;
        }

        public double CalculateTax(double amount)
        {
            return _rate * amount / 100;
        }
    }
}
