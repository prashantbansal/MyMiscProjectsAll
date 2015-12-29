using System;
using System.Collections.Generic;
using System.Text;
using Micorsoft.SqlServer.DTSPkg80;   

namespace DTSApplication
{
    class Program
    {
        static void Main(string[] args)
        {
            Package objPackage = new Package();
            try
            {
                object pVarPersistStgOfHost = null;                
                objPackage.LoadFromSQLServer("isvpoc6\\inst1", "", "", DTSSQLServerStorageFlags.DTSSQLStgFlag_UseTrustedConnection, "", "", "", "pkgTECHONUpdatePatch", ref pVarPersistStgOfHost);
                objPackage.GlobalVariables.Item("FileName").let_Value(@"e:\Sample2.txt");

                Console.WriteLine(objPackage.GlobalVariables.Item("FileName").Value.ToString()); 
                objPackage.Execute();
                
                Console.WriteLine("Succesfully Executed");
                Console.Read();
            }
            catch (Exception objex)
            {
                Console.WriteLine(objex.Message);
                Console.Read();
            }
            finally
            {
                objPackage.UnInitialize();
                objPackage = null;
            }

        }
    }
}
