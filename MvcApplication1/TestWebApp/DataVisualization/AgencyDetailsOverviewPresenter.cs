using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataVisualization
{
    public class AgencyDetailsOverviewPresenter
    {
        IAgencyPurchases AgencyPurchases { get; set; }

        IAgencyDetailsOverview AgencyDetailsOverview { get; set; }

        public object GetAgencyDetailsOverview(Guid AgencyId)
        { 
            return new object();
        }

        public AgencyDetailsOverviewPresenter(IAgencyPurchases AgencyPurchase)
        {
            this.AgencyPurchases = AgencyPurchase;
        }

        public void InitializeView()
        {
 
        }
    }
}
