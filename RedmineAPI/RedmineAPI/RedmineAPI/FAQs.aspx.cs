using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Redmine.Net.Api;
using System.Collections.Specialized;
using Redmine.Net.Api.Types;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;
using System.Text;

namespace RedmineAPI
{
    public partial class FAQs : System.Web.UI.Page
    {
        public IList<FAQ> FAQList { get; set; }
        public IList<FAQFieldMapping> FieldMappingList { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.GetFieldMapping();
            this.GetFAQs();
        }

        private void GetFAQs()
        {
            try
            {
                var apiResponse = this.GetAPIResponse();
                this.ProcessResponse(apiResponse);

                JavaScriptSerializer jss = new JavaScriptSerializer();
                hdnData.Value = jss.Serialize(this.FAQList);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void GetFieldMapping()
        {
            string FAQRedmineFieldMapping = "Title:Subject;Question:Question;Response:Description;Keyword:Keyword(s);" +
               "FAQIdentifier:Content#,Page#,QNum,EssayID,BarApp#,Example#,Hypo#,Flex#;" +
               "MaterialCategory:Material Category;" +
               "TopicAssociation:Subject-Topic 1,Subject-Topic 2, Subject-Topic 3;" +
               "LastModifiedOn:UpdatedOn;ZendeskTicketID:Zendesk Ticket Number;RedmineTicketID:Id;" +
               "Status:Status;";

            //fields in format: FAQ Field name: Custom field: field Type;
            //Custom field can have values 1:yes , 0: NO
            //Field type can have values 0:Single, 1:Multiple
            string redmineFieldTypes = "Title:0:0;Question:1:0;Response:0:0;FAQIdentifier:1:1;Keyword:1:0;" +
                "TopicAssociation:1:1;" +
                "LastModifiedOn:0:0;ZendeskTicketID:1:0;RedmineTicketID:0:0;" +
                "Status:0:0;MaterialCategory:1:1;";

            if (FieldMappingList == null || FieldMappingList.Count ==0)
            {
                FieldMappingList = new List<FAQFieldMapping>();
                FAQFieldMapping fieldMapping;
                string[] splitMapping = FAQRedmineFieldMapping.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                
                foreach(string result in splitMapping)
                {
                    fieldMapping = new FAQFieldMapping();
                    string[] subsplit = result.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                    fieldMapping.FAQFieldName = subsplit[0];
                    string[] redmineFields = subsplit[1].Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (string redmineField in redmineFields)
                    {
                        fieldMapping.RedmineFieldNameList.Add(redmineField);
                    }

                    FieldMappingList.Add(fieldMapping);
                }

                string[] redmineFieldTypesArray = redmineFieldTypes.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                foreach(string redmineFieldType in redmineFieldTypesArray)
                {
                    string[] subsplit = redmineFieldType.Split(new char[] { ':' }, StringSplitOptions.RemoveEmptyEntries);
                    fieldMapping = FieldMappingList.FirstOrDefault(x => x.FAQFieldName.Equals(subsplit[0]));
                    if (fieldMapping != null)
                    {
                        fieldMapping.IsCustomField = (subsplit[1] == "0" ? false : true);
                        fieldMapping.HasMultipleSelections = (subsplit[2] == "0" ? false : true);
                    }
                }
            }
        }

        private IList<Issue> GetAPIResponse()
        {
            FAQList = new List<FAQ>();
            string host = "http://redmine.pmbrgia.com";
            string login = "pbansal";
            string password = "kaplan123!";
            //var manager = new RedmineManager(host, login, password);
            var manager = new RedmineManager(host, "df84d989157219d57322eae0aacea99a0ce4c2f8");

            var parameters = new NameValueCollection { { "status_id", "*" }, { "project_id", "4" } };

            var results = manager.GetObjectList<Issue>(parameters);

            return results;
        }

        private void ProcessResponse(IList<Issue> apiResponse)
        {
            if (apiResponse != null && apiResponse.Count() > 0)
            {
                FAQ faqEntity;
                foreach (var row in apiResponse)
                {
                    faqEntity = new FAQ();
                    faqEntity.RedmineTicketID = this.GetFieldValue("RedmineTicketID", row);
                    faqEntity.Title = this.GetFieldValue("Title", row);
                    faqEntity.Question = this.GetFieldValue("Question", row);
                    faqEntity.Response = this.GetFieldValue("Response", row);
                    faqEntity.MaterialCategory = this.GetFieldValue("MaterialCategory", row);
                    faqEntity.FAQIdentifier = this.GetFieldValue("FAQIdentifier", row, true);
                    faqEntity.Keyword = this.GetFieldValue("Keyword", row);
                    faqEntity.TopicAssociation = this.FormatTopicAssociation(this.GetFieldValue("TopicAssociation", row));
                    faqEntity.LastModifiedOn = Convert.ToDateTime(this.GetFieldValue("LastModifiedOn", row));
                    faqEntity.ZendeskTicketID = this.GetFieldValue("ZendeskTicketID", row);
                    faqEntity.Status = this.GetFieldValue("Status", row);
                    FAQList.Add(faqEntity);
                }
            }
        }

        private string GetFieldValue(string faqFieldName, Issue issue, bool includeFieldName = false)
        {
            StringBuilder fieldValue = new StringBuilder();
            FAQFieldMapping fieldMapping = this.FieldMappingList.FirstOrDefault(x => x.FAQFieldName.Equals(faqFieldName));
            if (fieldMapping != null)
            {
                if (!fieldMapping.IsCustomField)
                {
                    if (!string.IsNullOrEmpty(issue.GetType().GetProperties().First(x => x.Name.Equals(fieldMapping.RedmineFieldNameList.First())).GetValue(issue).ToString()))
                    {
                        fieldValue.Append(issue.GetType().GetProperties().First(x => x.Name.Equals(fieldMapping.RedmineFieldNameList.First())).GetValue(issue).ToString());
                    }
                }
                else
                {
                    foreach (var redmineFieldName in fieldMapping.RedmineFieldNameList)
                    {
                        var customFieldRow = issue.CustomFields.FirstOrDefault(x => x.Name.Equals(redmineFieldName));
                        if (customFieldRow != null && customFieldRow.Values.Count > 0)
                        {
                            if (!fieldMapping.HasMultipleSelections)
                            {
                                if (!string.IsNullOrEmpty(customFieldRow.Values.First().ToString()))
                                {
                                    fieldValue.Append(customFieldRow.Values.First().ToString());
                                }
                            }
                            else
                            {
                                foreach (var row in customFieldRow.Values)
                                {
                                    if (!string.IsNullOrEmpty(row.Info.ToString()))
                                    {
                                        if (includeFieldName)
                                        {
                                            fieldValue.AppendFormat("{0}:{1}",
                                                row.Info.ToString().Replace(";", ":" + redmineFieldName + ";").Replace(",", ":" + redmineFieldName + ";"),
                                                redmineFieldName);
                                        }
                                        else
                                        {
                                            fieldValue.AppendFormat("{0}", row.Info.ToString());
                                        }
                                        fieldValue.Append(";");
                                    }
                                }
                            }
                        }
                    }
                }
            }
            return fieldValue.ToString();
        }

        private string GetFieldValue(IList<CustomField> customFieldList, string fieldName, bool getAllValues)
        {
            var response = string.Empty;
            if(customFieldList !=null && customFieldList.Count() > 0)
            {
                var row = customFieldList.FirstOrDefault(x => x.Name.Equals(fieldName));
                if (row != null && row.Values.Count > 0)
                {
                    if (!getAllValues)
                    {
                        response = row.Values.First().Info;
                    }
                    else
                    {
                        foreach (var selection in row.Values)
                        {
                            response = string.Format("{0},{1}", response, selection.Info);
                        }
                    }
                }

            }
            return response;
        }

        private string FormatTopicAssociation(string topicAssociation)
        {
            StringBuilder sb = new StringBuilder();
            if (!string.IsNullOrEmpty(topicAssociation))
            {
                string[] splittedstring = topicAssociation.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

                foreach (string row in splittedstring)
                {
                    string[] topics = row.Split(new char[] { '>' }, StringSplitOptions.RemoveEmptyEntries);
                    for (int i = 0; i < 3; i++)
                    {
                        if (i < topics.Length)
                        {
                            string[] topicDetails = topics[i].Split(new char[] { '#' }, StringSplitOptions.RemoveEmptyEntries);
                            if (topicDetails.Count() == 2)
                            {
                                sb.AppendFormat("{0}:", topicDetails[1].Trim());
                            }
                        }
                        else
                        {
                            sb.AppendFormat("{0}:", "0");
                        }
                    }
                    if (sb.Length > 0)
                    {
                        sb.Remove(sb.Length - 1, 1);
                    }
                    sb.Append(";");
                }
            }
            return sb.ToString();
        }

        //private void GetFAQs()
        //{
        //    try
        //    {
        //        string host = "";
        //        string apiKey = "";

        //        var manager = new RedmineManager(host, apiKey);

        //        var parameters = new NameValueCollection { { "status_id", "*" } };
        //        foreach (var issue in manager.GetObjectList<Issue>(parameters))
        //        {
        //            Console.WriteLine("#{0}: {1}", issue.Id, issue.Subject);
        //        }

        //        //Create a issue.
        //        var newIssue = new Issue { Subject = "test", Project = new IdentifiableName { Id = 1 } };
        //        manager.CreateObject(newIssue);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
    }
}