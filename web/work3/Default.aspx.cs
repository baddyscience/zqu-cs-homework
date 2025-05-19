using System;

namespace RandomNumberGenerator
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 初始化代码可以写在这里
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            // 创建Random实例
            Random rand = new Random();

            // 生成1-100之间的随机数
            int randomNumber = rand.Next(1, 101);

            // 显示结果
            lblResult.Text = $"生成的随机数是：{randomNumber}";
        }
    }
}