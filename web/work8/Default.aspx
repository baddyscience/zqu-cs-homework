<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CustomDemo._Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>数据管理系统</title>
    <style>
        .gridview { margin: 20px 0; border-collapse: collapse; width: 100%; }
        .gridview th, .gridview td { padding: 8px; border: 1px solid #ddd; }
        .form-panel { padding: 15px; background: #f5f5f5; margin: 20px 0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <!-- 部门管理 -->
            <h2>部门管理</h2>
            <asp:GridView 
                ID="gvDepartments" 
                runat="server" 
                CssClass="gridview"
                AutoGenerateColumns="False"
                DataKeyNames="id"
                OnRowEditing="gvDepartments_RowEditing"
                OnRowCancelingEdit="gvDepartments_RowCancelingEdit"
                OnRowUpdating="gvDepartments_RowUpdating"
                OnRowDeleting="gvDepartments_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="true"/>
                    <asp:TemplateField HeaderText="部门名称">
                        <ItemTemplate><%# Eval("departname") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDepartName" runat="server" 
                                Text='<%# Bind("departname") %>'/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="部门描述">
                        <ItemTemplate><%# Eval("description") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescription" runat="server" 
                                Text='<%# Bind("description") %>'/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>

            <!-- 客户管理 -->
            <h2>客户管理</h2>
            <div class="form-panel">
                <asp:TextBox ID="txtCName" runat="server" placeholder="客户名称"/>
                <asp:DropDownList ID="ddlDepartments" runat="server" 
                    DataTextField="departname" DataValueField="id"/>
                <asp:Button ID="btnAdd" runat="server" Text="添加客户" 
                    OnClick="btnAdd_Click" CssClass="btn"/>
            </div>
            
            <asp:GridView 
                ID="gvCustomers" 
                runat="server" 
                CssClass="gridview"
                AutoGenerateColumns="False"
                DataKeyNames="id"
                OnRowEditing="gvCustomers_RowEditing"
                OnRowCancelingEdit="gvCustomers_RowCancelingEdit"
                OnRowUpdating="gvCustomers_RowUpdating"
                OnRowDeleting="gvCustomers_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="id" HeaderText="ID" ReadOnly="true"/>
                    <asp:TemplateField HeaderText="客户名称">
                        <ItemTemplate><%# Eval("cname") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditCName" runat="server" 
                                Text='<%# Bind("cname") %>'/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="所属部门">
                        <ItemTemplate><%# Eval("departname") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditDepart" runat="server" 
                                DataSourceID="sqlDepartments"
                                DataTextField="departname" 
                                DataValueField="id"
                                SelectedValue='<%# Bind("departID") %>'/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>

            <!-- 部门数据源 -->
            <asp:SqlDataSource 
                ID="sqlDepartments" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:DBConn %>"
                SelectCommand="SELECT id, departname FROM department"/>
        </div>
    </form>
</body>
</html>