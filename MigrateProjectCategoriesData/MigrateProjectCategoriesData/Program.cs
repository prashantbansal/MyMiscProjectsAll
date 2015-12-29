using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace MigrateProjectCategoriesData
{
    class Program
    {
        static void Main(string[] args)
        {
            try
            {
                DateTime StartDate = new DateTime(2010, 12, 1, 0, 0, 0);
                DateTime EndDate = new DateTime(2011, 3, 24, 23,59, 59);

                while (StartDate < EndDate)
                {
                    SqlConnectionStringBuilder cb = new SqlConnectionStringBuilder();
                    cb.DataSource = "SEADRPTSQL0.ONVIAWEB.PROD";
                    cb.InitialCatalog = "reportingDatabase";
                    cb.IntegratedSecurity = true;
                    SqlConnection conn = new SqlConnection(cb.ConnectionString);

                    SqlCommand StoredProcedureCommand = new SqlCommand("GetProjectCategoriesData", conn);
                    StoredProcedureCommand.CommandType = CommandType.StoredProcedure;
                    SqlParameter myParm1 = StoredProcedureCommand.Parameters.Add("@StartDate", SqlDbType.DateTime, 20);
                    myParm1.Value = StartDate;
                    SqlParameter myParm2 = StoredProcedureCommand.Parameters.Add("@EndDate", SqlDbType.DateTime, 20);
                    myParm2.Value = StartDate.AddDays(1).AddSeconds(-1);
                    conn.Open();
                    SqlDataReader rdr = StoredProcedureCommand.ExecuteReader();

                    SqlBulkCopy sbc = new SqlBulkCopy("server=seadmktsql0;database=Duncan;" + "Integrated Security=SSPI");
                    sbc.DestinationTableName = "dbo.o2_ProjectCategories";
                    sbc.WriteToServer(rdr);
                    sbc.Close();
                    rdr.Close();
                    conn.Close();
                    StartDate = StartDate.AddDays(1);
                }
            }

            catch (Exception)
            {
                throw;
            }
        }
    }
}
