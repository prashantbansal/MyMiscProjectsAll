using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Text;
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;
using System.Collections;
using System.Collections.Generic;

namespace TestingMSCharts
{
    public partial class DrillDownChart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRecords();
            }
            else
            {
                Chart1.Serializer.Load(Server.MapPath("Chart1.xml"));
            }
        }

        void BindRecords()
        {
            Chart1.Legends.Clear();
            Chart1.Series.Clear();
            Chart1.ChartAreas.Clear();

            StringBuilder sb = new StringBuilder();
            //sb.Append("select a.EmployeeID, (a.FirstName + ' ' + a.LastName) 'FullName', count(b.OrderID) 'Orders' from ");
            //sb.Append("dbo.Employees a, dbo.Orders b, dbo.[Order Details] c, dbo.Products d ");
            //sb.Append("where a.EmployeeID = b.EmployeeID and b.OrderID = c.OrderID ");
            //sb.Append("and c.ProductID = d.ProductID ");
            //sb.Append("GROUP BY a.EmployeeID, a.FirstName + ' ' + a.LastName order by 1");

            DataTable dt = new DataTable();
            DataColumn dc;

            dc = new DataColumn();
            dc.ColumnName = "Name";
            dt.Columns.Add(dc);
            dc = new DataColumn();
            dc.ColumnName = "Age";
            dt.Columns.Add(dc);

            DataRow dr;
            dr = dt.NewRow();
            dr["Name"] = "Bid";
            dr["Age"] = "31";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Amendement";
            dr["Age"] = "26";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "RFP/RFQ";
            dr["Age"] = "20";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Subcontracting";
            dr["Age"] = "46";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Award";
            dr["Age"] = "7";
            dt.Rows.Add(dr);
            dr = dt.NewRow();
            dr["Name"] = "Grant";
            dr["Age"] = "2";
            dt.Rows.Add(dr);

            DataSet ds = new DataSet();
            ds.Tables.Add(dt);

           
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Chart1.ChartAreas.Add("Employee");
                    SetChartAreaFeatures(Chart1, "Employee");
                    Chart1.ChartAreas[0].AxisX.Title = "Employee Names";
                    Chart1.ChartAreas[0].AxisY.Title = "No of Orders";
                    Chart1.ChartAreas[0].AxisX.TitleFont = new System.Drawing.Font("Verdana", 10, System.Drawing.FontStyle.Bold);
                    Chart1.ChartAreas[0].AxisX.Minimum = 0;
                    Chart1.ChartAreas[0].AxisX.Interval = 10;
                    Chart1.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
                    Chart1.ChartAreas[0].AxisY.TitleFont = new System.Drawing.Font("Verdana", 10, System.Drawing.FontStyle.Bold);
                    Chart1.ChartAreas[0].AxisY2.LineColor = Color.Black;
                    Chart1.ChartAreas[0].AxisX.Url = "www.google.com";

                    Chart1.Series.Add("Employee");
                    Chart1.Series[0].IsVisibleInLegend = false;
                    Chart1.Series[0].Palette = ChartColorPalette.Bright;
                    Chart1.Series[0].ChartType = SeriesChartType.Column;
                    Chart1.Series[0]["DrawingStyle"] = "Emboss";
                    Chart1.Series[0].Points.DataBindXY(ds.Tables[0].DefaultView, "Name", ds.Tables[0].DefaultView, "Age");
                    Chart1.Legends.Add("Employee");

                    List<string> colorList = new List<string>();
                    colorList.Add("Red");
                    colorList.Add("Green");
                    colorList.Add("Yellow");
                    colorList.Add("Purple");
                    colorList.Add("Orange");
                    colorList.Add("Blue");
                    colorList.Add("Brown");
                    colorList.Add("Teal");
                    colorList.Add("SkyBlue");
                    colorList.Add("Flusia");
                    colorList.Add("Pink");

                    for (int i = 0; i < Chart1.Series[0].Points.Count; i++)
                    {
                        Chart1.Series[0].Points[i].Color = Color.FromName(colorList[i]);
                        Chart1.Series[0].Points[i].BorderWidth = 10;
                        Chart1.Series[0].Points[i].LabelUrl = "www.google.com" + i.ToString() + ".com";
                        Chart1.Series[0].Points[i].LabelToolTip = "lael tool tip";
                        Chart1.Series[0].Points[i].LegendToolTip = "legened tool tip";
                        Chart1.Series[0].Points[i].AxisLabel = "#VAL";

                    }

                    LegendItem legendItem = new LegendItem();
                    String sLegend = "";
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        Chart1.Series[0].Points[i].PostBackValue = ds.Tables[0].Rows[i][0].ToString();
                        sLegend = ds.Tables[0].Rows[i][1].ToString() + " ==> " + ds.Tables[0].Rows[i][1].ToString();
                        legendItem.Name = sLegend;
                        legendItem.BorderWidth = 1;
                        legendItem.ShadowOffset = 1;
                        legendItem.ToolTip = ds.Tables[0].Rows[i][1].ToString() + " ==> " + ds.Tables[0].Rows[i][1].ToString();
                        Chart1.Series[0].Points[i].ToolTip = ds.Tables[0].Rows[i][1].ToString() + " ==> " + ds.Tables[0].Rows[i][1].ToString();
                        legendItem.Color = Color.FromName(colorList[i].ToString());
                        Chart1.Legends[0].CustomItems.Add(legendItem);
                        legendItem = new LegendItem();
                    }

                    legendItem = null;
                    Chart1.Legends[0].TitleFont = new System.Drawing.Font("Verdana", 10, System.Drawing.FontStyle.Bold);
                    Chart1.Legends[0].Title = "Employee Details";
                    Chart1.Legends[0].TitleAlignment = StringAlignment.Center;
                    Chart1.Legends[0].TitleSeparator = LegendSeparatorStyle.ThickGradientLine;
                    Chart1.Legends[0].TitleSeparatorColor = Color.Orange;
                    Chart1.Legends[0].LegendStyle = LegendStyle.Table;
                    Chart1.Legends[0].TableStyle = LegendTableStyle.Wide;
                    Chart1.Legends[0].Docking = Docking.Bottom;
                    Chart1.Legends[0].Alignment = StringAlignment.Far;
                    Chart1.Legends[0].IsEquallySpacedItems = true;
                    Chart1.Serializer.Format = System.Web.UI.DataVisualization.Charting.SerializationFormat.Xml;
                    Chart1.Serializer.Save(Server.MapPath("Chart1.xml"));

                    Axis[] axes = Chart1.ChartAreas[0].Axes;

                    Grid grid = axes[0].MajorGrid;

                }
                ds = null;
            
            sb.Remove(0, sb.Length);
        }

        void SetChartAreaFeatures(Chart tmpChart, String tmpArea)
        {
            tmpChart.ChartAreas[tmpArea].BorderDashStyle = ChartDashStyle.Solid;
            tmpChart.ChartAreas[tmpArea].BorderWidth = 2;
            tmpChart.BorderSkin.SkinStyle = BorderSkinStyle.Emboss;
            tmpChart.BorderlineColor = System.Drawing.Color.FromArgb(26, 59, 105);
            tmpChart.BorderlineWidth = 2;
            tmpChart.BackColor = Color.AliceBlue;
            tmpChart.ChartAreas[tmpArea].BackColor = Color.White;
            tmpChart.ChartAreas[tmpArea].BackHatchStyle = ChartHatchStyle.None;
            tmpChart.ChartAreas[tmpArea].BackGradientStyle = GradientStyle.None;
            tmpChart.ChartAreas[tmpArea].BorderColor = Color.Black;
            tmpChart.ChartAreas[tmpArea].BorderDashStyle = ChartDashStyle.Solid;
            tmpChart.ChartAreas[tmpArea].BorderWidth = 1;
        }

        protected void Chart1_Click(object sender, ImageMapEventArgs e)
        {
            Chart2.Legends.Clear();
            Chart2.Series.Clear();
            Chart2.ChartAreas.Clear();

            StringBuilder sb = new StringBuilder();
            sb.Append("select distinct top 10 c.ProductName, sum(b.Quantity) 'Quantity' from");
            sb.Append(" dbo.Orders a, dbo.[Order Details] b, dbo.Products c");
            sb.Append(" where a.OrderID = b.OrderID and b.ProductID = c.ProductID");
            sb.Append(" and a.EmployeeID = @EID");
            sb.Append(" group by c.ProductName order by 1");

            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand(sb.ToString(), con))
                {
                    SqlParameter param = new SqlParameter();
                    param.ParameterName = "@EID";
                    param.SqlValue = e.PostBackValue;
                    cmd.Parameters.Add(param);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        sda.Fill(ds);
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            Chart2.ChartAreas.Add("Products");
                            SetChartAreaFeatures(Chart2, "Products");
                            Chart2.ChartAreas[0].AxisX.Title = "Products Name";
                            Chart2.ChartAreas[0].AxisY.Title = "Product Quantity";
                            Chart2.ChartAreas[0].AxisX.TitleFont = new System.Drawing.Font("Verdana", 10, System.Drawing.FontStyle.Bold);
                            Chart2.ChartAreas[0].AxisX.Minimum = 0;
                            Chart2.ChartAreas[0].AxisX.Interval = 1;
                            Chart2.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
                            Chart2.ChartAreas[0].AxisY.TitleFont = new System.Drawing.Font("Verdana", 10, System.Drawing.FontStyle.Bold);
                            Chart2.ChartAreas[0].AxisY2.LineColor = Color.Black;

                            Chart2.Series.Add("Products");
                            Chart2.Series[0].Palette = ChartColorPalette.Bright;
                            Chart2.Series[0].ChartType = SeriesChartType.Column;
                            Chart2.Series[0]["DrawingStyle"] = "Cylinder";
                            Chart2.Series[0].Points.DataBindXY(ds.Tables[0].DefaultView, "ProductName", ds.Tables[0].DefaultView, "Quantity");
                        }
                        ds = null;
                    }
                }
            }
            sb.Remove(0, sb.Length);
        }
    }
}