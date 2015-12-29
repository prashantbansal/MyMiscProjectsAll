<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PrashantWebApp._Default" %>
<%@ Register Src="UI.ascx" TagName="UIAscx" TagPrefix="UIAscx" %>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:UpdatePanel ID="upContent" runat="server">
        <ContentTemplate>
           <UIAscx:UIAscx Id="UI1" runat="server"/>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
