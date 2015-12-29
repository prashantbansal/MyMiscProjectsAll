using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataVisualization
{
    public interface IAgencyPurchases
    {
        object TotalPurchasesStartDate { get; set; }

        object TotalPurchasesEndDate { get; set; }

        void BindTotalPurchases(object TotalPurchases);

        void BindPurchasesByIndustry(object PurchasesByIndustry);
    }
}
