using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CustomDemo
{
    public partial class _Default : System.Web.UI.Page
    {
        private DataAccess db = new DataAccess();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInitialData();
            }
        }

        private void LoadInitialData()
        {
            // 绑定部门下拉框
            ddlDepartments.DataSource = db.GetDepartments();
            ddlDepartments.DataBind();

            // 绑定部门表格
            gvDepartments.DataSource = db.GetDepartments();
            gvDepartments.DataBind();

            // 绑定客户表格
            gvCustomers.DataSource = db.GetCustomersWithDepartments();
            gvCustomers.DataBind();
        }

        // 添加客户
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCName.Text))
            {
                ShowMessage("客户名称不能为空");
                return;
            }

            var parameters = new SqlParameter[] {
                new SqlParameter("@cname", txtCName.Text.Trim()),
                new SqlParameter("@departID", ddlDepartments.SelectedValue)
            };

            try
            {
                db.ExecuteNonQuery(
                    "INSERT INTO custom (cname, departID) VALUES (@cname, @departID)",
                    parameters
                );
                txtCName.Text = "";
                LoadInitialData();
            }
            catch (SqlException ex)
            {
                ShowMessage($"操作失败：{ex.Message}");
            }
        }

        // 部门表格编辑
        protected void gvDepartments_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDepartments.EditIndex = e.NewEditIndex;
            LoadInitialData();
        }

        protected void gvDepartments_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDepartments.EditIndex = -1;
            LoadInitialData();
        }

        protected void gvDepartments_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvDepartments.Rows[e.RowIndex];
            int id = Convert.ToInt32(gvDepartments.DataKeys[e.RowIndex].Value);

            var parameters = new SqlParameter[] {
                new SqlParameter("@name", ((TextBox)row.FindControl("txtDepartName")).Text),
                new SqlParameter("@desc", ((TextBox)row.FindControl("txtDescription")).Text),
                new SqlParameter("@id", id)
            };

            db.ExecuteNonQuery(
                "UPDATE department SET departname=@name, description=@desc WHERE id=@id",
                parameters
            );
            gvDepartments.EditIndex = -1;
            LoadInitialData();
        }

        protected void gvDepartments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvDepartments.DataKeys[e.RowIndex].Value);
            db.ExecuteNonQuery("DELETE FROM department WHERE id=@id",
                new SqlParameter[] { new SqlParameter("@id", id) });
            LoadInitialData();
        }

        // 客户表格编辑
        protected void gvCustomers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCustomers.EditIndex = e.NewEditIndex;
            LoadInitialData();
        }

        protected void gvCustomers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCustomers.EditIndex = -1;
            LoadInitialData();
        }

        protected void gvCustomers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvCustomers.Rows[e.RowIndex];
            int id = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value);

            var parameters = new SqlParameter[] {
                new SqlParameter("@cname", ((TextBox)row.FindControl("txtEditCName")).Text),
                new SqlParameter("@departID", ((DropDownList)row.FindControl("ddlEditDepart")).SelectedValue),
                new SqlParameter("@id", id)
            };

            db.ExecuteNonQuery(
                "UPDATE custom SET cname=@cname, departID=@departID WHERE id=@id",
                parameters
            );
            gvCustomers.EditIndex = -1;
            LoadInitialData();
        }

        protected void gvCustomers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value);
            db.ExecuteNonQuery("DELETE FROM custom WHERE id=@id",
                new SqlParameter[] { new SqlParameter("@id", id) });
            LoadInitialData();
        }

        private void ShowMessage(string msg)
        {
            ClientScript.RegisterStartupScript(
                GetType(),
                "alert",
                $"alert('{msg.Replace("'", "\\'")}');",
                true
            );
        }
    }

    public class DataAccess
    {
        private string connStr;

        public DataAccess()
        {
            var conn = System.Configuration.ConfigurationManager.ConnectionStrings["DBConn"];
            if (conn == null || string.IsNullOrEmpty(conn.ConnectionString))
            {
                throw new ApplicationException("数据库连接配置错误");
            }
            connStr = conn.ConnectionString;
        }

        public DataTable GetDepartments()
        {
            return ExecuteQuery("SELECT id, departname, description FROM department");
        }

        public DataTable GetCustomersWithDepartments()
        {
            return ExecuteQuery(@"
                SELECT c.id, c.cname, c.departID, d.departname 
                FROM custom c 
                LEFT JOIN department d ON c.departID = d.id
            ");
        }

        public int ExecuteNonQuery(string sql, SqlParameter[] parameters = null)
        {
            using (var conn = new SqlConnection(connStr))
            using (var cmd = new SqlCommand(sql, conn))
            {
                conn.Open();
                if (parameters != null) cmd.Parameters.AddRange(parameters);
                return cmd.ExecuteNonQuery();
            }
        }

        public DataTable ExecuteQuery(string sql, SqlParameter[] parameters = null)
        {
            using (var conn = new SqlConnection(connStr))
            using (var cmd = new SqlCommand(sql, conn))
            {
                if (parameters != null) cmd.Parameters.AddRange(parameters);
                conn.Open();
                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());
                return dt;
            }
        }
    }
}