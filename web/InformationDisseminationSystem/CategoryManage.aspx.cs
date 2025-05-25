using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace WebInfoSystem
{
    public partial class CategoryManage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
            {
                BindCategories();
            }
        }

        private void BindCategories()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Category", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCategory.DataSource = dt;
                gvCategory.DataBind();
            }
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            string name = txtNewCategory.Text.Trim();
            if (name == "") return;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Category (CategoryName) VALUES (@name)", conn);
                cmd.Parameters.AddWithValue("@name", name);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            txtNewCategory.Text = "";
            BindCategories();
        }

        protected void gvCategory_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategory.EditIndex = e.NewEditIndex;
            BindCategories();
        }

        protected void gvCategory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategory.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = (int)gvCategory.DataKeys[e.RowIndex].Value;
            string newName = ((TextBox)gvCategory.Rows[e.RowIndex].Cells[1].Controls[0]).Text;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Category SET CategoryName=@name WHERE CategoryID=@id", conn);
                cmd.Parameters.AddWithValue("@name", newName);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            gvCategory.EditIndex = -1;
            BindCategories();
        }

        protected void gvCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = (int)gvCategory.DataKeys[e.RowIndex].Value;

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Category WHERE CategoryID=@id", conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            BindCategories();
        }
    }
}