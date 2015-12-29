using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PrashantWebApp
{
    public partial class DownloadManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void DownloadContentFromAkamai()
        {
            string fileName = "";
            string filePath = "";//Utilities.GetContentFilesPath(filesCategory, L1TopicName, fileName);

            try
            {
                if (string.IsNullOrWhiteSpace(filePath))
                    throw new Exception();
                var extension = Path.GetExtension(fileName);
                string url = filePath;

                WebClient client = new WebClient();
                byte[] data = client.DownloadData(new Uri(url));
                if (data.Length > 0)
                {
                    Response.Clear();
                    Response.ContentType = "pdf";
                    Response.AppendHeader("Content-Disposition", String.Format("attachment; filename={0}", fileName));
                    Response.OutputStream.Write(data, 0, data.Length);
                }
                //Response.End();
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch (Exception exception)
            {
                throw exception;
            }
        }
    }
}