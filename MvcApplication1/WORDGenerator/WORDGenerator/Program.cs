using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Office.Interop.Word;
using System.Data;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;
using System.IO;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml;

namespace WORDGenerator
{
    class Program
    {
        const string stylesXmlFile = @"~/resources/styles.xml";
        const string wordNamespace = "http://schemas.openxmlformats.org/wordprocessingml/2006/main";
        const string wordPrefix = "w";

        private string _documentName;
        private string _salesPersonID;
        private static string _imagePartRID;

        static void Main(string[] args)
        {
            try
            {
                CreateNewWordDocument("Doc1.docx");
            }
            catch (Exception ex)
            {
                
                throw ex;
            }
            
            
        }


        // Create a package as a Word document.
        public static void CreateNewWordDocument(string document)
        {
            using (WordprocessingDocument wordDoc = WordprocessingDocument.Create(document, WordprocessingDocumentType.Document))
            {
                // Set the content of the document so that Word can open it.
                MainDocumentPart mainPart = wordDoc.AddMainDocumentPart();

                // Create a style part and add it to the document
                XmlDocument stylesXml = new XmlDocument();
                stylesXml.Load("styles.xml");

                StyleDefinitionsPart stylePart = mainPart.AddNewPart<StyleDefinitionsPart>();
                //  Copy the style.xml content into the new part...
                using (Stream outputStream = stylePart.GetStream())
                {
                    using (StreamWriter ts = new StreamWriter(outputStream))
                    {
                        ts.Write(stylesXml.InnerXml);
                    }
                }

                // Create an image part and add it to the document
                ImagePart imagePart = mainPart.AddImagePart(ImagePartType.Jpeg);
                string imageFileName = "headerImage.jpeg";
                using (FileStream stream = new FileStream(imageFileName, FileMode.Open))
                {
                    imagePart.FeedData(stream);
                }

                // Get the reference id for the image added to the package
                // You will use the image part reference id to insert the
                // image to the document.xml file
                _imagePartRID = mainPart.GetIdOfPart(imagePart);

                SetMainDocumentContent1(mainPart);
            }
        }

        // Set content of MainDocumentPart.
        public static void SetMainDocumentContent1(MainDocumentPart part)
        {
//            string xmlText = @"<?xml version=""1.0"" encoding=""UTF-8"" standalone=""yes""?> 
//<w:document xmlns:w=""http://schemas.openxmlformats.org/wordprocessingml/2006/main"">
//    <w:body><w:p><w:r><w:t>I love coffee</w:t></w:r></w:p></w:body>
//</w:document>";
            //string xmlText = File.ReadAllText(@"document.xml");
            

            //using (Stream stream = part.GetStream())
            //{
            //    byte[] buf = (new UTF8Encoding()).GetBytes(xmlText);
            //    stream.Write(buf, 0, buf.Length);
            //}

            try
            {
                using (Stream stream = part.GetStream())
                {
                    // Create an XmlWriter using UTF8 encoding
                    XmlWriterSettings settings = new XmlWriterSettings();
                    settings.Encoding = Encoding.UTF8;
                    settings.Indent = true;

                    // This file represents the WordProcessingML of the Sales Report
                    XmlWriter writer = XmlWriter.Create(stream, settings);
                    try
                    {
                        writer.WriteStartDocument(true);
                        //writer.WriteComment("This file represents the WordProcessingML of our Sales Report");
                        //writer.WriteStartElement(wordPrefix, "document", wordNamespace);
                        //writer.WriteStartElement(wordPrefix, "body", wordNamespace);

                        WriteHeaderImage(writer);
                        //writer.WriteEndElement(); //body
                        //writer.WriteEndElement(); //document
                    }
                    catch (Exception e)
                    {
                        throw;
                    }
                    finally
                    {
                        //Write the XML to file and close the writer
                        writer.Flush();
                        writer.Close();
                    }
                }
            }

            catch (Exception e)
            {
                throw;
            }
            return;
        }

        private static void WriteHeaderImage(XmlWriter writer)
        {
            // load the drawing templage into a XML Document
            XmlDocument drawingXml = new XmlDocument();
            string drawingXmlFile = "wordTemplate.xml";
            drawingXml.Load(drawingXmlFile);

            // load the drawing template into a XML Document and pass the reference id parameter
            drawingXml.LoadXml(string.Format(drawingXml.InnerXml, _imagePartRID));

            // write the wrapping paragraph and the drawing fragment
            //writer.WriteStartElement(wordPrefix, "p", wordNamespace);
            //writer.WriteStartElement(wordPrefix, "r", wordNamespace);
            drawingXml.DocumentElement.WriteContentTo(writer);
            //writer.WriteEndElement();
            //writer.WriteEndElement();
        }
    }

    public class WORDGeneration
    {
        public void GenerateDocument2()
        {
            WORDGeneration wg = new WORDGeneration();
            wg.GenerateDocument();

            object missing = System.Reflection.Missing.Value;

            object Visible = true;

            object start1 = 0;

            object end1 = 0;



            ApplicationClass WordApp = new ApplicationClass();

            Document adoc = WordApp.Documents.Add(ref missing, ref missing, ref missing, ref missing);

            Range rng = adoc.Range(ref start1, ref missing);



            try
            {

                rng.Font.Name = "Georgia";

                rng.InsertAfter("Hello World!");

                object filename = @"D:\MyWord.doc";

                // Clear out any existing information.
                start1 = Type.Missing;
                end1 = Type.Missing;
                adoc.Range(ref start1, ref end1).Delete(ref missing, ref missing);

                // Set up the header information.
                start1 = 0;
                end1 = 0;
                Microsoft.Office.Interop.Word.Range rng1 = adoc.Range(ref start1, ref end1);
                rng1.InsertBefore("Directory Information from C:\\");
                rng1.Font.Name = "Verdana";
                rng1.Font.Size = 16;
                rng1.InsertParagraphAfter();
                rng1.InsertParagraphAfter();

                Object defaultTableBehavior = Type.Missing;
                Object autoFitBehavior = Type.Missing;
                adoc.Tables.Add(rng1, 1, 2, ref defaultTableBehavior, ref autoFitBehavior);
                Object beforeRow = Type.Missing;

                Microsoft.Office.Interop.Word.Table tbl = adoc.Tables[1];
                tbl.Range.Font.Size = 8;
                tbl.Range.Font.Name = "Verdana";

                //Object style = "Table Grid 8";
                //tbl.set_Style(ref style);
                tbl.ApplyStyleFirstColumn = false;
                tbl.ApplyStyleLastColumn = false;
                tbl.ApplyStyleLastRow = false;

                Microsoft.Office.Interop.Word.Range rngCell;
                // Insert header text and format the columns.
                rngCell = tbl.Cell(1, 1).Range;
                rngCell.Font.Name = "Arial";
                rngCell.Font.Size = 12;

                rngCell.Text = "Service Level Agreement";
                rngCell.ParagraphFormat.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;
                //tbl.Rows[0].Cells.Merge();// Cell(1, 1).Range.Cells.Merge();

                rngCell = tbl.Cell(1, 2).Range;
                rngCell.Text = "";
                rngCell.ParagraphFormat.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphCenter;
                tbl.Rows.Add(ref beforeRow);
                tbl.Rows[1].Cells.Merge();

                rngCell = tbl.Cell(2, 1).Range;
                rngCell.Text = "Contact Info";
                rngCell.ParagraphFormat.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphRight;

                rngCell = tbl.Cell(2, 2).Range;
                rngCell.Text = "Modified 1";
                rngCell.ParagraphFormat.Alignment = Microsoft.Office.Interop.Word.WdParagraphAlignment.wdAlignParagraphRight;

                Microsoft.Office.Interop.Word.Paragraph oPara1;
                oPara1 = adoc.Paragraphs.Add(ref missing);
                object styleHeading1 = "Heading 1";
                oPara1.Range.set_Style(ref styleHeading1);
                oPara1.Range.Text = "Create a New Report";
                oPara1.Range.InsertParagraphAfter();

                Microsoft.Office.Interop.Word.Paragraph oPara2;
                oPara2 = adoc.Paragraphs.Add(ref missing);
                oPara2.Range.Text = "This is my first paragraph.";
                oPara2.Range.InsertParagraphAfter();
                Microsoft.Office.Interop.Word.Paragraph oPara3;
                oPara3 = adoc.Paragraphs.Add(ref missing);
                oPara3.Range.Text = "This is my second paragraph.";
                oPara2.Range.InsertParagraphAfter();

                adoc.SaveAs(ref filename, ref missing, ref missing, ref missing, ref missing, ref missing,

                ref missing, ref missing, ref missing, ref missing, ref missing, ref missing, ref missing, ref missing, ref missing, ref missing);

                WordApp.Visible = true;

            }

            catch (Exception ex)
            {

                throw ex;

            }
        }

        public void GenerateDocument()
        {
            DataSet ds;

            XmlDataDocument xmlDoc;

            XslCompiledTransform xslTran;

            XmlElement root;

            XPathNavigator nav;

            XmlTextWriter writer;

            try
            {

                //Create the DataSet from the XML file

                ds = new DataSet();

                ds.ReadXml("Employee.xml");

                //Create the XML from the DataSet

                xmlDoc = new XmlDataDocument(ds);

                //Load the XSLT for Transformation

                xslTran = new XslCompiledTransform();

                xslTran.Load("Employee.xslt");

                //Determine the Root object in the XML

                root = xmlDoc.DocumentElement;

                //Create the XPath Navigator to navigate throuth the XML

                nav = root.CreateNavigator();

                //First delete the RTF, if already exist

                if (File.Exists("Employee.rtf"))
                {

                    File.Delete("Employee.rtf");

                }

                //Create the RTF by Transforming the XML and XSLT

                writer = new XmlTextWriter("Employee.rtf", System.Text.Encoding.Default);

                xslTran.Transform(nav, writer);

                //Close the Writer after Transformation

                writer.Close();

                //Release all objects

                writer = null;

                nav = null;

                root = null;

                xmlDoc = null;

                ds = null;

            }

            catch (Exception ex)
            {

                writer = null;

                nav = null;

                root = null;

                xmlDoc = null;

                ds = null;

            }

        }
    }
}
