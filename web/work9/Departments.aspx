<%-- Pages/Departments.aspx --%>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Departments.aspx.cs" 
    Inherits="EFWebApp.Pages.Departments" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>部门管理</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>部门列表</h2>
            
            <%-- 新增部门 --%>
            <div class="form-group">
                <asp:TextBox ID="txtName" runat="server" placeholder="部门名称"/>
                <asp:TextBox ID="txtDesc" runat="server" placeholder="描述"/>
                <asp:Button ID="btnAdd" runat="server" Text="新增" OnClick="btnAdd_Click"/>
            </div>

            <%-- 部门表格 --%>
            <asp:GridView ID="gvDepartments" runat="server" 
                AutoGenerateColumns="false" DataKeyNames="Id"
                OnRowEditing="gvDepartments_RowEditing"
                OnRowCancelingEdit="gvDepartments_RowCancelingEdit"
                OnRowUpdating="gvDepartments_RowUpdating"
                OnRowDeleting="gvDepartments_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="true"/>
                    <asp:TemplateField HeaderText="部门名称">
                        <ItemTemplate><%# Eval("DepartName") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditName" runat="server" 
                                Text='<%# Bind("DepartName") %>'/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="描述">
                        <ItemTemplate><%# Eval("Description") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditDesc" runat="server" 
                                Text='<%# Bind("Description") %>'/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true"/>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>