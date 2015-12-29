<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TestingCharts1._Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="Button1" name="sadd" runat="server"/>
    <div>
        <asp:Chart ID="Chart1" runat="server">
            <Series>
                <asp:Series Name="Series1" ChartType="Bar" IsValueShownAsLabel="true" Font="Verdana">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                <AxisX></AxisX>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
    </div>
    <div>
    <img src=CategoriesInPng.png id="categoriesImg" runat="server" alt="Click to copy"/>
    </div>
    <asp:Label ID="imagePath" runat="server"><%= imageLocation %>;</asp:Label>
    <asp:Button id="downloadImage" runat="server" Text="DownloadImage" 
        onclick="downloadImage_Click"/>
    <input id="Button2" type="button" value="Click here" onclick="javascript:SaveFile()"  runat="server"/>
    </form>
    
</body>
</html>
<script language="javascript" type="text/javascript">
    function DownloadImage()
    {
        debugger;
        var id = document.getElementById('Chart1');
        id.onmouseup = Check;
        alert('hello');
    }
    function Check()
    {
        alert('check');
    }
    function SaveFile()
    {
        debugger;
        var id = document.getElementById('categoriesImg');
        if (typeof id == 'object')
           var imgOrURL = id.src;
        window.win = open(imgOrURL);
        setTimeout('win.document.execCommand("SaveAs")', 500);

    }

    var clickmessage = "Right click disabled on images!"
</script>


