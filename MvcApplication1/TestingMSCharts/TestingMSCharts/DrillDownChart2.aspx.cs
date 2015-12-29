using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Web.UI.DataVisualization.Charting;

public partial class DrillDownChart2 : System.Web.UI.Page, System.Web.UI.ICallbackEventHandler
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Chart1.Series["Series1"].Color = Color.Green;
            Chart1.Series["Series2"].Color = Color.Orange;
            Chart1.Series["Series3"].Color = Color.Blue;
            Random random = new Random();
            for (int i = 0; i < 5; i++)
            {
                Chart1.Series["Series1"].Points.AddXY(i, random.Next(10, 1000));
                Chart1.Series["Series2"].Points.AddXY(i, random.Next(10, 1000));
                Chart1.Series["Series3"].Points.AddXY(i, random.Next(10, 1000));
            }
            SetAttributes();
            string cbReference = ClientScript.GetCallbackEventReference(this, String.Empty, "document.getElementById('btn1').click()", String.Empty);
            string cbScript = "function UseCallback()" + "{" + cbReference + ";" + "}";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "UseCallback", cbScript, true);
        }
    }

    void SetAttributes()
    {
        foreach (Series series in Chart1.Series)
        {
            String sHandler = String.Format("GetSeriesValue('#SERIESNAME', #VAL, '{0}'); ", series.Color.Name);
            series.MapAreaAttributes = "onclick= \"" + sHandler + "\"";
        }
    }

    protected void btn1_Click(object sender, EventArgs e)
    {
        Chart2.Series[txt1.Text].Points.AddXY(0, txt2.Text);
        Chart2.Series[txt1.Text].Color = Color.FromName(txt3.Text);
    }

    public void RaiseCallbackEvent(string eventArg)
    {
        //can do your other  logics
    }

    public string GetCallbackResult() { return ""; }
}