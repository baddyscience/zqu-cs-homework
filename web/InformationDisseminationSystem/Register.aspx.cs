using System;
using System.Data.SqlClient;
using System.Configuration;

namespace WebInfoSystem
{
    public partial class Register : System.Web.UI.Page
    {

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Users (Username, Password) VALUES (@u, @p)", conn);
                cmd.Parameters.AddWithValue("@u", username);
                cmd.Parameters.AddWithValue("@p", password);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.Text = "注册成功，请登录！";
        }
    }
}