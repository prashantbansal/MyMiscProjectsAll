using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Net;
using System.IO;
using System.Xml;

namespace WebApplication1
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            string kaptestURL = @"http://ktws.kaptest.com/student/courseaccess/v1/xml/GET";
            // create uri to request backend authentication
            UriBuilder url = new UriBuilder(kaptestURL) { Query = "userId=" + "slambino.pmbr@gmail.com" + "&password=" + "kaplan789" };

            // call Kaptest to get the user enrollments
            HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url.Uri);
            if (webRequest == null)
                throw new Exception("Authentication web request could not be constructed.");

            // set timeout for web service call
            webRequest.Timeout = 10000;

            XmlDocument xmlDoc = new XmlDocument();
            //User userObj = new User();

            using (HttpWebResponse webResponse = (HttpWebResponse)webRequest.GetResponse())
            {
                using (Stream responseStream = webResponse.GetResponseStream())
                    xmlDoc.Load(responseStream);
            }

            // get the list of enrollment ids from the web service response xml
            XmlNodeList nodeList = xmlDoc.SelectNodes("/response/payload/course_access_info/course_accesses/course_access/enrollment_id");
            if (nodeList == null)
                throw new Exception("No active enrollments exist for user.");

            StringBuilder nodes = new StringBuilder();
            //nodes.Append("1003157723").Append(";");
            for (int i = 0; i < nodeList.Count; i++)
            {
                nodes.Append(nodeList[i].InnerText);
                if (i < (nodeList.Count - 1)) nodes.Append(";");
            }

            //// resolve the courses in PMBR from the enrollment_ids
            //userObj.Courses = GetFriendlyCourseNames(nodes.ToString());
            //if (userObj.Courses == null || userObj.Courses.Length < 1)
            //    throw new Exception("User does not have active enrollments");

            //string[] userIds = new string[userObj.Courses.Length];
            //for (int i = 0; i < userIds.Length; i++)
            //    userIds[i] = userObj.Courses[i].UserId;

            //// generate new security token
            //SecurityToken token = new SecurityToken();
            //userObj.Token = token.GenerateToken(userIds);

            //return userObj;

        }
    }
}
