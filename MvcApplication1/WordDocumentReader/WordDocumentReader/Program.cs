using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Office.Interop.Word;
using System.IO;
using System.Reflection;
using Microsoft.Win32;
using System.Windows.Forms;
using Word=Microsoft.Office.Interop.Word;

namespace WordDocumentReader
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                ReadWordDocument();
                //CreateWordDocument(@"D:\Projects\WordDocumentReader\WordDocumentReader\bin\Debug\WordTemplate11.docx", @"D:\Projects\WordDocumentReader\WordDocumentReader\bin\Debug\WordTemplate1.docx");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        private static void CreateWordDocument(object FileName, object SaveAs)
        {
            //  create offer letter
            try
            {
                //  Just to kill WINWORD.EXE if it is running
                //killprocess("winword");
                //  copy letter format to temp.doc
                //File.Copy(@"D:\Projects\WordDocumentReader\WordDocumentReader\bin\Debug\WordTemplate11.docx", @"D:\Projects\WordDocumentReader\WordDocumentReader\bin\Debug\WordTemplate112.docx", true);
                File.Copy(@"D:\Onvia.Documents\Service Agreement\SA_BillingFees_Test.docx", @"D:\Onvia.Documents\Service Agreement\SA_BillingFees_Test1.docx", true);
                //  create missing object
                object missing = Missing.Value;
                //  create Word application object
                Microsoft.Office.Interop.Word.Application wordApp = new Microsoft.Office.Interop.Word.ApplicationClass();
                //  create Word document object
                Microsoft.Office.Interop.Word.Document aDoc = null;
                //  create & define filename object with temp.doc

                string path = Path.Combine(Environment.CurrentDirectory, @"..\..\SA_BillingFees_Test1.docx");
                object filename = path;
                //  if temp.doc available
                if (File.Exists((string)filename))
                {
                    object readOnly = false;
                    object isVisible = false;
                    //  make visible Word application
                    wordApp.Visible = false;
                    //  open Word document named temp.doc
                    aDoc = wordApp.Documents.Open(ref filename, ref missing,
        ref readOnly, ref missing, ref missing, ref missing,
        ref missing, ref missing, ref missing, ref missing,
        ref missing, ref isVisible, ref missing, ref missing,
        ref missing, ref missing);
                    aDoc.Activate();
                    object password = "2007";
                    object noReset = true;
                    object useIRM = false;
                    object enforceStyleLock = false;
                    aDoc.Unprotect(ref password);
                    FindAndReplace(wordApp, "<contactName>", "john Micheal");
                    FindAndReplace(wordApp, "<targetStartDate>", "12 Jan 2010");
                    FindAndReplace(wordApp, "<companyName>", "Test Company 1234");
                    FindAndReplace(wordApp, "<proposalType>", "new");
                    FindAndReplace(wordApp, "<streetAddress>", "1725 first floor");
                    FindAndReplace(wordApp, "<proposalValidUntil>", "11 Jan 2011");
                    FindAndReplace(wordApp, "<CityStateZip>", "Bangalore, KA 560078");
                    FindAndReplace(wordApp, "<netSuiteId>", "ONV12345");
                    FindAndReplace(wordApp, "<subscriptionType>", "Onvia Online Database");
                    FindAndReplace(wordApp, "<coverage>", "National");
                    FindAndReplace(wordApp, "<noOfDatabaseUsers>", "");
                    FindAndReplace(wordApp, "<noOfAR>", "12");
                    FindAndReplace(wordApp, "<noOfGuideUsers>", "1");
                    FindAndReplace(wordApp, "<additionalProducts>", "news clips, data feeds");
                    FindAndReplace(wordApp, "<subscriptionTerm>", "Annual");
                    FindAndReplace(wordApp, "<subscriptionPeriod>", "1 year");
                    FindAndReplace(wordApp, "<paymentTerms>", "Credit Card");
                    FindAndReplace(wordApp, "<subscriptionPrice>", "$123.34");
                    FindAndReplace(wordApp, "<billingFees>", "$123.00");
                    FindAndReplace(wordApp, "<totalPrice>", "$200.00");
                    aDoc.Protect(Microsoft.Office.Interop.Word.WdProtectionType.wdAllowOnlyFormFields, ref noReset, ref password, ref useIRM, ref enforceStyleLock);
                    //  Call FindAndReplace()function for each change
                    
                    ////  save temp.doc after modified

                    //// Configure save file dialog box
                    //SaveFileDialog dlg = new SaveFileDialog();
                    //dlg.FileName = "template"; // Default file name
                    //dlg.DefaultExt = ".docx"; // Default file extension
                    //dlg.Filter = "Text documents (.txt)|*.txt"; // Filter files by extension

                    //// Show save file dialog box
                    //Nullable<bool> result = true;
                    //dlg.ShowDialog();

                    //// Process save file dialog box results
                    //if (result == true)
                    //{
                    //    // Save document
                    //    //string filename = dlg.FileName;
                    //}


                    aDoc.Save();
                }
                else
                    Console.WriteLine("Error in process.");
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in process.");
            }
        }

        private static void FindAndReplace(Microsoft.Office.Interop.Word.Application wordApp, object findText, object replaceText)
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
            wordApp.Selection.Find.Execute(ref findText, ref matchCase,
                ref matchWholeWord, ref matchWildCards, ref matchSoundsLike,
                ref matchAllWordForms, ref forward, ref wrap, ref format,
                ref replaceText, ref replace, ref matchKashida,
                        ref matchDiacritics,
                ref matchAlefHamza, ref matchControl);
        }

        private static void ReadWordDocument()
        {
             
            string filePath = @"D:\Onvia.Documents\Service Agreement\SA_BillingFees_Test.docx";

            Microsoft.Office.Interop.Word.Application app = new Word.ApplicationClass();
            object nullobj = System.Reflection.Missing.Value;
            object file = filePath;
            Word.Document doc = app.Documents.Open(
            ref file, ref nullobj, ref nullobj,
            ref nullobj, ref nullobj, ref nullobj,
            ref nullobj, ref nullobj, ref nullobj,
            ref nullobj, ref nullobj, ref nullobj,
            ref nullobj, ref nullobj, ref nullobj, ref nullobj);
            doc.ActiveWindow.Selection.WholeStory();
            doc.ActiveWindow.Selection.Copy();
            IDataObject data = Clipboard.GetDataObject();
            string text = data.GetData(DataFormats.Text).ToString();
            Console.WriteLine(text);
            doc.Close(ref nullobj, ref nullobj, ref nullobj);
            app.Quit(ref nullobj, ref nullobj, ref nullobj); 

        }
        private static void DownloadDocument()
        {
            string filename = @"D:\Onvia.Documents\Service Agreement\SA_BillingFees_Test.docx";

            if (filename != "")
            {

                string path = filename;

                System.IO.FileInfo file = new System.IO.FileInfo(path);

                if (file.Exists)
                {

                    Response.Clear();

                    Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

                    Response.AddHeader("Content-Length", file.Length.ToString());

                    Response.ContentType = "application/octet-stream";

                    Response.WriteFile(file.FullName);

                    Response.End();

                }

                else
                {

                    Response.Write("This file does not exist.");

                }

            }

        }
    }
}
