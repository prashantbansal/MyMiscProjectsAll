using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RedmineAPI
{
    public class FAQFieldMapping
    {
        public string FAQFieldName { get; set; }
        public IList<string> RedmineFieldNameList { get; set; }
        public bool IsCustomField { get; set; }
        public bool HasMultipleSelections { get; set; }

        public FAQFieldMapping()
        {
            RedmineFieldNameList = new List<string>();
        }
    }
}