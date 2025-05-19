using System;
using System.Web.UI;

namespace YourProject
{
    public partial class InfoCollector : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 页面初始化代码
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid) // 确保所有验证通过
            {
                try
                {
                    // 收集表单数据
                    var userInfo = new
                    {
                        Name = txtName.Text.Trim(),
                        Email = txtEmail.Text.Trim(),
                        Age = txtAge.Text,
                        Gender = ddlGender.SelectedValue
                    };

                    // 构建显示内容
                    string resultContent = $@"
                        <p><strong>姓名：</strong>{userInfo.Name}</p>
                        <p><strong>邮箱：</strong>{userInfo.Email}</p>
                        <p><strong>年龄：</strong>{GetAgeDisplay(userInfo.Age)}</p>
                        <p><strong>性别：</strong>{GetGenderDisplay(userInfo.Gender)}</p>
                        <p class='text-success'>提交时间：{DateTime.Now:yyyy-MM-dd HH:mm:ss}</p>
                    ";

                    // 显示结果
                    litResult.Text = resultContent;
                    pnlResult.Visible = true;
                }
                catch (Exception ex)
                {
                    ShowError("系统错误，请稍后再试");
                }
            }
        }

        private string GetAgeDisplay(string age)
        {
            return string.IsNullOrEmpty(age) ? "未填写" : $"{age} 岁";
        }

        private string GetGenderDisplay(string code)
        {
            return code;
        } 

        private void ShowError(string message)
        {
            pnlResult.Visible = true;
            litResult.Text = $"<p class='text-danger'>{message}</p>";
        }
    }
}