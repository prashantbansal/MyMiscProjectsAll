using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Set the chart type
        Chart1.Series["Series1"].ChartType = SeriesChartType.Pie;
        //add points
        Chart1.Series["Series1"].Points.AddY(12);
        Chart1.Series["Series1"].Points.AddY(45);
        Chart1.Series["Series1"].Points.AddY(67);
        //set back color of chart object
        Chart1.BackColor = System.Drawing.Color.Blue;
        //set back color of chart area
        Chart1.ChartAreas["ChartArea1"].BackColor = System.Drawing.Color.Green;

    }
}