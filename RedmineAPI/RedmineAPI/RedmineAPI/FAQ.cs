using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RedmineAPI
{
    public class FAQ
    {
        public string Title { get; set; }

        public string Question { get; set; }

        public string Response { get; set; }

        public string MaterialCategory { get; set; }

        public string Keyword { get; set; }

        public string FAQIdentifier { get; set; }

        public String TopicAssociation { get; set; }

        public DateTime LastModifiedOn { get; set; }

        public string ZendeskTicketID { get; set; }

        public string RedmineTicketID { get; set; }

        public string Status { get; set; }
    }
}