<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pmbr.aspx.cs" Inherits="POCLogin.pmbr" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="formLogin" runat="server">
        <div>
            Code:
            <asp:TextBox runat="server" Style="width: 400px" MaxLength="80" ID="txtCode"></asp:TextBox>
        </div>
        <div>
            Token Type:
            <asp:Label runat="server" ID="txtTokenType"></asp:Label>
        </div>
        <div>
            Expires In:
            <asp:Label runat="server" ID="txtExpiresIn"></asp:Label>
        </div>
        <div>
            Access Token:
            <asp:Label runat="server" ID="txtAccessToken"></asp:Label>
        </div>
        <div>
            Refresh Token:
            <asp:Label runat="server" ID="txtRefreshToken"></asp:Label>
        </div>
        <div>
            <asp:Button runat="server" ID="btnCode" Text="Get Code" OnClientClick="Login();return false;" />
            <asp:Button runat="server" ID="btnLogin" Text="Login" OnClick="btnLogin_Click" />
            <asp:Button runat="server" ID="btnGetProfile" Text="Get Profile" OnClick="btnProfile_Click"></asp:Button>
                        <asp:TextBox runat="server" Style="width: 400px" MaxLength="80" ID="TextBox1" ClientIDMode="Static"></asp:TextBox>

        </div>
        <asp:Label runat="server" ID="txtProfile" Text=""></asp:Label>
    </form>
</body>
</html>

<script type="text/javascript">
    var popup;
    function Login() {
        //var url = "https://testsso.kaplan.edu/as/authorization.oauth2?client_id=pmbr&response_type=code&scope=profile&pfidpadapterid=KaptestMobileSTGInstance&state=<optional>";
        var url = "test.aspx";
        popup = window.open(url, 'mywin', 'width=500,height=500');
        popup.focus();
        console.log(popup.location.href);
    }

    function Parent(arg)
    {
        alert(arg);
    }
</script>
