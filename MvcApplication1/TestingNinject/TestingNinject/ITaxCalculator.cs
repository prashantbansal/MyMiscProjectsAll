using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TestingNinject
{
    public interface ITaxCalculator
    {
        double CalculateTax(double amount);
    }
}
