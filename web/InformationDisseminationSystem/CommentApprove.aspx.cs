using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebInfoSystem
{
    public partial class CommentApprove : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadComments();
            }
        }

        private void LoadComments()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Comments WHERE IsApproved = 0", conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvComments.DataSource = dt;
                gvComments.DataBind();
            }
        }

        protected void gvComments_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve")
            {
                int commentId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("UPDATE Comments SET IsApproved = 1 WHERE CommentID = @id", conn);
                    cmd.Parameters.AddWithValue("@id", commentId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadComments();
            }
            if (e.CommandName == "Reject")
            {
                int commentId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("DELETE FROM Comments WHERE CommentID = @id", conn);
                    cmd.Parameters.AddWithValue("@id", commentId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadComments();
            }
        }
    }
}