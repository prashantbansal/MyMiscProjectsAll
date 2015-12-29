using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Word = Microsoft.Office.Interop.Word;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Drawing.Wordprocessing;
using DocumentFormat.OpenXml.Wordprocessing;
using DocumentFormat.OpenXml.Drawing;
using System.Text.RegularExpressions;


namespace WordReader
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                //this.ChangeDocument1();
                //this.DownloadDocument();
                //this.ModifyDocumentUsingOpenXml();
                string fileReadPath = @"H:\Projects\Documents\Template.docx";
                string fileSavePath = @"H:\Projects\Documents\Template1.docx";
                this.CopyFileTo(fileReadPath, fileSavePath);
                this.SearchAndReplace(fileSavePath);
            }
            catch (Exception ex)
            {
                //File.Delete(@"H:\Projects\WordReader\WordReader\Test1.docx");
                throw ex;
            }
        }

        private void DownloadDocument()
        {
            try
            {
                string filename = "test1.docx";
                if (filename != "")
                {
                    string path = Server.MapPath(filename);
                    System.IO.FileInfo file = new System.IO.FileInfo(path);

                    if (file.Exists)
                    {
                        Response.Clear();
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                        Response.AddHeader("Content-Length", file.Length.ToString());
                        Response.ContentType = "application/octet-stream";
                        Response.WriteFile(file.FullName);
                        Response.Flush();

                        File.Delete(path);
                    }
                    else
                    {
                        Response.Write("This file does not exist.");
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

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

        private void ChangeDocument1()
        {
            object fileName = @"H:\Projects\WordReader\WordReader\Test.docx";
            object saveAs = @"H:\Projects\WordReader\WordReader\Test1.docx";
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

        private void ModifyDocumentUsingOpenXml()
        {
            try
            {
                string _myFilePath = @"H:\Projects\Documents\Unprotected.docx";
                byte[] docBytes = File.ReadAllBytes(_myFilePath);
                using (MemoryStream ms = new MemoryStream())
                {
                    ms.Write(docBytes, 0, docBytes.Length);
                    using (WordprocessingDocument wpdoc = WordprocessingDocument.Open(ms, true))
                    {
                        MainDocumentPart mainPart = wpdoc.MainDocumentPart;
                        Document doc = mainPart.Document;

                        var textElement = new DocumentFormat.OpenXml.Wordprocessing.Text("aa");
                        var runElement = new DocumentFormat.OpenXml.Wordprocessing.Run(textElement);

                        foreach (var child in doc.Elements())
                        {
                            if (child.InnerText.Equals("<contactName>"))
                            {
                                child.InsertAfterSelf(runElement);
                            }
                        }
                        //string docText = ((DocumentFormat.OpenXml.Wordprocessing.Body)((DocumentFormat.OpenXml.OpenXmlCompositeElement)((((DocumentFormat.OpenXml.Wordprocessing.Document)(doc.MainDocumentPart.RootElement))).Body))).InnerText.Replace("<contactName>", "aaa");

                        //string modifiedOuterxml = Regex.Replace(currentParagraph.OuterXml, currentString, reusableContentString); OpenXmlElement parent = currentParagraph.Parent; Paragraph modifiedParagraph = new Paragraph(modifiedOuterxml); parent.ReplaceChild<Paragraph>(modifiedParagraph, currentParagraph); 

                        doc.MainDocumentPart.RootElement.Save();
                        // now you can use doc.Descendants<T>()     
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void SearchAndReplace(string fileModifyPath)
        {

            using (WordprocessingDocument wordDoc = WordprocessingDocument.Open(fileModifyPath, true))
            {
                string docText = null;
                using (StreamReader sr = new StreamReader(wordDoc.MainDocumentPart.GetStream()))
                {
                    docText = sr.ReadToEnd();
                }

                docText = this.ReplaceValue("contactName", "micheal smith", docText);
                docText = this.ReplaceValue("StartDate", "1 jan 2010", docText);

                using (StreamWriter sw = new StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create)))
                {
                    sw.Write(docText);
                }
            }
        }

        public void CopyFileTo(string fileReadPath, string fileSavePath)
        {
            byte[] docAsArray = File.ReadAllBytes(fileReadPath);  
            using (MemoryStream stream = new MemoryStream()) 
            {     
                stream.Write(docAsArray, 0, docAsArray.Length);    
                // THIS performs doc copy     
                using (WordprocessingDocument doc = WordprocessingDocument.Open(stream, true))     
                {
                    
                }
                File.WriteAllBytes(fileSavePath, stream.ToArray()); 
            } 
        }

        public string ReplaceValue(string regexValue, string valueToBeReplaced, string docText)
        {
            Regex regexText = new Regex(regexValue);
            docText = regexText.Replace(docText, valueToBeReplaced);

            return docText;

        }

        private void ReadWriteStream(Stream readStream, Stream writeStream)
        {
            int Length = 256;
            Byte[] buffer = new Byte[Length];
            int bytesRead = readStream.Read(buffer, 0, Length);
            // write the required bytes
            while (bytesRead > 0)
            {
                writeStream.Write(buffer, 0, bytesRead);
                bytesRead = readStream.Read(buffer, 0, Length);
            }
            readStream.Close();
            writeStream.Close();
        } 


    }
}