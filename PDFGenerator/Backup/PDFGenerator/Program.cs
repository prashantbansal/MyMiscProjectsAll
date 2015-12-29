using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

namespace PDFGenerator
{
    public class Program
    {
        public static void Main(string[] args)
        {
            PDFGeneration g = new PDFGeneration();
            g.WritePDF();
            Console.WriteLine("writing pdf");

            //Rectangle pageSize = new Rectangle(144, 720);
            //Document document = new Document(pageSize);
            Document document = new Document();
            Rectangle page = document.PageSize;

            try
            {
                PdfWriter writer = PdfWriter.GetInstance(document, new FileStream("Chap0105.pdf", FileMode.Create));
                //writer.SetEncryption(PdfWriter.STRENGTH128BITS, "", "", 
                //    PdfWriter.AllowCopy | PdfWriter.AllowPrinting | PdfWriter.ALLOW_MODIFY_CONTENTS |
                //    PdfWriter.ALLOW_MODIFY_ANNOTATIONS | PdfWriter.ALLOW_FILL_IN);
                //document.AddTitle("Hello World example");
                //document.AddSubject("This example explains step 6 in Chapter 1");
                //document.AddKeywords("Metadata, iText, step 6, tutorial");
                //document.AddCreator("My program using iText#");
                //document.AddAuthor("Bruno Lowagie");
                //document.AddHeader("Expires", "erwerwrwr");

                //Header h = new Header("asdads", "asdasd");
                //document.Add(h);

                //Watermark watermark = new Watermark(Image.GetInstance("watermark.jpg"), 200, 420);
                //document.Add(watermark);

                //                HeaderFooter header = new HeaderFooter(new Phrase("This is a header"), false); 
                //document.Header = header; 



                document.Open();
                // step 4: we Add content to the document 

                // PAGE 1 


                PdfPTable aTable = new PdfPTable(2);    // 2 rows, 2 columns 
                aTable.TotalWidth = page.Width;
                PdfPCell c = new PdfPCell(new Phrase("asfgfghhfghghgfda", new Font(Font.FontFamily.COURIER, 8)));
                c.HorizontalAlignment = Element.ALIGN_RIGHT;
                c.VerticalAlignment = Element.ALIGN_MIDDLE;
                c.Border = Rectangle.RIGHT_BORDER;
                aTable.AddCell(c);
                //aTable.AddCell("0.1"); 
                //aTable.AddCell("1.0"); 
                //aTable.AddCell("1.1"); 
                //document.Add(aTable);

                aTable.WriteSelectedRows(0, -1, 0, aTable.TotalHeight, writer.DirectContent);

                //// we trigger a page break 
                //document.NewPage();

                //// PAGE 2 

                //// we Add some more content 
                //document.Add(new Paragraph("Hello Earth"));


                //// we trigger a page break 
                //document.NewPage();

                //// PAGE 3 

                //// we Add some more content 
                //document.Add(new Paragraph("Hello Sun"));
                //document.Add(new Paragraph("Remark: the header has vanished!"));

                //// we reset the page numbering 
                //document.ResetPageCount();

                //// we trigger a page break 
                //document.NewPage();

                //// PAGE 4 

                //// we Add some more content 
                //document.Add(new Paragraph("Hello Moon"));
                //document.Add(new Paragraph("Remark: the pagenumber has been reset!"));


                //for (int i = 0; i < 5; i++)
                //{
                //    document.Add(new Paragraph("Hello World"));
                //}

            }
            catch (DocumentException de)
            {
                Console.Error.WriteLine(de.Message);
            }
            catch (IOException ioe)
            {
                Console.Error.WriteLine(ioe.Message);
            }

            document.Close();
        }

        

        
    }

    public class PDFGeneration
    {
        PdfTemplate moTemplate;
        PdfContentByte moCB;
        BaseFont moBF = null;

        public void WritePDF()
        {
            try
            {
                Document document = new Document();
                PdfWriter writer = PdfWriter.GetInstance(document, new FileStream("Chap0107.pdf", FileMode.Create));


                document.Open();

                PdfPTable oTable = new PdfPTable(2);
                PdfPCell oCell;
                Phrase phrase;

                oCell = new PdfPCell();
                oCell.AddElement(new Phrase("Contact Info", FontFactory.GetFont("Arial", 12, iTextSharp.text.Font.BOLD)));
                oCell.AddElement(new Phrase("Prashant Bansal", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Aditi Techologies Ltd", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Bangalore", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("India", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.Border = 2;
                //oCell.Colspan = 2;
                oCell.HorizontalAlignment = Element.ALIGN_CENTER;
                oTable.AddCell(oCell);

                oCell = new PdfPCell();
                oCell.AddElement(new Phrase("Billing Info", FontFactory.GetFont("Arial", 12, iTextSharp.text.Font.BOLD)));
                oCell.AddElement(new Phrase("Prashant Bansal", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Aditi Techologies Ltd", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Bangalore", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("India", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.Border = 2;
                //oCell.Colspan = 2;
                oCell.HorizontalAlignment = Element.ALIGN_CENTER;
                oTable.AddCell(oCell);

                oTable.TotalWidth = document.PageSize.Width - 20;

                document.Add(oTable);

                //Phrase oPhrase = new Phrase("My PDF Text", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL));

                //document.Add(oPhrase);

                moBF = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                moCB = writer.DirectContent;
                moTemplate = moCB.CreateTemplate(50, 50);

                moTemplate.BeginText();
                moTemplate.SetFontAndSize(moBF, 8);
                moTemplate.ShowText((writer.PageNumber - 1).ToString());
                moTemplate.EndText();
                setHeader(writer, document);
                setFooter(writer, document);
                document.Close();
                
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void WriteEditablePDF()
        {
            try
            {
                Document document = new Document();
                PdfWriter writer = PdfWriter.GetInstance(document, new FileStream("Chap0107.pdf", FileMode.Create));


                document.Open();

                PdfPTable oTable = new PdfPTable(2);
                PdfPCell oCell;
                Phrase phrase;

                

                oCell = new PdfPCell();
                oCell.AddElement(new Phrase("Contact Info", FontFactory.GetFont("Arial", 12, iTextSharp.text.Font.BOLD)));
                oCell.AddElement(new Phrase("Prashant Bansal", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Aditi Techologies Ltd", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Bangalore", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("India", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.Border = 2;
                //oCell.Colspan = 2;
                oCell.HorizontalAlignment = Element.ALIGN_CENTER;
                oTable.AddCell(oCell);

                oCell = new PdfPCell();
                oCell.AddElement(new Phrase("Billing Info", FontFactory.GetFont("Arial", 12, iTextSharp.text.Font.BOLD)));
                oCell.AddElement(new Phrase("Prashant Bansal", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Aditi Techologies Ltd", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("Bangalore", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.AddElement(new Phrase("India", FontFactory.GetFont("Arial", 8, iTextSharp.text.Font.NORMAL)));
                oCell.Border = 2;
                //oCell.Colspan = 2;
                oCell.HorizontalAlignment = Element.ALIGN_CENTER;
                oTable.AddCell(oCell);

                oTable.TotalWidth = document.PageSize.Width - 20;

                document.Add(oTable);

                //Phrase oPhrase = new Phrase("My PDF Text", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL));

                //document.Add(oPhrase);

                moBF = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                moCB = writer.DirectContent;
                moTemplate = moCB.CreateTemplate(50, 50);

                moTemplate.BeginText();
                moTemplate.SetFontAndSize(moBF, 8);
                moTemplate.ShowText((writer.PageNumber - 1).ToString());
                moTemplate.EndText();
                setHeader(writer, document);
                setFooter(writer, document);
                document.Close();


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void setHeader(PdfWriter writer, Document document)
        {
            
            PdfPTable oTable = new PdfPTable(1);
            PdfPCell oCell;
            oCell = new PdfPCell(new Phrase("Service Level Agreement", FontFactory.GetFont("Arial", 20, iTextSharp.text.Font.BOLD)));
            oCell.Border = 2;
            oCell.HorizontalAlignment = Element.ALIGN_CENTER;
            oTable.AddCell(oCell);

            oTable.TotalWidth = document.PageSize.Width - 20;
            oTable.WriteSelectedRows(0, -1, 10, document.PageSize.Height - 15, writer.DirectContent);

            //Line just below header
            //moCB.MoveTo(30, document.PageSize.Height - 35);
            //moCB.LineTo(document.PageSize.Width - 40, document.PageSize.Height - 35);
            //moCB.Stroke();
        }

        private void setFooter(PdfWriter writer, Document document)
        {
            //three columns at bottom of page
            string sText;
            Single fLen;

            //Column 1: Disclaimer
            sText = "Confidential";
            fLen = moBF.GetWidthPoint(sText, 8);

            moCB.BeginText();
            moCB.SetFontAndSize(moBF, 8);
            moCB.SetTextMatrix(30, 30);
            moCB.ShowText(sText);
            moCB.EndText();

            //Column 2: Date/Time
            sText = DateTime.Now.ToString();
            fLen = moBF.GetWidthPoint(sText, 8);

            moCB.BeginText();
            moCB.SetFontAndSize(moBF, 8);
            moCB.SetTextMatrix(document.PageSize.Width / 2 - fLen / 2, 30);
            moCB.ShowText(sText);
            moCB.EndText();

            //Column 3: Page Number
            int iPageNumber = writer.PageNumber;
            sText = "Page " + iPageNumber.ToString() + " of ";
            fLen = moBF.GetWidthPoint(sText, 8);

            moCB.BeginText();
            moCB.SetFontAndSize(moBF, 8);
            moCB.SetTextMatrix(document.PageSize.Width - 90, 30);
            moCB.ShowText(sText);
            moCB.EndText();

            moCB.AddTemplate(moTemplate, document.PageSize.Width - 90 + fLen, 30);
            moCB.BeginText();
            moCB.SetFontAndSize(moBF, 8);
            moCB.SetTextMatrix(280, 820);
            moCB.EndText();

            //Line just above footer
            moCB.MoveTo(30, 40);
            moCB.LineTo(document.PageSize.Width - 40, 40);
            moCB.Stroke();
        }
    }
}
