using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace FlickrProcessor
{
    public class ConfigReader
    {
        public static string GetApiKey()
        {

            return ConfigurationManager.AppSettings["Api_key"].ToString();
        }

        public static string GetSecretKey()
        {
            return ConfigurationManager.AppSettings["Secret_key"].ToString();
        }

        public static string GetAPIKeyFormat()
        {
            return ConfigurationManager.AppSettings["flickrApi_key"].ToString();
        }

        public static string GetFlickrApiURL()
        {
            return ConfigurationManager.AppSettings["flickrApiURL"].ToString();
        }
        public static string GetMethodKeyFormat()
        {
            return ConfigurationManager.AppSettings["flickrApiMethodKey"].ToString();
        }
        public static string GetApiUserIdFormat()
        {
            return ConfigurationManager.AppSettings["flickrApiUserId"].ToString();
        }
        public static string GetSafeSearchFormat()
        {
            return ConfigurationManager.AppSettings["flickrApiSafeSearch"].ToString();
        }
        public static string GetApiPagesFormat()
        {
            return ConfigurationManager.AppSettings["flickrApiPages"].ToString();
        }
        public static string GetApiTagsFormat()
        {
            return ConfigurationManager.AppSettings["flickrApiTags"].ToString();
        }
        public static string GetFlickrPicURL()
        {
            return ConfigurationManager.AppSettings["flickrPicURL"].ToString();
        }
        public static string GetMRSSFileNameFormat()
        {
            return ConfigurationManager.AppSettings["MRSSFileNameFormat"].ToString();
        }
    }
}
