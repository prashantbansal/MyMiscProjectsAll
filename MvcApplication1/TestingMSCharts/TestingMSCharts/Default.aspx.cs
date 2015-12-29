using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;
using System.Data;
using System.Drawing; 

namespace TestingMSCharts
{
    public partial class _Default : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //Chart1.Series["Series1"].ChartType = SeriesChartType.Line;
            //Chart1.Series["Series2"].ChartType = SeriesChartType.Line;

            //Chart2.Series["Series1"].ChartType = SeriesChartType.Bar;
            //Chart2.Series["Series1"]["DrawingStyle"] = "Emboss";
            //Chart2.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = true;
            //Chart2.Series["Series1"].LegendToolTip = "111";
            ////Chart2.Series["Series1"].ToolTip = "tool tip";
            //Chart2.Series["Series1"].IsValueShownAsLabel = true;
            //Chart2.Series["Series1"].ToolTip = "Data Point Y Value: #VALY{G}";
            //Chart2.Series["Series1"] = Color.Orange;
            //Chart2.Legends.Add("testingLegend");

            uxTopCategories.Series["TopCategoriesSeries"]["PixelPointWidth"] = "10";
            

            //this.FillData();

            this.FillBarGraphData();

        }

        //private void FillData()
        //{
        //    double plotY = 50.0;
        //    if (Chart1.Series["Series1"].Points.Count > 0)
        //    {
        //        plotY = Chart1.Series["Series1"].Points[Chart1.Series["Series1"].Points.Count - 1].YValues[0];
        //    }

        //    Random random = new Random();
        //    for (int pointIndex = 0; pointIndex < 20000; pointIndex++)
        //    {
        //        plotY = plotY + (float)(random.NextDouble() * 10.0 - 5.0);
        //        Chart1.Series["Series1"].Points.AddY(plotY);
        //    }


        //    if (Chart1.Series["Series2"].Points.Count > 0)
        //    {
        //        plotY = Chart1.Series["Series2"].Points[Chart1.Series["Series1"].Points.Count - 1].YValues[0];
        //    }
        //    for (int pointIndex = 0; pointIndex < 20000; pointIndex++)
        //    {
        //        plotY = plotY + (float)(random.NextDouble() * 10.0 - 5.0);
        //        Chart1.Series["Series2"].Points.AddY(plotY);
        //    }
        //}

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
            dr = dt.NewRow();
            dr["Name"] = "Grant1";
            dr["Age"] = "2";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Grant2";
            dr["Age"] = "2";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Grant3";
            dr["Age"] = "2";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Grant4";
            dr["Age"] = "2";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Grant5";
            dr["Age"] = "1";
            dr["Occupation"] = "Sales";
            dt.Rows.Add(dr);

            //Chart2.ChartAreas[0].AxisX.Title = "User Roles";
            //Chart2.ChartAreas[0].AxisX.TitleFont = new System.Drawing.Font("Verdana", 10, System.Drawing.FontStyle.Bold);
            //Chart2.ChartAreas[0].AxisY.Title = "User Count";
            //Chart2.ChartAreas[0].AxisY.TitleFont = new System.Drawing.Font("Verdana", 10, System.Drawing.FontStyle.Bold);
            //Chart2.ChartAreas[0].AxisY2.LineColor = Color.Black;
            //Chart2.ChartAreas[0].BorderDashStyle = ChartDashStyle.Solid;
            //Chart2.ChartAreas[0].BorderWidth = 1;
            //Chart2.ChartAreas[0].AxisX.LabelAutoFitMaxFontSize = 100;
            //Chart2.ChartAreas[0].AxisY.LabelAutoFitMaxFontSize = 10;
            //Chart2.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            //Chart2.BorderlineColor = System.Drawing.Color.FromArgb(26, 59, 105);
            //Chart2.BorderlineWidth = 100;
            //Chart2.BackColor = Color.AliceBlue;
            
            //for (int j = 0; j < Chart2.Legends.Count; j++)
            //{
            //    Chart2.Legends[j].BorderColor = Color.Black;
            //    Chart2.Legends[j].BorderWidth = 100;
            //    Chart2.Legends[j].BorderDashStyle = ChartDashStyle.Solid;
            //    Chart2.Legends[j].ShadowOffset = 1;
            //    Chart2.Legends[j].LegendStyle = LegendStyle.Table;
            //    Chart2.Legends[j].TableStyle = LegendTableStyle.Auto;
            //    Chart2.Legends[j].Docking = Docking.Bottom;
            //    Chart2.Legends[j].Alignment = StringAlignment.Center;
            //    Chart2.Legends[j].Enabled = true;
            //    Chart2.Legends[j].Font = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
            //    Chart2.Legends[j].AutoFitMinFontSize = 5;
            //}

            //uxTopCategories.DataSource = dt;

            //uxTopCategories.Series["TopCategoriesSeries"].XValueMember = "Name";
            //uxTopCategories.Series["TopCategoriesSeries"].YValueMembers = "Age";
            //uxTopCategories.DataBind();

            foreach (DataRow row in dt.Rows)
            {
                uxTopCategories.Series["TopCategoriesSeries"].Points.AddXY(row[0].ToString(), Convert.ToInt32(row[1].ToString()));
            }

            //Chart2.DataSource = dt;
            //Chart2.Series["Series2"].XValueMember = "Name";
            //Chart2.Series["Series2"].YValueMembers = "Age";
            //Chart2.DataBind();

            //Chart2.ChartAreas[0].AxisX.Url = "www.google.com?=" + "#VALY{G}";
            

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

        protected void Chart2_Click(object sender, ImageMapEventArgs e)
        {

        }
    }
}
