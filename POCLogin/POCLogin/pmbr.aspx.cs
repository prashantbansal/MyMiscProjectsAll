using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using Newtonsoft.Json;

namespace POCLogin
{
    public partial class pmbr : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.GetAccessToken();
           
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //this.GetCode();
            
        }

        private void UsingAccessToken()
        {
            if (!string.IsNullOrEmpty(this.txtAccessToken.Text))
            {
                string url = @"https://api.stg.kaptest.net/ke/3.0/onlineprofile";
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                request.Method = "GET";
                request.ContentType = "application/x-www-form-urlencoded";
                //request.Headers.Add(HttpRequestHeader.a);
            }
        }

        private void GetCode()
        {
            try
            {
                string URL =
                @"https://testsso.kaplan.edu/as/authorization.oauth2?client_id=pmbr&response_type=code&scope=profile&pfidpadapterid=KaptestMobileSTGInstance&state=<optional>";
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(URL);
                request.ContentType = "application/x-www-form-urlencoded";
                request.Method = "POST";
                StreamWriter newStream = new StreamWriter(request.GetRequestStream());
                newStream.Write("");
                newStream.Close();
                HttpWebResponse resp = (HttpWebResponse)request.GetResponse();
                Response.Redirect(resp.ResponseUri.AbsoluteUri,true);

                //StreamReader reader = new StreamReader(resp.GetResponseStream());
                //string content = reader.ReadToEnd();


            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        private void GetAccessToken()
        {
            try
            {
                string strAccessCode = this.txtCode.Text;
                string postData = "grant_type=authorization_code&code=" + strAccessCode;

                string authInfo = "pmbr:71yPEGp7SCfaoP3M2VY1oEW4RPBtyUbX";
                authInfo = Convert.ToBase64String(Encoding.Default.GetBytes(authInfo));
                
                string Url = "https://testsso.kaplan.edu/as/token.oauth2";
                HttpWebRequest myRequest = (HttpWebRequest)WebRequest.Create(Url);
                myRequest.Headers["Authorization"] = "Basic " + authInfo;

                myRequest.ContentType = "application/x-www-form-urlencoded";
                myRequest.ContentLength = postData.Length;
                myRequest.Method = "POST";
                StreamWriter newStream = new StreamWriter(myRequest.GetRequestStream());
                newStream.Write(postData);
                newStream.Close();

                HttpWebResponse resp = (HttpWebResponse)myRequest.GetResponse();
                if (resp.StatusCode == HttpStatusCode.OK)
                {
                    //Get the response stream  
                    StreamReader reader = new StreamReader(resp.GetResponseStream());
                    string content = reader.ReadToEnd();
                    //set the response to a JSON object
                    JavaScriptSerializer jss=new JavaScriptSerializer();
                    //Dictionary<string, string> result1 = jss.Deserialize<Dictionary<string, string>>(content);
                    Dictionary<string, string> result = JsonConvert.DeserializeObject<Dictionary<string, string>>(content);
                    
                    this.txtTokenType.Text = result["token_type"];
                    this.txtExpiresIn.Text = result["expires_in"];
                    this.txtAccessToken.Text = result["access_token"];
                    
                    //String strRefreshToken = result["refresh_token"];
                    
                    
                    //Response.Write("Access Token = " + strAccessToken + "<br>");
                    //Response.Write("<a href='validateToken.aspx?at=" + strAccessToken + "'>Validate access token</a><BR>");
                    //Response.Write("Refresh Token = " + strRefreshToken + "<br>");
                    //Response.Write("<a href='refreshToken.aspx?rt=" + strRefreshToken + "'>Refresh access token</a>");
                }
            }
            catch (Exception ex)
            {
                //throw ex;
            }
           
        }
    }
}