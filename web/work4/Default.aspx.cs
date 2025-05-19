using System;
using System.Collections.Generic;
using System.Web.UI;

namespace YourNamespace
{
    public partial class RandomGenerator : System.Web.UI.Page
    {
        private List<RandomHistory> History
        {
            get => (List<RandomHistory>)(ViewState["History"] ??
                   (ViewState["History"] = new List<RandomHistory>()));
            set => ViewState["History"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindHistoryGrid();
            }
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidateInput()) return;

                var result = GenerateRandom();
                DisplayResult(result);
                AddToHistory(result);
                BindHistoryGrid();
            }
            catch (Exception ex)
            {
                lblError.Text = $"错误：{ex.Message}";
            }
        }

        private bool ValidateInput()
        {
            if (!double.TryParse(txtMin.Text, out double min) ||
                !double.TryParse(txtMax.Text, out double max))
            {
                lblError.Text = "请输入有效的数字";
                return false;
            }

            if (min >= max)
            {
                lblError.Text = "最大值必须大于最小值";
                return false;
            }

            return true;
        }

        private double GenerateRandom()
        {
            var rand = new Random();
            double min = Convert.ToDouble(txtMin.Text);
            double max = Convert.ToDouble(txtMax.Text);

            if (ddlType.SelectedValue == "int")
            {
                return rand.Next((int)min, (int)max + 1);
            }

            return rand.NextDouble() * (max - min) + min;
        }

        private void DisplayResult(double result)
        {
            lblResult.Text = ddlType.SelectedValue == "int"
                ? $"生成的随机整数：{result}"
                : $"生成的随机小数：{result:F4}";

            lblError.Text = "";
            pnlResult.Visible = true;
        }

        private void AddToHistory(double result)
        {
            History.Insert(0, new RandomHistory
            {
                Timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"),
                Type = ddlType.SelectedValue.ToUpper(),
                Range = $"{txtMin.Text} - {txtMax.Text}",
                Value = result.ToString(ddlType.SelectedValue == "int" ? "0" : "F4")
            });

            // 保持最多10条记录
            if (History.Count > 10) History.RemoveAt(History.Count - 1);
        }

        private void BindHistoryGrid()
        {
            gvHistory.DataSource = History;
            gvHistory.DataBind();
            gvHistory.Visible = History.Count > 0;
        }
    }
    [Serializable]
    public class RandomHistory
    {
        public string Timestamp { get; set; }
        public string Type { get; set; }
        public string Range { get; set; }
        public string Value { get; set; }
    }
}