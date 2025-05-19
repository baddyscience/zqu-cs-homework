using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public class DataAccess
{
    private string connStr = ConfigurationManager.ConnectionStrings["web"].ConnectionString;

    public DataTable ExecuteQuery(string sql, SqlParameter[] parameters = null)
    {
        using (var conn = new SqlConnection(connStr))
        using (var cmd = new SqlCommand(sql, conn))
        {
            if (parameters != null) cmd.Parameters.AddRange(parameters);
            conn.Open();
            DataTable dt = new DataTable();
            dt.Load(cmd.ExecuteReader());
            return dt;
        }
    }

    public int ExecuteNonQuery(string sql, SqlParameter[] parameters = null)
    {
        using (var conn = new SqlConnection(connStr))
        using (var cmd = new SqlCommand(sql, conn))
        {
            if (parameters != null) cmd.Parameters.AddRange(parameters);
            conn.Open();
            return cmd.ExecuteNonQuery();
        }
    }
}