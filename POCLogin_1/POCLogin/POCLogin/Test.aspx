<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="POCLogin.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox runat="server" ID="TextBox2" ClientIDMode="Static"></asp:TextBox>
            <asp:Button runat="server" Text="Click Me!" OnClientClick="Child();"/>
        </div>
    </form>
    <script type="text/javascript">
        function Child()
        {
            if (window.opener != null && !window.opener.closed) {
                var txtName = window.opener.document.getElementById("TextBox1");
                txtName.value = document.getElementById("TextBox2").value;
            }
            window.close();
        }

    </script>
</body>
</html>
