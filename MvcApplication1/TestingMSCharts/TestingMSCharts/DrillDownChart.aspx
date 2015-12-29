<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DrillDownChart.aspx.cs" Inherits="TestingMSCharts.DrillDownChart" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div style="text-align: center">
                    <asp:Chart ID="Chart1" runat="server" Width="1000px" Height="400px"
                        OnClick="Chart1_Click">
                    </asp:Chart>
                </div>
                <br />
                <div style="text-align: center">
                    <asp:Chart ID="Chart2" runat="server" Width="1000px" Height="400px">
                    </asp:Chart>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="Chart1" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
