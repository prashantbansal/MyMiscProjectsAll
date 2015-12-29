<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErrorTesting.aspx.cs" Inherits="ElmahImplementation.ErrorTesting" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
 <head>
        <title>ELMAH Demo</title>
        <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
        <meta content="C#" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
        <script runat="server">
        void ErrorButton_Click(object sender, EventArgs e)
        {
            //throw new Exception("An exception has been raised.");
            throw new Exception("This is unhandled error");
        }
        </script>
    </head>
<body>
        <form id="Form1" method="post" runat="server">
            <h1>ELMAH Demo</h1>
            <p>Clicking the button below will raise an exception. Assuming you have not
                changed the path attribute for the <code>&lt;httpHandlers&gt;</code> section, you can also
                visit <a href="elmah/default.aspx/test">elmah/default.aspx/test</a>, which will
                raise a test exception of type <code>TestException</code>. (If you have changed the
                URL
                for displaying the exception log, visit the URL you have changed it to, and
                append the URL with <code>/test</code>). </p>
            <p>
                <asp:button id="Button1" runat="server" text="Raise an Exception" onclick="ErrorButton_Click"></asp:button></p>
            <p>Assuming you have not changed the path attribute for the <code>&lt;httpHandlers&gt;</code>
                section, you can view the exception log at: <a href="elmah/default.aspx">elmah/default.aspx</a>
            </p>
        </form>
    </body>
</html>
