using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml;


namespace XmlConvertor
{
    public class Logic
    {
        public List<Flashcard> L2TopicCollection = new List<Flashcard>();

        public void AddL1L2Association()
        {
            Flashcard fcL2;
            
            fcL2 = new Flashcard();
            fcL2.L1Topic = "Georgia";
            fcL2.L2Topic = "Trusts, Wills & Estates (GA)";
            L2TopicCollection.Add(fcL2);

            fcL2 = new Flashcard();
            fcL2.L1Topic = "Georgia";
            fcL2.L2Topic = "Corporations (GA)";
            L2TopicCollection.Add(fcL2);

            fcL2 = new Flashcard();
            fcL2.L1Topic = "MBE";
            fcL2.L2Topic = "Criminal Law & Procedure";
            L2TopicCollection.Add(fcL2);

            fcL2 = new Flashcard();
            fcL2.L1Topic = "";
            fcL2.L2Topic = "";
            L2TopicCollection.Add(fcL2);
        }

        public void ParseXml(string xmlFromPath, string XmlSavePath)
        {
            try
            {
                int idCounter = 0;
                AddL1L2Association();

                List<string> pathlist = xmlFromPath.Split('\\').ToList();
                
                XmlSavePath=string.Format(@"{0}\Formatted_{1}",XmlSavePath,pathlist.Last());
                    
                //string fileName=xmlFromPath.in

                //string xmlPath = @"D:\kaplan\Documents\Flash Cards\Xmls\Flashcardxmls\Original\Combined Bar Points.xml";

                Flashcard fc;
                List<Flashcard> fcList = new System.Collections.Generic.List<Flashcard>();

                if (File.Exists(xmlFromPath))
                {
                    XmlDocument xmlDoc = new XmlDocument();
                    xmlDoc.Load(xmlFromPath);

                    if (xmlDoc != null)
                    {
                        int SubjectCount = xmlDoc.SelectNodes("//SubjectName").Count;

                        for (int i = 0; i < SubjectCount; i++)
                        {
                            //fc=new Flashcard();
                            XmlNode subjectNode = xmlDoc.SelectNodes("//SubjectName").Item(i);

                            string subjectName = xmlDoc.SelectNodes("//SubjectName").Item(i).InnerText;

                            XmlNode xmlTopics = xmlDoc.SelectNodes("//Topics").Item(i);

                            XmlNodeList xmlTopicList = xmlTopics.SelectNodes("//Topic");

                            foreach (XmlNode xmlTopicNode in xmlTopicList)
                            {
                                string topicName = xmlTopicNode.SelectSingleNode("//TopicName").InnerText;

                                XmlNodeList subTopicslist = xmlTopicNode.SelectNodes("//SubTopic");

                                foreach (XmlNode subTopicsNode in subTopicslist)
                                {
                                    string subTopicName = subTopicsNode.SelectSingleNode("//SubTopicName").InnerText;

                                    XmlNodeList barPointContentList = subTopicsNode.SelectNodes("//Barpoint_Content");

                                    
                                    foreach (XmlNode barPointNode in barPointContentList)
                                    {
                                        idCounter++;
                                        if (barPointNode.ChildNodes != null && barPointNode.ChildNodes.Count > 0)
                                        {
                                            string question = barPointNode.ChildNodes[0].ChildNodes[1].InnerText;

                                            string answer = barPointNode.ChildNodes[1].ChildNodes[1].InnerText;

                                            fc = new Flashcard();
                                            fc.L1Topic = L2TopicCollection.FirstOrDefault(t => t.L2Topic.Equals(subjectName)).L1Topic;
                                            fc.L2Topic = subjectName;
                                            fc.L3Topic = topicName;
                                            fc.Question = question;
                                            fc.Answer = answer;
                                            fc.Title = subTopicName;
                                            fc.KaplanId = string.Format("{0}({1})", topicName, idCounter);

                                            fcList.Add(fc);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                FormatXml(fcList, XmlSavePath);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void FormatXml(List<Flashcard> fcList, string xmlSavePath)
        {
            try
            {
                StringBuilder sb = new StringBuilder();
                sb.Append("<xml>");
                foreach (Flashcard fc in fcList)
                {
                    sb.AppendFormat("<FCQuestion contentItemName=\"{0}\">", fc.KaplanId);
                    sb.Append("<categoryRefs>");
                    sb.AppendFormat("<catRef-Qbank categoryName=\"{0} | {1} | {2}\"/>", fc.L1Topic, fc.L2Topic, fc.L3Topic);
                    sb.Append("</categoryRefs>");
                    sb.AppendFormat("<SubTopicName>{0}</SubTopicName>", fc.Title);
                    sb.AppendFormat("<question-stem><para>{0}</para></question-stem>", fc.Question);
                    sb.AppendFormat("<answer-stem><para>{0}</para></answer-stem>", fc.Answer);
                    sb.Append("</FCQuestion>");
                }
                sb.Append("</xml>");

                // create a writer and open the file
                TextWriter tw = new StreamWriter(xmlSavePath);

                // write a line of text to the file
                tw.WriteLine(sb.ToString());

                // close the stream
                tw.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
