using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using Word = Microsoft.Office.Interop.Word;
using System.IO;
using System.Data.Linq.SqlClient;

namespace TestWordDoc
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                DateTime StartDate = Convert.ToDateTime("1 Jan 2011");
                DateTime endDate = Convert.ToDateTime("27 Mar 2011");
                
                int totalMonths=-1;
                while (StartDate < endDate)
                {
                    totalMonths= totalMonths + 1;
                    StartDate = StartDate.AddMonths(1);
                }

                TimeSpan ts = endDate.Subtract(StartDate.AddMonths(-1));

                int days = ts.Days;

                if (days > 14)
                    totalMonths = totalMonths + 1;

                if (totalMonths > 4)
                { 

                }


                ////create missing object
                //object missing = Missing.Value;

                //Console.WriteLine("creating object of word app");
                ////  create Word application object
                //Word.Application wordApp = new Microsoft.Office.Interop.Word.ApplicationClass();
                ////  create Word document object
                //Word.Document aDoc = null;
                ////  create & define filename object with temp.doc

                
                //Console.WriteLine("Provide path of file");
                //object filepath = Console.ReadLine();
                //Console.WriteLine("reading file from" + filepath.ToString());

                ////  if temp.doc available
                //if (File.Exists((string)filepath))
                //{
                //    Console.WriteLine("file exists at given path");
                //    object readOnly = false;
                //    object isVisible = false;
                //    //  make visible Word application
                //    wordApp.Visible = false;
                //    Console.WriteLine("opening word doc");
                //    //  open Word document named temp.doc
                //    aDoc = wordApp.Documents.Open(ref filepath, ref missing, ref readOnly,
                //        ref missing, ref missing, ref missing, ref missing, ref missing,
                //        ref missing, ref missing, ref missing, ref isVisible, ref missing,
                //        ref missing, ref missing, ref missing);
                //    Console.WriteLine("opened");
                //    aDoc.Activate();
                //    object password = "finance2007";
                //    object noReset = true;
                //    object useIRM = false;
                //    object enforceStyleLock = false;
                //    aDoc.Unprotect(ref password);

                //    FindAndReplace(wordApp, "<contactName>", "dfsfd");

                //    aDoc.Protect(Microsoft.Office.Interop.Word.WdProtectionType.wdAllowOnlyFormFields, ref noReset, ref password, ref useIRM, ref enforceStyleLock);

                //    Word.Dialog dialog = wordApp.Dialogs[Word.WdWordDialog.wdDialogFileSaveAs];
                //    object oDlg = (object)dialog;
                //    object[] oArgs = new object[1];
                //    oArgs[0] = (object)string.Format(@"D:\ServiceAgreement_{0}.docx", "111");
                //    oDlg.GetType().InvokeMember("Name", BindingFlags.SetProperty, null, oDlg, oArgs);
                //    dialog.Show(ref missing);

                //    aDoc.Close(ref missing, ref missing, ref missing);

                //    wordApp.Quit(ref missing, ref missing, ref missing);

                //}
                //else
                //{
                //    Console.WriteLine("file not found");
                //}
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }

        /// <summary>
        /// method to replace tag with value in word document
        /// </summary>
        /// <param name="wordApp"></param>
        /// <param name="findText"></param>
        /// <param name="replaceText"></param>
        private static void FindAndReplace(Word.Application wordApp, object findText, object replaceText)
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
}
