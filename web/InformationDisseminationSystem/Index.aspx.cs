using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web;

namespace WebInfoSystem
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user"] != null)
                {
                    loginLink.Visible = false;
                    lblWelcome.Text = "欢迎，" + Session["user"].ToString();
                    lnkLogout.Visible = true;
                }
                else
                {
                    loginLink.Visible = true;
                    lblWelcome.Text = "游客浏览";
                    lnkLogout.Visible = false;
                }

                LoadCategories();
                LoadPosts();
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session["user"] = null;
            Response.Redirect("Index.aspx");
        }

        private void LoadCategories()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Category", conn);
                conn.Open();
                ddlFilterCategory.DataSource = cmd.ExecuteReader();
                ddlFilterCategory.DataTextField = "CategoryName";
                ddlFilterCategory.DataValueField = "CategoryID";
                ddlFilterCategory.DataBind();
                ddlFilterCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("全部栏目", "0"));
            }
        }

        private void LoadPosts()
        {
            string sql = "SELECT Post.PostID, Title, Content, CategoryName FROM Post INNER JOIN Category ON Post.CategoryID = Category.CategoryID";
            if (ddlFilterCategory.SelectedValue != "0")
            {
                sql += " WHERE Post.CategoryID=@cat";
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                if (ddlFilterCategory.SelectedValue != "0")
                {
                    cmd.Parameters.AddWithValue("@cat", ddlFilterCategory.SelectedValue);
                }
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptPosts.DataSource = dt;
                rptPosts.DataBind();
            }
        }

        protected void ddlFilterCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadPosts();
        }


        public DataTable GetComments(object postIdObj)
        {
            int postId = Convert.ToInt32(postIdObj);
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT Username, Content FROM Comments WHERE PostID=@pid AND IsApproved=1", conn);
                cmd.Parameters.AddWithValue("@pid", postId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        protected string FormatContent(object content)
        {
            return HttpUtility.HtmlEncode(content.ToString())
                              .Replace("\n", "<br/>")
                              .Replace(" ", "&nbsp;");
        }
    }
}
