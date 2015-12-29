using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Text;
using System.Xml;

namespace FlickrProcessor
{
    public static class FlickrApiWrapper
    {

        /// <summary>
        /// public method for processing pictures
        /// </summary>
        /// <param name="searchType">search type (public/private)</param>
        /// <param name="userId">user id of user to be searched for</param>
        /// <param name="SafeSearchLevel">level of safe search</param>
        /// <param name="noOfPicsPerPage">no of pics to be retrieved per page</param>
        /// <param name="tags">tag value as provided by user</param>
        /// <returns>path of saved MRSS feed</returns>
        public static string ProcessPictures(string searchType, string userId, string SafeSearchLevel, string noOfPicsPerPage, string tags)
        {
            XmlDocument XMLResponse = null;

            Console.WriteLine("Processing Flickr URL");

            //Generates flickr URL at runtime
            string URL = ProcessFlickrURL(searchType, userId, SafeSearchLevel, noOfPicsPerPage, tags);

            System.Uri flickrUri = new System.Uri(URL);
            HttpWebRequest httpwebRequest = (HttpWebRequest)WebRequest.Create(flickrUri);
            HttpWebResponse response = (HttpWebResponse)httpwebRequest.GetResponse();
            Stream stream = response.GetResponseStream();

            Console.WriteLine("Succesfully processed Flickr URL");

            using (XmlTextReader objXMLReader = new XmlTextReader(stream))
            {
                XmlDocument xmldoc = new XmlDocument();
                xmldoc.Load(objXMLReader);

                XMLResponse = xmldoc;
            }

            if (XMLResponse == null)
            {
                throw new Exception("Xml Document is null");
            }

            return ProcessXml(XMLResponse);
        }

        /// <summary>
        /// Processes flickr input and generates MRSS feed
        /// </summary>
        /// <param name="xmlDocument"></param>
        /// <returns></returns>
        private static string ProcessXml(XmlDocument xmlDocument)
        {
            string applicationDir = AppDomain.CurrentDomain.BaseDirectory;

            string MRSSFilePath = string.Format(ConfigReader.GetMRSSFileNameFormat(), DateTime.Now.ToString("dd-MM-yyyy"));
            MRSSFilePath = string.Format("{0}{1}", applicationDir, MRSSFilePath);

            xmlDocument.Save(MRSSFilePath);

            return MRSSFilePath;
        }

        /// <summary>
        /// generates flickr API URL
        /// </summary>
        /// <param name="searchType"></param>
        /// <param name="userId"></param>
        /// <param name="SafeSearchLevel"></param>
        /// <param name="noOfPicsPerPage"></param>
        /// <param name="tags"></param>
        /// <returns></returns>
        private static string ProcessFlickrURL(string searchType,string userId,string SafeSearchLevel, string noOfPicsPerPage, string tags)
        {
            string url = ConfigReader.GetFlickrApiURL();

            url = string.Format("{0}&{1}", url, string.Format(ConfigReader.GetAPIKeyFormat(), ConfigReader.GetApiKey()));

            url = string.Format("{0}&{1}", url, "&page=1");

            if (!string.IsNullOrEmpty(searchType))
            {
                searchType = string.Format(ConfigReader.GetMethodKeyFormat(), FlickerAPIInput.GetMethodsList().First(p => p.Id.Equals(searchType)).Value);
                url = string.Format("{0}&{1}", url, searchType);
            }

            //commented as UserId is not being used for search
            //if (!string.IsNullOrEmpty(userId))
            //{
            //    userId = string.Format(ConfigReader.GetApiUserIdFormat(), userId);
            //    url = string.Format("{0}&{1}", url, userId);
            //}

            if (!string.IsNullOrEmpty(SafeSearchLevel))
            {
                SafeSearchLevel = string.Format(ConfigReader.GetSafeSearchFormat(), SafeSearchLevel);
                url = string.Format("{0}&{1}", url, SafeSearchLevel);
            }

            if (!string.IsNullOrEmpty(noOfPicsPerPage))
            {
                noOfPicsPerPage = string.Format(ConfigReader.GetApiPagesFormat(), noOfPicsPerPage);
                url = string.Format("{0}&{1}", url, noOfPicsPerPage);
            }

            if (!string.IsNullOrEmpty(tags))
            {
                tags = string.Format(ConfigReader.GetApiTagsFormat(), tags);
                url = string.Format("{0}&{1}&tag_mode=all", url, tags);
            }

            url = string.Format("{0}{1}",url,"&format=feed-rss_200");        

            return url;
        }
    }
}
