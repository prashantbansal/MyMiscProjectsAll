<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DrillDownChart2.aspx.cs" Inherits="DrillDownChart2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <script language="javascript" type="text/javascript">
        function GetSeriesValue(a, b, c) {
            document.getElementById("txt1").value = a;
            document.getElementById("txt2").value = b;
            document.getElementById("txt3").value = c;
            UseCallback();
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <asp:Chart ID="Chart1" runat="server" EnableViewState="true">
                            <Series>
                                <asp:Series Name="Series1">
                                </asp:Series>
                                <asp:Series Name="Series2">
                                </asp:Series>
                                <asp:Series Name="Series3">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </td>
                    <td>
                        <asp:Chart ID="Chart2" runat="server">
                            <Series>
                                <asp:Series Name="Series1">
                                </asp:Series>
                                <asp:Series Name="Series2">
                                </asp:Series>
                                <asp:Series Name="Series3">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <b>Series Name:</b>&nbsp;<asp:TextBox ID="txt1" runat="server" Style="display: block"></asp:TextBox><br />
                        <b>Series Point:</b>&nbsp;<asp:TextBox ID="txt2" runat="server" Style="display: block"></asp:TextBox><br />
                        <b>Series Color:</b>&nbsp;<asp:TextBox ID="txt3" runat="server" Style="display: block"></asp:TextBox><br />
                    </td>
                </tr>
            </table>
            <asp:Button ID="btn1" runat="server" Style="display: none;" OnClick="btn1_Click" />
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btn1" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    </form>
</body>
</html>
