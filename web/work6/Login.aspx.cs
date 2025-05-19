using System;
using System.Web.Security;

namespace YourNamespace
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/SecurePage.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string username = txtUsername.Text.Trim();
                string password = txtPassword.Text;

                if (ValidateUser(username, password))
                {
                    FormsAuthentication.RedirectFromLoginPage(username, false);
                }
                else
                {
                    ShowError("用户名或密码错误");
                }
            }
        }

        private bool ValidateUser(string username, string password)
        {
            // 数据库验证示例（需实现实际验证逻辑）
            // using (var conn = new SqlConnection(connectionString))
            // {
            //     var cmd = new SqlCommand(
            //         "SELECT PasswordHash FROM Users WHERE Username=@user", conn);
            //     cmd.Parameters.AddWithValue("@user", username);
            //     conn.Open();
            //     var storedHash = cmd.ExecuteScalar()?.ToString();
            //     return VerifyPassword(password, storedHash);
            // }

            // 临时测试账号
            return username == "admin" && password == "P@ssw0rd";
        }

        private void ShowError(string message)
        {
            pnlError.Visible = true;
            litErrorMessage.Text = message;
        }
    }
}