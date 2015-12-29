using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data;
using System.Data.OleDb;

namespace TFSReader
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                DataSet ds=new DataSet();
                string filePath = @"D:\Projects\TFSReader\TFSReader\bin\Book1.xlsx";
                string strConn = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" + filePath + ";" + "Extended Properties=Excel 8.0;HDR=YES;IMEX=1";
                New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & FilePath & ";Extended Properties=""Excel 8.0;HDR=Yes;IMEX=1"";")
                //You must use the $ after the object you reference in the spreadsheet            
                OleDbConnection objConn = new OleDbConnection(strConn);
                objConn.Open();

                OleDbDataAdapter adapter = new OleDbDataAdapter(@"select * from [Main$]", objConn);
                adapter.Fill(ds);
                objConn.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            

        }
    }
}
