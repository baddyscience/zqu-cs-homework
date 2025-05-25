using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace WebInfoSystem
{
    public partial class CommentSubmit : System.Web.UI.Page
    {
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("UserLogin.aspx");
                return;
            }

            int postId = Convert.ToInt32(Request.QueryString["postid"]);
            string content = txtComment.Text.Trim();
            string username = Session["user"].ToString();

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnStr"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Comments (PostID, Username, Content, IsApproved) VALUES (@pid, @u, @c, 0)", conn);
                cmd.Parameters.AddWithValue("@pid", postId);
                cmd.Parameters.AddWithValue("@u", username);
                cmd.Parameters.AddWithValue("@c", content);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.Text = "留言提交成功，等待审核。";
        }
    }
}