<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FAQs.aspx.cs" Inherits="RedmineAPI.FAQs" %>

<!DOCTYPE html>
<html ng-app>
<head id="Head1" runat="server">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="Scripts/Angular/angular.min.js"></script>
    <script type="text/javascript" src="Scripts/Angular/ui-utils.min.js"></script>
    <script type="text/javascript" src="Scripts/Controller/RedmineAPI.js"></script>
    <title></title>
    <style type="text/css">
        .heading {
            font-weight: bold;
            width: 150px;
            float: left;
        }

        .body {
            width: 800px;
            float: left;
        }

        .row {
            width: 100%;
            float: left;
            padding-bottom: 5px;
        }
    </style>
</head>
<body ng-controller="RedmineAPICtrl">
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="hdnData" runat="server" /> 
            <h2>Zendesk Topics for forum: Knowledge Base</h2>
            <div style="font-family: Verdana; font-size: 12px; width: 1000px;">
                <div ng-repeat="FAQ11 in results">
                    <div class="row">
                        <div class="body">-----------------------------------</div>
                    </div>
                    <div class="row">
                        <div class="heading">Redmine Ticket ID:</div>
                        <div class="body">{{FAQ11.RedmineTicketID}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">Title</div>
                        <div class="body">{{FAQ11.Title}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">Question</div>
                        <div class="body">{{FAQ11.Question}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">Response</div>
                        <div class="body" ng-bind-html-unsafe="FAQ11.Response"></div>
                    </div>
                    <div class="row">
                        <div class="heading">MaterialCategory</div>
                        <div class="body">{{FAQ11.MaterialCategory}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">Keyword</div>
                        <div class="body">{{FAQ11.Keyword}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">FAQIdentifier</div>
                        <div class="body">{{FAQ11.FAQIdentifier}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">TopicAssociation</div>
                        <div class="body">{{FAQ11.TopicAssociation}}</div>
                    </div>
                    <div class="row" style="padding-bottom:30px;">
                        <div class="heading">LastModifiedOn</div>
                        <div class="body">{{FAQ11.LastModifiedOn}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">Zendesk Ticket ID:</div>
                        <div class="body">{{FAQ11.ZendeskTicketID}}</div>
                    </div>
                    <div class="row">
                        <div class="heading">Status:</div>
                        <div class="body" style="font-style:italic">{{FAQ11.Status}}</div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>