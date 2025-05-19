using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class DBHelper
{
    private static string connString = ConfigurationManager.ConnectionStrings["StudentDB"].ConnectionString;

    public static DataTable GetStudents()
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Students", conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }
    }

    public static void InsertStudent(string name, int age, string email)
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Students (Name, Age, Email) VALUES (@Name, @Age, @Email)", conn);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Age", age);
            cmd.Parameters.AddWithValue("@Email", email);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public static void UpdateStudent(int id, string name, int age, string email)
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd = new SqlCommand(
                "UPDATE Students SET Name=@Name, Age=@Age, Email=@Email WHERE ID=@ID", conn);
            cmd.Parameters.AddWithValue("@ID", id);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Age", age);
            cmd.Parameters.AddWithValue("@Email", email);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    public static void DeleteStudent(int id)
    {
        using (SqlConnection conn = new SqlConnection(connString))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM Students WHERE ID=@ID", conn);
            cmd.Parameters.AddWithValue("@ID", id);
            conn.Open();
            cmd.ExecuteNonQuery();
        }
    }
}