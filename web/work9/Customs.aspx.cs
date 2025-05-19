using System;
using System.Linq;
using System.Web.UI.WebControls;
using System.Data.Entity;

namespace EFWebApp.Pages
{
    public partial class Customs : System.Web.UI.Page
    {
        private readonly CustomService _customService = new CustomService();
        private readonly DepartmentService _departmentService = new DepartmentService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindDepartments();
                BindCustomers();
            }
        }

        private void BindDepartments()
        {
            ddlDepartments.DataSource = _departmentService.GetAll();
            ddlDepartments.DataBind();
            ddlDepartments.Items.Insert(0, new ListItem("-- 选择部门 --", ""));
        }

        private void BindCustomers()
        {
            gvCustomers.DataSource = _customService.GetAllWithDepartments();
            gvCustomers.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            var custom = new Custom
            {
                CName = txtCName.Text.Trim(),
                DepartmentId = int.Parse(ddlDepartments.SelectedValue),
                Age = null, // 根据需求初始化其他字段
                EName = "",
                Password = ""
            };

            _customService.Create(custom);
            BindCustomers();
            ClearForm();
        }

        // GridView事件处理
        protected void gvCustomers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCustomers.EditIndex = e.NewEditIndex;
            BindCustomers();
        }

        protected void gvCustomers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int rowIndex = e.RowIndex;
            var row = gvCustomers.Rows[rowIndex];
            int id = Convert.ToInt32(gvCustomers.DataKeys[rowIndex].Value);

            var custom = _customService.GetById(id);
            custom.CName = ((TextBox)row.FindControl("txtEditCName")).Text;
            custom.DepartmentId = int.Parse(
                ((DropDownList)row.FindControl("ddlEditDepartment")).SelectedValue);
            custom.Age = int.TryParse(
                ((TextBox)row.FindControl("txtEditAge")).Text, out int age)
                ? age
                : (int?)null;

            _customService.Update(custom);
            gvCustomers.EditIndex = -1;
            BindCustomers();
        }

        protected void gvCustomers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value);
            _customService.Delete(id);
            BindCustomers();
        }

        protected void gvCustomers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCustomers.EditIndex = -1;
            BindCustomers();
        }

        private void ClearForm()
        {
            txtCName.Text = string.Empty;
            ddlDepartments.SelectedIndex = 0;
        }
    }
}