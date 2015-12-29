<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TestingWebApp._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language="javascript" type="text/javascript">
    
    String.prototype.trim = function () 
    {
        return this.replace(/^\s*/, "").replace(/\s*$/, "");
    }

    function TrimValues()
    {
        alert('-selected Geography and license combination is not valid.\n Refer to help icon in subscription services screen on right top corner');
        var ieCompatible=1;
        if (document.all)
        {
            ieCompatible=1;
        }
        else
        {
            var ieCompatible=0;
        }
        
        var a= document.getElementById("txtBox");
        var b=a.value.trim();
    }
    
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input type="text" id="txtBox" runat="server" />
        <input type="button" runat="server" title="click here" name="click here" value="click here"  onclick="TrimValues()" />
        <table>
            <tr>
                <td style="display:inline;">
                    <asp:Label Text="ASD" runat="server"></asp:Label>
                    <a href="" title="saddasdad" visible=true runat="server">asdd</a>
                </td>
            </tr>
            
        </table>
        <asp:Button id="submit" runat=server Text="checkingFunction" 
            onclick="submit_Click"/>
    </div>
    </form>
</body>
</html>
