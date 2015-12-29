<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pmbr.aspx.cs" Inherits="POCLogin.pmbr" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="formLogin" runat="server">
    <div>Code: <asp:TextBox runat="server" style="width:400px" MaxLength="80" ID="txtCode"></asp:TextBox></div>
        <div>
            Token Type: <asp:Label runat="server" ID="txtTokenType"></asp:Label>
        </div>
        <div>
            Expires In: <asp:Label runat="server" ID="txtExpiresIn"></asp:Label>
        </div>
         <div>
            Access Token: <asp:Label runat="server" ID="txtAccessToken"></asp:Label>
        </div>
        <div>
            <asp:Button runat="server" ID="btnLogin" Text="Login" OnClick="btnLogin_Click"/>
        </div>
    </form>
</body>
</html>
