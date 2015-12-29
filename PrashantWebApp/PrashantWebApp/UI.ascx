<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UI.ascx.cs" Inherits="PrashantWebApp.UI" %>
<div>
    <asp:LinkButton ID="lnkdownloadFile" runat="server" Text="Download File" OnClientClick="javascript:DownloadDocument()"></asp:LinkButton>
    <input type="button" id="btnDownload" title="Download" name="Download" value="Download" />
    <iframe id="downloadFrame" style="display: none"></iframe>
</div>
<script lang="javascript" type="text/javascript">
    $(document).ready(function () {
        $("#btnDownload").click(function () {
            alert('download');
            
        });
    });
    function DownloadDocument() {
        alert("hello");
        var iframe = document.getElementById("downloadFrame");
        iframe.src = "http://kbr.dev.kaplan.com:100/DownloadManager.aspx?downloadFrom=3&fileName=MP08FEB001_P.pdf";
    }
</script>
