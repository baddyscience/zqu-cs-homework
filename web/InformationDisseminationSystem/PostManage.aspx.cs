using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace WebInfoSystem
{
    public partial class PostManage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                LoadPosts();
            }
        }

        private void LoadPosts()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(
                    "SELECT PostID, Title, CategoryName FROM Post INNER JOIN Category ON Post.CategoryID = Category.CategoryID",
                    conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvPosts.DataSource = dt;
                gvPosts.DataBind();
            }
        }

        protected void gvPosts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = (int)gvPosts.DataKeys[e.RowIndex].Value;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Post WHERE PostID=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadPosts();
        }

        protected void gvPosts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = (int)gvPosts.DataKeys[e.NewEditIndex].Value;
            Response.Redirect("PostEdit.aspx?id=" + id);
        }

        protected void btnAddPost_Click(object sender, EventArgs e)
        {
            Response.Redirect("PostAdd.aspx");
        }
    }
}