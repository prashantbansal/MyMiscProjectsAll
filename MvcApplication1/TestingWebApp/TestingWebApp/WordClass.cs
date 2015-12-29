using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Word = Microsoft.Office.Interop.Word;
using System.Reflection;


namespace WordReader
{
    public class TestWordDoc
    {
        
        //private void DownloadDocument()
        //{
        //    try
        //    {
        //        string filename = "test1.docx";
        //        if (filename != "")
        //        {
        //            string path = Server.MapPath(filename);
        //            System.IO.FileInfo file = new System.IO.FileInfo(path);

        //            if (file.Exists)
        //            {
        //                Response.Clear();
        //                Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
        //                Response.AddHeader("Content-Length", file.Length.ToString());
        //                Response.ContentType = "application/octet-stream";
        //                Response.WriteFile(file.FullName);
        //                Response.Flush();

        //                File.Delete(path);
        //            }
        //            else
        //            {
        //                Response.Write("This file does not exist.");
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        private void ChangeDocument()
        {
            object fileName = @"H:\Projects\WordReader\WordReader\Test.docx";
            object saveAs = @"H:\Projects\WordReader\WordReader\Test1.docx";
            object missing = System.Reflection.Missing.Value;
            Microsoft.Office.Interop.Word.Application wordApp = new Microsoft.Office.Interop.Word.ApplicationClass();
            Microsoft.Office.Interop.Word.Document aDoc = null;

            if (File.Exists((string)fileName))
            {
                object readOnly = false;
                object isVisible = false;
                wordApp.Visible = false;
                aDoc = wordApp.Documents.Open(ref fileName, ref missing, ref readOnly, ref missing,
                    ref missing, ref missing, ref missing, ref missing, ref missing, ref missing,
                    ref missing, ref isVisible, ref missing, ref missing, ref missing, ref missing);
                aDoc.Activate();



                aDoc.SaveAs(ref saveAs, ref missing, ref missing, ref missing,
                    ref missing, ref missing, ref missing, ref missing,
                    ref missing, ref missing, ref missing, ref missing,
                    ref missing, ref missing, ref missing, ref missing);

                object saveChanges = Word.WdSaveOptions.wdPromptToSaveChanges;
                aDoc.Close(ref saveChanges, ref missing, ref missing);



            }
        }

        public void ChangeDocument1()
        {
            object fileName = @"D:\Onvia.Documents\Service Agreement\TestDoc.docx";
            object saveAs = @"D:\Onvia.Documents\Service Agreement\TestDoc1.docx";
            object missing = System.Reflection.Missing.Value;
            Microsoft.Office.Interop.Word.Application wordApp = new Microsoft.Office.Interop.Word.ApplicationClass();
            Microsoft.Office.Interop.Word.Document aDoc = null;

            wordApp.Options.SaveNormalPrompt = true;



            if (File.Exists((string)fileName))
            {
                object readOnly = false;
                object isVisible = false;
                wordApp.Visible = false;
                aDoc = wordApp.Documents.Open(ref fileName, ref missing, ref readOnly, ref missing,
                    ref missing, ref missing, ref missing, ref missing, ref missing, ref missing,
                    ref missing, ref isVisible, ref missing, ref missing, ref missing, ref missing);
                aDoc.Activate();

                Word.Dialog dialog = wordApp.Dialogs[Word.WdWordDialog.wdDialogFileSaveAs];
                object oDlg = (object)dialog;
                object[] oArgs = new object[1];
                oArgs[0] = (object)@"K:\Testing.docx";
                oDlg.GetType().InvokeMember("Name", BindingFlags.SetProperty, null, oDlg, oArgs);
                //dlg.Show(ref missing);

                dialog.Show(ref missing);

                ////aDoc.SaveAs(ref saveAs, ref missing, ref missing, ref missing,
                ////    ref missing, ref missing, ref missing, ref missing,
                ////    ref missing, ref missing, ref missing, ref missing,
                ////    ref missing, ref missing, ref missing, ref missing);

                ////object saveChanges = Word.WdSaveOptions.wdPromptToSaveChanges;
                aDoc.Close(ref missing, ref missing, ref missing);




                wordApp.Quit(ref missing, ref missing, ref missing);

            }
        }
    }
}
