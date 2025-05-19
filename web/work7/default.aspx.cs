using System;
using System.Data;
using System.Web.UI.WebControls;

namespace StudentInfoSystem
{
    public partial class Students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridView();
            }
        }

        private void BindGridView()
        {
            gvStudents.DataSource = DBHelper.GetStudents();
            gvStudents.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            DBHelper.InsertStudent(
                txtName.Text.Trim(),
                Convert.ToInt32(txtAge.Text),
                txtEmail.Text.Trim());
            BindGridView();
        }

        protected void gvStudents_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvStudents.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void gvStudents_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvStudents.Rows[e.RowIndex];
            int id = Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);

            string name = ((TextBox)row.FindControl("txtEditName")).Text;
            int age = Convert.ToInt32(((TextBox)row.FindControl("txtEditAge")).Text);
            string email = ((TextBox)row.FindControl("txtEditEmail")).Text;

            DBHelper.UpdateStudent(id, name, age, email);
            gvStudents.EditIndex = -1;
            BindGridView();
        }

        protected void gvStudents_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvStudents.EditIndex = -1;
            BindGridView();
        }

        protected void gvStudents_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvStudents.DataKeys[e.RowIndex].Value);
            DBHelper.DeleteStudent(id);
            BindGridView();
        }
    }
}