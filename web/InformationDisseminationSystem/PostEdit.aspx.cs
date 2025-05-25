using System;
using System.Configuration;
using System.Data.SqlClient;

namespace WebInfoSystem
{
    public partial class PostEdit : System.Web.UI.Page
    {
        protected int PostId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
                Response.Redirect("Login.aspx");

            PostId = Convert.ToInt32(Request.QueryString["id"]);

            if (!IsPostBack)
            {
                LoadCategories();
                LoadPost();
            }
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Category", conn);
                conn.Open();
                ddlCategory.DataSource = cmd.ExecuteReader();
                ddlCategory.DataTextField = "CategoryName";
                ddlCategory.DataValueField = "CategoryID";
                ddlCategory.DataBind();
            }
        }

        private void LoadPost()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Post WHERE PostID=@id", conn);
                cmd.Parameters.AddWithValue("@id", PostId);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtTitle.Text = reader["Title"].ToString();
                    txtContent.Text = reader["Content"].ToString();
                    ddlCategory.SelectedValue = reader["CategoryID"].ToString();
                }
                reader.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string content = txtContent.Text.Trim();
            int categoryId = int.Parse(ddlCategory.SelectedValue);

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Post SET Title=@title, Content=@content, CategoryID=@cat WHERE PostID=@id", conn);
                cmd.Parameters.AddWithValue("@title", title);
                cmd.Parameters.AddWithValue("@content", content);
                cmd.Parameters.AddWithValue("@cat", categoryId);
                cmd.Parameters.AddWithValue("@id", PostId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("PostManage.aspx");
        }
    }
}
