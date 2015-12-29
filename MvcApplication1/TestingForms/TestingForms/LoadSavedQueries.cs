using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO;
using Onvia.Model.Glengarry.Search;
using System.Data.SqlClient;
using System.Configuration;
using Onvia.Library.Utils;

namespace Onvia.Glengarry.Search_Automation
{
    public partial class LoadSavedQueries : Form
    {
        public LoadSavedQueries()
        {
            InitializeComponent();
        }

        private void btnBrowse_Click(object sender, EventArgs e)
        {
            if (this.folderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                this.InputFolder.Text = this.folderBrowserDialog1.SelectedPath;
            }
        }

        private void btnLoad_Click(object sender, EventArgs e)
        {
            if (!String.IsNullOrEmpty(this.InputFolder.Text))
            {
                this.SaveXmlsToDatabase(GgSearchType.GovernmentOrganizationResults, this.InputFolder.Text);
                this.SaveXmlsToDatabase(GgSearchType.AgencyPlanResults, this.InputFolder.Text);

                Logger.Info("Saved Queries Loaded");
            }
        }

        private void SaveXmlsToDatabase(GgSearchType searchType, string BaseFolderPath)
        {
            SqlConnection connection = new SqlConnection(ConfigurationSettings.AppSettings.Get("GlengarryDBConnection"));
            connection.Open();
            //File Path to get search xmls
            string folderPath = string.Empty;
            string queryType = string.Empty;
            if (searchType == GgSearchType.GovernmentOrganizationResults)
            {
                //relative folders path
                folderPath = BaseFolderPath + @"\AC";
                queryType = "1";
            }
            else if (searchType == GgSearchType.AgencyPlanResults)
            {
                //relative folders path
                folderPath = BaseFolderPath + @"\SFC";
                queryType = "2";
            }

            string[] filePaths = Directory.GetFiles(folderPath);
            try
            {

                if (filePaths != null && filePaths.Count() > 0)
                {
                    foreach (string xmlPath in filePaths)
                    {
                        try
                        {
                            StreamReader streamReader = new StreamReader(xmlPath);
                            string text = streamReader.ReadToEnd();
                            streamReader.Close();

                            string insert = "insert into dbo.Automation_SearchQueries_AC_SFC (QueryId, Type, CreatedDate, SearchQuery, Status ) values ('" + Guid.NewGuid().ToString() + "', '" + queryType + "', '" + DateTime.Now + "', '" + text + "', '" + "1" + "')";
                            SqlCommand cmd = new SqlCommand(insert);
                            cmd.Connection = connection;
                            cmd.ExecuteNonQuery();
                        }
                        catch
                        {
                            throw;
                        }
                    }
                }
            }
            catch
            {
                throw;
            }
            finally
            {

                if (connection.State != ConnectionState.Closed)
                {
                    connection.Close();
                }
            }
        }

        private void InputFolder_TextChanged(object sender, EventArgs e)
        {

        }

    }
}

