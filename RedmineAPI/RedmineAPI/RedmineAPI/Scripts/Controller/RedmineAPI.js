function RedmineAPICtrl($scope, $http) {
    debugger;
    var data = document.getElementById('hdnData').value;
    var json = JSON.parse(data);
    //var json2 = [
    //       {
    //           "ZendeskTicketID": "400",
    //           "Title": "Michael",
    //           "Question": "Adams",
    //           "Response": "michaeladams@google.com",
    //           "MaterialCategory": "1028025863",
    //           "Keyword": "New York, New York",
    //           "FAQIdentifier": "MCAT",
    //           "TopicAssociation": "MCAT - On Demand",
    //           "LastModifiedOn": "MCAT - On Demand"
    //       },
    //       {
    //           "ZendeskTicketID": "400",
    //           "Title": "Michael",
    //           "Question": "Adams",
    //           "Response": "michaeladams@google.com",
    //           "MaterialCategory": "1028025863",
    //           "Keyword": "New York, New York",
    //           "FAQIdentifier": "MCAT",
    //           "TopicAssociation": "MCAT - On Demand",
    //           "LastModifiedOn": "MCAT - On Demand"
    //       }
    //];
    $scope.results = json;
}

