<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default"  %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<script language="javascript" type="text/javascript">
    function AlertContent() {
        alert(1);
        return false;
    }
    function test1() {
        alert("asda");
        var el = document.getElementById('foo111');
        el.onclick = showFoo();
    }
    function showFoo() {
        alert('I am foo!');
        return false;
    } 

</script>
    <h2>
        Welcome to ASP.NET!
    </h2>
    <p>
        To learn more about ASP.NET visit <a href="Javascript:test1();" id="foo111" title="ASP.NET Website">www.asp.net</a>.
    </p>
    <p>
        To learn more about ASP.NET visit <input type="button" title="button" name="asdasd" onclick="Javascript:return AlertContent();"/>
    </p>
    <p>
        You can also find <a href="http://go.microsoft.com/fwlink/?LinkID=152368&amp;clcid=0x409"
            title="MSDN ASP.NET Docs">documentation on ASP.NET at MSDN</a>.
    </p>

    <p>
    <asp:TextBox runat="server"></asp:TextBox>
    <asp:Button  id="btnPost" runat="server" Text="post here" onclick="btnPost_Click"/>
    </p>
</asp:Content>

