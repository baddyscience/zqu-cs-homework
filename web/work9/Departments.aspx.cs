// Pages/Departments.aspx.cs
using NLog;
using System;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;

namespace EFWebApp.Pages
{
    public partial class Departments : System.Web.UI.Page
    {
        private readonly DepartmentService _service = new DepartmentService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindGrid();
        }

        private void ClearForm()
        {
            
        }

        private void BindGrid()
        {
            var data = _service.GetAll();
            gvDepartments.DataSource = data;
            gvDepartments.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            var department = new Department
            {
                DepartName = txtName.Text.Trim(),
                Description = txtDesc.Text.Trim()
            };

            _service.Create(department);
            BindGrid();
            ClearForm();
        }

        protected void gvDepartments_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvDepartments.Rows[e.RowIndex];
            int id = Convert.ToInt32(gvDepartments.DataKeys[e.RowIndex].Value);

            var txtEditName = (TextBox)row.FindControl("txtEditName");
            var txtEditDesc = (TextBox)row.FindControl("txtEditDesc");

            var department = _service.GetById(id);
            department.DepartName = txtEditName.Text;
            department.Description = txtEditDesc.Text;

            _service.Update(department);
            gvDepartments.EditIndex = -1;
            BindGrid();
        }

        protected void Page_Error(object sender, EventArgs e)
        {
     
            Server.ClearError();
            Response.Redirect("~/ErrorPage.aspx?msg=");
        }
    }
}