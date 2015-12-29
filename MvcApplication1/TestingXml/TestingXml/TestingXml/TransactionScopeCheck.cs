using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Transactions;

namespace TestingXml
{
    public class TransactionScopeCheck
    {
        public void CheckTransaction()
        {
            List<String> strColln = new List<string>();
            try
            {
                strColln.Add("aa");
                using (TransactionScope scope = new TransactionScope())
                {
                    strColln.Add("bb");
                    throw new DivideByZeroException();
                    
                    scope.Complete();
                }
            }
            catch (Exception)
            {
                
            }
            finally
            {
                int a = strColln.Count;
            }
        }
    }
}
