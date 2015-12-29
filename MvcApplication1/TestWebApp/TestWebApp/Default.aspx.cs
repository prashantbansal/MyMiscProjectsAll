using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using DocumentFormat.OpenXml.Packaging;
using System.Text.RegularExpressions;

namespace TestWebApp
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                hdnCheck1.Value = "1";
            }
            DateTime startDate = Convert.ToDateTime("12-Dec-2010");
            DateTime endDate = startDate.AddDays(2);

            //List<Employee> EmpCollection =
            //    new List<Employee>()
            //    {
            //        new Employee(){FirstName="Prashant1",LastName="Bansal1", Title="Mr11111111111"},
            //        new Employee(){FirstName="Prashant2",LastName="Bansal2", Title="Mr11111111112"},
            //        new Employee(){FirstName="Prashant3",LastName="Bansal3", Title="  > Mr1111111113"},
            //        new Employee(){FirstName="Prashant1",LastName="Bansal1", Title="Mr111111111111"},
            //        new Employee(){FirstName="Prashant2",LastName="Bansal2", Title="Mr111111111111112"}
            //    };


            //dlEmpData.DataSource = EmpCollection;
            //dlEmpData.DataBind();

            //EmpCollection empcollection = new EmployeeCollection();

        }

        protected void dlEmpData_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {

            LinkButton lnkButton = (e.Item as RepeaterItem).Controls[1].FindControl("uxLinkButton") as LinkButton;
            if (e.Item.ItemIndex > 9)
            { 

            }
            string clientId = e.Item.ClientID;
            clientId = clientId.Substring(0, clientId.Length - e.Item.ItemIndex.ToString().Length);
            lnkButton.OnClientClick = string.Format(CultureInfo.InvariantCulture, "{0}{1}{2}{3}{4}", "javascript:return ToggleRows('", e.Item.ClientID.ToString(), "',", e.Item.ItemIndex, ")");

            if (((TestWebApp.Employee)(((RepeaterItemEventArgs)(e)).Item.DataItem)).FirstName.Equals("Prashant1"))
            {
                HtmlGenericControl tr = ((System.Web.UI.WebControls.RepeaterItemEventArgs)(e)).Item.FindControl("rowShow") as HtmlGenericControl;
                //tr.Attributes.Add("style", "display:none");
                tr.Style.Add(HtmlTextWriterStyle.Display, "none");
            }
            
            //if (((TestWebApp.Employee)(((DataListItemEventArgs)(e)).Item.DataItem)).FirstName.Equals("Prashant1"))
            //{
            //    //((WebControl)(((DataListItemEventArgs)(e)).Item)).CssClass = "HideRow";
            //   // ((System.Web.UI.WebControls.WebControl)(((System.Web.UI.WebControls.DataListItemEventArgs)(e)).Item)).ControlStyle.CssClass = "HideRow";

            //    //((System.Web.UI.WebControls.WebControl)(((System.Web.UI.WebControls.DataListItemEventArgs)(e)).Item)).
            //    //    Attributes.CssStyle.Add(HtmlTextWriterStyle.FontSize,"12px");

            //    //((System.Web.UI.WebControls.WebControl)(((System.Web.UI.WebControls.DataListItemEventArgs)(e)).Item)).
            //    //    Style.Add(HtmlTextWriterStyle.FontWeight, "display:bold;");

            //    //((System.Web.UI.WebControls.WebControl)(((System.Web.UI.WebControls.DataListItemEventArgs)(e)).Item)).Attributes.Add("style", "display:none;");

            //    HtmlTableRow tr = ((System.Web.UI.WebControls.DataListItemEventArgs)(e)).Item.FindControl("rowShow") as HtmlTableRow;
            //    //tr.Attributes.Add("style", "display:none;");
            //    tr.Style.Add(HtmlTextWriterStyle.Display, "none");

            //}
            //}
        }

        protected void btn1_Click(object sender, EventArgs e)
        {
            try
            {
                string CopyFilePath = @"D:\Test1.docx";
                string toBeReplaced="test & A";
                toBeReplaced=toBeReplaced.Replace("&","&amp;");

                if (File.Exists(CopyFilePath))
                {
                    using (WordprocessingDocument wordDoc = WordprocessingDocument.Open(CopyFilePath, true))
                    {
                        string docText = null;
                        using (StreamReader sr = new StreamReader(wordDoc.MainDocumentPart.GetStream()))
                        {
                            docText = sr.ReadToEnd();
                        }

                        docText = this.ReplaceValue(docText, "contactName", toBeReplaced);

                        using (StreamWriter sw = new StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create)))
                        {
                            sw.Write(docText);
                        }
                    }
                }
                else
                {
                    throw new Exception("Copied file is not found");
                }
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
            
        }
        /// <summary>
        /// Method to replace value using regex
        /// </summary>
        /// <param name="docText">doc text</param>
        /// <param name="regexValue">key</param>
        /// <param name="valueToBeReplaced">value</param>
        /// <returns></returns>
        private string ReplaceValue(string docText, string regexValue, string valueToBeReplaced)
        {
            Regex regexText = new Regex(regexValue);
            docText = regexText.Replace(docText, valueToBeReplaced);

            return docText;

        }
    }
}
