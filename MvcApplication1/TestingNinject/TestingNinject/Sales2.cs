using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Ninject;
using System.Linq.Expressions;

namespace TestingNinject
{
    public class SalesLineItem
    {
        public string ItemName { get; set; }

        public double TotalPrice
        {
            get;
            set;
        }
    }

    public class Sales2
    {

        public ITaxCalculator _taxCalculator { get; set; }

        private List<SalesLineItem> lineItems = new List<SalesLineItem>();

        public void AddItem(SalesLineItem item)
        {
            lineItems.Add(item);
        }

        [Inject]
        public void SetTaxCalculator(ITaxCalculator taxCalculator)
        {
            this._taxCalculator = taxCalculator;
        }

        public Sales2()
        {

        }

        public double GetTotal()
        {
            double total = 0;
            foreach (var item in this.lineItems)
            {
                total += this._taxCalculator.CalculateTax(item.TotalPrice) + item.TotalPrice;
            }
            return total;
        }
    }
}