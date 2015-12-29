<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TestWebApp._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="Style.css" />
    <title>Untitled Page</title>
    <script language="javascript" type="text/javascript">
       function ToggleRows(result, rowNumber)
       {
       debugger
            alert(result);
            var lnkButtonId=result + "_uxLinkButton";
            alert(lnkButtonId);
            if(typeof document.getElementById(lnkButtonId).innerText == 'undefined')
            {
        		alert(document.getElementById(lnkButtonId).textContent);
	        }
	        else
	        {
		        alert(document.getElementById(lnkButtonId).innerText);
	        }
        return false;
       }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Repeater runat="server" ID="dlEmpData" OnItemDataBound="dlEmpData_OnItemDataBound">
            <ItemTemplate>
            <div id="rowShow" runat="server" style="width:180px;">
                <div><asp:Label runat="server" ID="lblTest" AutoEllipsis="true" style="width:5px;" Text='<%# DataBinder.Eval(Container.DataItem,"FirstName") %>'></asp:Label></div>
                <div><%# DataBinder.Eval(Container.DataItem,"LastName") %></div>
                <div style="width:1px;"> 
                    <asp:LinkButton runat="server" ID="uxLinkButton" AutoEllipsis="true" Text='<%# DataBinder.Eval(Container.DataItem,"Title") %>'>
                    </asp:LinkButton>
                </div>
            </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Button id="btn1" runat="server" onclick="btn1_Click"/>
    </div>
    <input type="hidden" id="hdnCheck1" runat="server" value="0" />
    
    </form>
</body>
</html>
