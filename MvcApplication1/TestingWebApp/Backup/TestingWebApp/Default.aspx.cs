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
using System.Reflection;
using System.Xml.Serialization;
using System.Xml;
using System.Text;
using WordReader;
using Word = Microsoft.Office.Interop.Word;
using System.IO;

namespace TestingWebApp
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddDays(-10));
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            //WordClass wordClass = new WordClass();
            //wordClass.GetDocument();
            if (IsPostBack)
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.Now.AddDays(-10));
            }
        }
        public static void WriteXmlToDisk(object obj, object obj23, string filePath)
        {
            //if (obj != null)
            //{
            //    //UMHelper.ConsoleLine = "filePath:" + filePath;

            //    XmlSerializer s = new XmlSerializer(typeof(obj23));
            //    XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
            //    ns.Add(string.Empty, string.Empty);

            //    XmlTextWriter xmlwriter = new XmlTextWriter(filePath, Encoding.UTF8);
            //    s.Serialize(xmlwriter, obj);
            //    xmlwriter.Close();
            //    //UMHelper.ConsoleLine = "Analysis xml generated successfully...";
            //}
            //else
            //{
            //    throw new Exception("searchQueryAnlysis Collection object is null");
            //}
        }

        protected void submit_Click(object sender, EventArgs e)
        {
            
            //TestWordDoc testwordDoc = new TestWordDoc();
            //testwordDoc.ChangeDocument1();
            //DownloadDocument();
            this.submit.Enabled = false;

            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetExpires(DateTime.Now.AddDays(-10));
        }

        //private void DownloadDocument()
        //{
        //    string filename = @"D:\Onvia.Documents\Service Agreement\SA_BillingFees_Test.docx";

        //    if (filename != "")
        //    {

        //        string path = filename;

        //        System.IO.FileInfo file = new System.IO.FileInfo(path);

        //        if (file.Exists)
        //        {

        //            Response.Clear();

        //            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

        //            Response.AddHeader("Content-Length", file.Length.ToString());

        //            Response.ContentType = "application/octet-stream";

        //            Response.WriteFile(file.FullName);

        //            Response.End();

        //        }

        //        else
        //        {

        //            Response.Write("This file does not exist.");

        //        }

        //    }

        //}

        private void DownloadDocument()
        {
            try
            {
                //create missing object
                object missing = Missing.Value;

                //  create Word application object
                Word.Application wordApp = new Microsoft.Office.Interop.Word.ApplicationClass();
                //  create Word document object
                Word.Document aDoc = null;
                //  create & define filename object with temp.doc

                object filename = @"D:\SA_WO_Surcharge.docx";

                //  if temp.doc available
                if (File.Exists((string)filename))
                {
                    object readOnly = false;
                    object isVisible = false;
                    //  make visible Word application
                    
                    //  open Word document named temp.doc
                    aDoc = wordApp.Documents.Open(ref filename, ref missing, ref readOnly,
                        ref missing, ref missing, ref missing, ref missing, ref missing,
                        ref missing, ref missing, ref missing, ref isVisible, ref missing,
                        ref missing, ref missing, ref missing);
                    wordApp.Visible = true;
                    //aDoc.Activate();
                    object password = "Aditi01*";
                    object noReset = true;
                    object useIRM = false;
                    object enforceStyleLock = false;
                    aDoc.Unprotect(ref password);

                    FindAndReplace(wordApp, "<contactName>", "micheal smith");

                    aDoc.Protect(Microsoft.Office.Interop.Word.WdProtectionType.wdAllowOnlyFormFields, ref noReset, ref password, ref useIRM, ref enforceStyleLock);

                    Word.Dialog dialog = wordApp.Dialogs[Word.WdWordDialog.wdDialogFileSaveAs];
                    object oDlg = (object)dialog;
                    object[] oArgs = new object[1];
                    oArgs[0] = (object)string.Format(@"D:\Document_{0}.docx", "Aditi");
                    oDlg.GetType().InvokeMember("Name", BindingFlags.SetProperty, null, oDlg, oArgs);
                    dialog.Show(ref missing);

                    aDoc.Close(ref missing, ref missing, ref missing);

                    wordApp.Quit(ref missing, ref missing, ref missing);

                }
                else
                {
                    throw new Exception("file not found");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// method to replace tag with value in word document
        /// </summary>
        /// <param name="wordApp"></param>
        /// <param name="findText"></param>
        /// <param name="replaceText"></param>
        private void FindAndReplace(Word.Application wordApp, object findText, object replaceText)
        {
            object matchCase = true;
            object matchWholeWord = true;
            object matchWildCards = false;
            object matchSoundsLike = false;
            object matchAllWordForms = false;
            object forward = true;
            object format = false;
            object matchKashida = false;
            object matchDiacritics = false;
            object matchAlefHamza = false;
            object matchControl = false;
            object read_only = false;
            object visible = true;
            object replace = 2;
            object wrap = 1;
            wordApp.Selection.Find.Execute(ref findText, ref matchCase, ref matchWholeWord,
                ref matchWildCards, ref matchSoundsLike, ref matchAllWordForms, ref forward,
                ref wrap, ref format, ref replaceText, ref replace, ref matchKashida,
                ref matchDiacritics, ref matchAlefHamza, ref matchControl);
        }


        
    }

    public class Employee
    {
        public string firstName;
        public string lastname;
        public string empNumber;
    }
}
