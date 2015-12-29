using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace XmlConvertor
{
    public partial class Form1 : Form
    {
        string xmlFrom;
        string xmlTo;
        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {

            Logic logic = new Logic();
            logic.ParseXml(xmlFrom, xmlTo);
        }

        private void selectXml_Click(object sender, EventArgs e)
        {
            DialogResult result = openFileDialog1.ShowDialog();

            if (result == DialogResult.OK) // Test result.
            {
                xmlFrom = openFileDialog1.FileName;
                try
                {
                    XmlFrom.Text = xmlFrom;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

        }

        private void openFileDialog1_FileOk(object sender, CancelEventArgs e)
        {

        }

        private void btnSaveXml_Click(object sender, EventArgs e)
        {
            DialogResult result = folderBrowserDialog1.ShowDialog();

            if (result == DialogResult.OK) // Test result.
            {
                xmlTo = folderBrowserDialog1.SelectedPath;
                try
                {
                    XmlTo.Text = xmlTo;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        private void folderBrowserDialog1_HelpRequest(object sender, EventArgs e)
        {

        }
    }
}
