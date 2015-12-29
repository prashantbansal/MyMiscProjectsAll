<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TestingMSCharts._Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Chart ID="uxTopCategories" runat="server" Height="300px" Width="380px" EnableTheming="true" ImageType="Jpeg" IsSoftShadows="true">
         <Series>
             <asp:Series Name="TopCategoriesSeries" Color="#FF6921" BorderWidth="1" BorderColor="Black" Font="Verdana"
             IsValueShownAsLabel="true" ChartType="Bar">
             </asp:Series>
         </Series>
         <ChartAreas>
             <asp:ChartArea Name="TopCategoriesChartArea" BorderDashStyle="Solid" BorderColor="Silver">
             <AxisX IsMarginVisible="true" LineColor="Silver" Interval="1.0" IsMarksNextToAxis="true" 
                    LabelAutoFitMaxFontSize="10" LabelAutoFitMinFontSize="9">
                <LabelStyle ForeColor="#2560DC" IsEndLabelVisible="true" Font="3pt"/>
                <MajorGrid  LineColor="Silver" IntervalOffset="1.5" />
                <MajorTickMark  Enabled="false"/>
             </AxisX>
             <AxisY LineColor="Silver">
             <LabelStyle Font="Verdana" Enabled="false" IsEndLabelVisible="false"  />
                <MajorGrid LineColor="Silver" IntervalOffset="3.0" />
             </AxisY>
             </asp:ChartArea>
         </ChartAreas>
        </asp:Chart>
    </div>
    </form>
</body>
</html>
