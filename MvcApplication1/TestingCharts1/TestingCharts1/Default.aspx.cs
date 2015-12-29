using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;
using System.Data;
using System.Web.UI.MobileControls;
using System.IO;

namespace TestingCharts1
{
    public class PurchaseData
    {
        public int Year = 2011;
        public int month = 12;
        private DateTime date;
        public DateTime Date
        {
            get 
            {
                return new DateTime(this.Year,this.month, 1);
            }
            set
            { 
                date = value; 
            }
        }


        public PurchaseData()
        {
            
        }
    }

    public partial class _Default : System.Web.UI.Page
    {
        public string imageLocation;

        protected void Page_Load(object sender, EventArgs e)
        {
            PurchaseData data = new PurchaseData();
            data.Year = 2011;
            data.month = 3;


            List<PurchaseData> purchaseData = new List<PurchaseData>();
            purchaseData.Add(new PurchaseData() { Year = 2011, month = 3});
            purchaseData.Add(new PurchaseData() { Year = 2011, month = 2 });
            purchaseData.Add(new PurchaseData() { Year = 2011, month = 1 });
            //purchaseData.Add(new PurchaseData() { Year = 2010, month = 12 });
            //purchaseData.Add(new PurchaseData() { Year = 2010, month = 11 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 10 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 9 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 8 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 7 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 6 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 5 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 4 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 3 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 2 });
            purchaseData.Add(new PurchaseData() { Year = 2010, month = 1 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 12 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 11 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 10 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 9 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 8 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 7 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 6 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 5 });
            purchaseData.Add(new PurchaseData() { Year = 2009, month = 4 });

            DateTime date1 = new DateTime(2011, 3, 1);
            DateTime date2 = date1.AddMonths(-11);

            List<PurchaseData> FinalCollection = new List<PurchaseData>();

            int counter = 0;
            PurchaseData purchaseDataObj = null;
            for (int i = 0; i < 24; i++)
            {
                DateTime Date3=date1.AddMonths(counter);
                purchaseDataObj = null;
                purchaseDataObj = purchaseData.Find(p => p.Date.Equals(Date3));

                if (purchaseDataObj != null)
                {
                    FinalCollection.Add(purchaseDataObj);
                }
                else
                { 
                    FinalCollection.Add(new PurchaseData(){Year=Date3.Year,month=Date3.Month});
                }
                counter = counter - 1;
            }

            List<PurchaseData> resultDataFirstYear = FinalCollection.Take(12).ToList();
            List<PurchaseData> resultDataLastYear = FinalCollection.Skip(resultDataFirstYear.Count).ToList();

            //List<PurchaseData> resultDataFirstYear = (from result in FinalCollection
            //                                                 where result.Date <= date1 && result.Date >= date2
            //                                                 select result).ToList();

            
                         

            try
            {
                List<string> stringcollection = new List<string>();
                stringcollection.Add("1");
                stringcollection.Add("2");
                stringcollection.Add("3");
                stringcollection.Add("4");
                stringcollection.Add("5");
                stringcollection.Add("6");
                stringcollection.Add("7");
                stringcollection.Add("8");
                stringcollection.Add("9");
                stringcollection.Add("10");

                for (int i = stringcollection.Count; i > 0; i--)
                {
                    string value = stringcollection[i-1];
                }

                if (!IsPostBack)
                {
                    this.FillBarGraphData();
                }
            }
            catch (Exception)
            {
                
                throw;
            }
           
        }

        private void FillBarGraphData()
        {
            DataTable dt = new DataTable();
            DataColumn dc;

            dc = new DataColumn();
            dc.ColumnName = "Name";
            dt.Columns.Add(dc);
            dc = new DataColumn();
            dc.ColumnName = "Age";
            dt.Columns.Add(dc);
            dc = new DataColumn();
            dc.ColumnName = "Occupation";
            dt.Columns.Add(dc);

            DataRow dr;
            dr = dt.NewRow();
            dr["Name"] = "Bid";
            dr["Age"] = "31";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Amendement";
            dr["Age"] = "26";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "RFP/RFQ";
            dr["Age"] = "20";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Subcontracting";
            dr["Age"] = "46";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Award";
            dr["Age"] = "7";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Grant";
            dr["Age"] = "2";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);

            Chart1.DataSource = dt;

            Chart1.Series["Series1"].XValueMember = "Name";
            Chart1.Series["Series1"].YValueMembers = "Age";
            Chart1.DataBind();

            Chart1.SaveImage(@"C:\mychart.png");

            categoriesImg.Src = @"C:\mychart.png";

            imageLocation = Chart1.ImageLocation;
            ////alternate option
            //double plotY = 0;
            //if (Chart2.Series["Series1"].Points.Count > 0)
            //{
            //    plotY = Chart2.Series["Series1"].Points[Chart2.Series["Series1"].Points.Count - 1].YValues[0];
            //}

            //for (int pointIndex = 0; pointIndex < dt.Rows.Count; pointIndex++)
            //{
            //    plotY = Convert.ToInt16(dt.Rows[pointIndex]["Age"]);
            //    //Chart2.Series["Series1"].Points.AddY(plotY);
            //    Chart2.Series["Series1"].Points.AddXY("a", plotY);
            //} 
        }

        protected void downloadImage_Click(object sender, EventArgs e)
        {
            using (MemoryStream stream = new MemoryStream())
            {
                this.Chart1.SaveImage(stream, ChartImageFormat.Png);

                this.Response.AddHeader("Content-Disposition", "attachment;filename=\"chart1.png\"");

                this.Response.BinaryWrite(stream.ToArray());
                this.Response.Flush();
                this.Response.End();
            }
        }
    }
}
