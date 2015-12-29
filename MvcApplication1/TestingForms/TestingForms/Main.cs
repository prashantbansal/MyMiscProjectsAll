using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Data.SqlClient;
using System.Data.OleDb;
using System.Xml;
using Onvia.Model.Glengarry;
using Onvia.Model.Glengarry.Search;
using Onvia.Glengarry.Model;
using Onvia.Glengarry.Library;
using Onvia.Services.Proxies.Search;
using Onvia.Library.Utils;
using System.Xml.Serialization;

namespace Onvia.Glengarry.Search_Automation
{
    public partial class SearchAutomation : Form
    {
        public SearchAutomation()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            LoadSavedQueries LoadXMLForm = new LoadSavedQueries();
            LoadXMLForm.ShowDialog();

            MessageBox.Show("Xmls upload done");

        }

        private void ProjectSearch(object sender, EventArgs e)
        {
            ExecuteProjectSearch();

            MessageBox.Show("Project Search done");
        }

        private void ExecuteProjectSearch()
        {
            SqlConnection connection;
            string savedSearchXml = "";
            string userName = "";
            string password = "";
            string queryname = "";

            try
            {
                connection = new SqlConnection(ConfigurationSettings.AppSettings.Get("GlengarryDBConnection"));
                connection.Open();

                DataSet usersDs = GetUsersList();
                DataSet pubDatesDs = GetPublicationDates(GgSearchType.ProjectResults);

                for (int i = 0; i < usersDs.Tables[0].Rows.Count; i++)
                {
                    userName = usersDs.Tables[0].Rows[i][0].ToString();
                    password = usersDs.Tables[0].Rows[i][1].ToString();

                    foreach (DataRow daterow in pubDatesDs.Tables[0].Rows)
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter("select sh.searchquery,sq.queryname from dbo.o2_SavedQueriesHistory as sh inner join dbo.o2_SavedQueries as sq on sh.queryid = sq.queryid  and sq.currentversionid = sh.versionId inner join dbo.aspnet_Users as us on sq.userid = us.userid where us.username = '" + userName.Trim() + "' and sq.isdeleted != 1", connection);
                        DataSet ds = new DataSet();
                        adapter.Fill(ds);

                        foreach (DataRow eachRow in ds.Tables[0].Rows)
                        {
                            savedSearchXml = eachRow[0].ToString();
                            queryname = eachRow[1].ToString();

                            ExecuteSearchQuery(savedSearchXml, daterow[0].ToString(), userName, password, queryname, GgSearchType.ProjectResults);
                        }
                    }
                }
            }
            catch (Exception)
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

        private void AgencySearch(object sender, EventArgs e)
        {
            ExecuteAgencySearch();

            MessageBox.Show("Agency Search Done");

        }

        private void ExecuteAgencySearch()
        {
            string userName = "";
            string savedSearchXml = "";
            string queryname = "";
            string password = "";
            SqlConnection connection;
            try
            {
                connection = new SqlConnection(ConfigurationSettings.AppSettings.Get("GlengarryDBConnection"));
                connection.Open();
                DataSet usersDs = GetUsersList();

                SqlDataAdapter adapter = new SqlDataAdapter("select QueryId, SearchQuery from dbo.Automation_SearchQueries_AC_SFC where Type = 1 and Status = 1", connection);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                foreach (DataRow eachRow in ds.Tables[0].Rows)
                {
                    queryname = eachRow[0].ToString();
                    savedSearchXml = eachRow[1].ToString();
                    userName = usersDs.Tables[0].Rows[0][0].ToString().Replace("ONVIATEST", string.Empty);
                    password = usersDs.Tables[0].Rows[0][1].ToString();

                    ExecuteSearchQuery(savedSearchXml, "", userName, password, queryname, GgSearchType.GovernmentOrganizationResults);
                }
            }
            catch (Exception)
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

        private void SFCSearch(object sender, EventArgs e)
        {
            ExecuteSFCSearch();

            MessageBox.Show("SFC Search done");
        }

        private void ExecuteSFCSearch()
        {
            string userName = "";
            string queryname = "";
            string savedSearchXml = "";
            string publicationDate = "";
            string password = "";
            SqlConnection connection;

            try
            {
                connection = new SqlConnection(ConfigurationSettings.AppSettings.Get("GlengarryDBConnection"));
                connection.Open();

                DataSet pubDatesDs = GetPublicationDates(GgSearchType.AgencyPlanResults);

                SqlDataAdapter adapter = new SqlDataAdapter("select QueryId, SearchQuery from dbo.Automation_SearchQueries_AC_SFC where Type = 2 and Status=1", connection);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                foreach (DataRow eachRow in ds.Tables[0].Rows)
                {
                    queryname = eachRow[0].ToString();
                    savedSearchXml = eachRow[1].ToString();

                    foreach (DataRow daterow in pubDatesDs.Tables[0].Rows)
                    {
                        publicationDate = daterow[0].ToString();
                        ExecuteSearchQuery(savedSearchXml, publicationDate, userName, password, queryname, GgSearchType.AgencyPlanResults);
                    }
                }
            }
            catch (Exception)
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

        private void SearchAll_Click(object sender, EventArgs e)
        {
            ExecuteProjectSearch();

            ExecuteAgencySearch();

            ExecuteSFCSearch();

            MessageBox.Show("All Searches done");
        }

        private XmlDocument SerializeInQueryXmlBinns(object obj)
        {
            XmlSerializer serializer = new XmlSerializer(typeof(GgBinningSet));
            MemoryStream ms = new MemoryStream();
            XmlTextWriter writer = new XmlTextWriter(ms, new UTF8Encoding());
            writer.Formatting = Formatting.Indented;
            writer.IndentChar = ' ';
            writer.Indentation = 5;
            try
            {
                serializer.Serialize(writer, obj);
                XmlDocument xDoc = new XmlDocument();
                string xmlString = System.Text.Encoding.Default.GetString(ms.ToArray());
                xDoc.LoadXml(xmlString);
                return xDoc;
            }
            catch (Exception ex)
            {
                Logger.Error(string.Format("\r\n Error in Serialize() QueryParser class Message : {0},{1} \r\n", ex.Message, ex.StackTrace));
                throw ex;
            }
            finally
            {
                writer.Close();
                ms.Close();
            }
        }

        private DataSet GetUsersList()
        {
            string usersExcelPath = ConfigurationSettings.AppSettings.Get("usersExcelPath");
            string excelConnectionString = string.Format(ConfigurationSettings.AppSettings.Get("excelConnectionstring").ToString(), usersExcelPath);
            //String sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + @"D:\Manasa\Onvia_TFS\Atlas\Onvia.Glengarry.Search_Automation\users.xls" + ";" + "Extended Properties=Excel 8.0;";
            OleDbConnection objConn = new OleDbConnection(excelConnectionString);
            objConn.Open();
            OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [UserName$]", objConn);
            OleDbDataAdapter objAdapter = new OleDbDataAdapter();
            objAdapter.SelectCommand = objCmdSelect;
            DataSet ds = new DataSet();
            objAdapter.Fill(ds);
            objConn.Close();
            return ds;
        }

        private DataSet GetPublicationDates(GgSearchType searchType)
        {
            string sheetName = "";
            if (searchType == GgSearchType.ProjectResults)
            {
                sheetName = "PC_PubDate";
            }
            else if (searchType == GgSearchType.AgencyPlanResults)
            {
                sheetName = "SFC_PubDate";
            }

            //string sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + @"..\..\..\users.xls" + ";" + "Extended Properties=Excel 8.0;";
            
            string usersExcelPath = ConfigurationSettings.AppSettings.Get("usersExcelPath");
            string excelConnectionString = string.Format(ConfigurationSettings.AppSettings.Get("excelConnectionstring").ToString(), usersExcelPath);
            OleDbConnection objConn = new OleDbConnection(excelConnectionString);
            objConn.Open();
            OleDbCommand objCmdSelect = new OleDbCommand("SELECT * FROM [" + sheetName + "$]", objConn);
            OleDbDataAdapter objAdapter = new OleDbDataAdapter();
            objAdapter.SelectCommand = objCmdSelect;
            DataSet ds = new DataSet();
            objAdapter.Fill(ds);
            objConn.Close();
            return ds;
        }
        
        private void ExecuteSearchQuery(string searchXml, string publicationDate, string UserName, string password, string queryName, GgSearchType searchType)
        {
            SqlConnection connection; 
            try
            {
                Stopwatch startTime = new Stopwatch();
                Stopwatch watch = new Stopwatch();

                connection = new SqlConnection(ConfigurationSettings.AppSettings.Get("GlengarryDBConnection"));
                connection.Open();

                GgSearchQuery query = GgSearchQuery.ReadFromXmlBuffer(searchXml);
                query.RemoveRefinement(new Guid("FE6B0EF5-282F-7E45-88BE-144BE766CF65"));
                GgSearchArgs testargs = query.ToSearchArgs();
                testargs.BatchType = GgBatchType.Default;
                testargs.PageSize = 10;
                testargs.RecordType = GgRecordsType.All;
                testargs.SearchType = searchType;
                testargs.Parameters.TaxonomyRefinements.Add("FE6B0EF5-282F-7E45-88BE-144BE766CF65 || Publication Date[col]a0a27e41-4256-4408-b59e-0d6168bea4a4 || Date Range[col]6ac79439-5672-4555-a1c9-a41e4d7675f9 || " + publicationDate);

                LoginModel model = new LoginModel();
                Onvia.Model.Glengarry.AppUser currentUser = model.ValidateUser(UserName.Replace("ONVIATEST", string.Empty), password.ToString(), "127.0.0.1");
                GgUserProfile userProfile = currentUser.ToGgUserProfile();

                if (searchType == GgSearchType.GovernmentOrganizationResults)
                {
                    UserName = "User_AC";
                }
                else if (searchType == GgSearchType.AgencyPlanResults)
                {
                    UserName = "User_SFC";
                }

                if (null != userProfile)
                {
                    //searchargs.Parameters.UserId = searchProfile.UserId;
                    testargs.UserProfile = userProfile;
                }

                testargs.EnableBinning = true;
                testargs.RequiredBinnings = SearchUtility.GetGgBinningField(searchType);
                testargs.OrganizationBinningLimit = 200;
                testargs.RecordsRequested = 200;
                testargs.Parameters.BinningState = null;
                SearchProxy proxy = SearchProxyFactory.GetProxy(GgBinding.WSHttpBinding);
                startTime.Reset();
                startTime.Start();
                GgSearchResults result = proxy.SearchDocuments(testargs);
                startTime.Stop();
                string searchtime = startTime.Elapsed.ToString();
                testargs.SearchNavigation = new GgSearchNavigation();
                testargs.SearchNavigation.ResultFileId = result.ResultsFileId;

                if (null != result && null != result.Documents)
                {
                    foreach (GgDocument doc in result.Documents)
                    {
                        string docid = doc.DocumentId.ToString();
                        string sqlcmddoc = "insert into dbo.Automation_VivisimoSearchDocuments (Username, SearchQueryName, DocumentId, PublicationDate, CreatedDate)" + "values ('" + UserName + "', '" + queryName + "', '" + docid + "', '" + publicationDate + "', '" + DateTime.Now + "')";
                        SqlCommand sqlCmd = new SqlCommand(sqlcmddoc);
                        sqlCmd.Connection = connection;
                        sqlCmd.ExecuteNonQuery();
                    }
                }

                if (null != result && null != result.SearchNavigationLinks)
                {
                    GgSearchResults browseResult = new GgSearchResults();
                    for (int navcount = 1; navcount < result.SearchNavigationLinks.Count; navcount++)
                    {
                        proxy = SearchProxyFactory.GetProxy(GgBinding.WSHttpBinding);
                        testargs.SearchNavigation.PageAddress = result.SearchNavigationLinks[navcount].PageAddress;
                        watch.Reset();
                        watch.Start();
                        browseResult = proxy.SearchDocuments(testargs);
                        watch.Stop();
                        //watch.Elapsed.ToString(); 
                        string sqlInsert = "insert into dbo.Automation_VivisimoBrowseCall (UserName, SavedQueryName, BrowseCallTime, PublicationDate, CreatedDate)" + " values ('" + UserName + "', '" + queryName + "', '" + watch.Elapsed.ToString() + "', '" + publicationDate + "', '" + DateTime.Now + "')";
                        SqlCommand sqlCmd = new SqlCommand(sqlInsert);
                        sqlCmd.Connection = connection;
                        sqlCmd.ExecuteNonQuery();

                        foreach (GgDocument doc in browseResult.Documents)
                        {
                            string docid = doc.DocumentId.ToString();
                            string sqldoccmd = "insert into dbo.Automation_VivisimoSearchDocuments (Username, SearchQueryName, DocumentId, PublicationDate, CreatedDate)" + "values ('" + UserName + "', '" + queryName + "', '" + docid + "', '" + publicationDate + "', '" + DateTime.Now + "')";
                            SqlCommand sqlCmdDoc = null;
                            sqlCmdDoc = new SqlCommand(sqldoccmd);
                            sqlCmdDoc.Connection = connection;
                            sqlCmdDoc.ExecuteNonQuery();
                        }
                    }
                }
                if (null != result && null != result.Binning)
                {
                    string resultsCount = "";
                    string projresults = result.TotalProjectResults.ToString();
                    string orgresults = result.TotalOrgResults.ToString();
                    string sfcresults = result.TotalAgencyPlanResults.ToString();
                    string sqlresult = null;
                    int bincount = result.Binning.BinningSets.Count;
                    for (int bin = 0; bin < bincount; bin++)
                    {
                        XmlDocument xmlbinn = SerializeInQueryXmlBinns(result.Binning.BinningSets[bin]);
                        string xmlbinncontent = xmlbinn.OuterXml;
                        string insert = "insert into dbo.Automation_VivisimoBinningInfo (Username, SavedQuery, PublicationDate, BinnsetXML) values ('" + UserName + "', '" + queryName + "', '" + publicationDate + "', '" + xmlbinncontent + "')";
                        SqlCommand cmd = new SqlCommand(insert);
                        cmd.Connection = connection;
                        cmd.ExecuteNonQuery();
                    }

                    if (searchType == GgSearchType.ProjectResults)
                    {
                        resultsCount = projresults;
                    }
                    else if (searchType == GgSearchType.GovernmentOrganizationResults)
                    {
                        resultsCount = orgresults;
                    }
                    else if (searchType == GgSearchType.AgencyPlanResults)
                    {
                        resultsCount = sfcresults;
                    }

                    sqlresult = "insert into dbo.Automation_VivisimoSearchResults (UserName, SavedQueryName, TotalResults, TotalBinsetCount, SearchTime, PublicationDate, CreatedDate)" + "values ('" + UserName + "', '" + queryName + "', '" + resultsCount + "', '" + bincount + "', '" + searchtime + "', '" + publicationDate + "', '" + DateTime.Now + "')";
                    SqlCommand sqlCmd = new SqlCommand(sqlresult);
                    sqlCmd.Connection = connection;
                    sqlCmd.ExecuteNonQuery();
                }
            }
            catch (Exception)
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

        
    }
}
