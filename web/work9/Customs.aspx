<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customs.aspx.cs" 
    Inherits="EFWebApp.Pages.Customs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>客户管理</title>
    <style>
        .gridview { margin: 20px 0; border-collapse: collapse; width: 100%; }
        .form-panel { padding: 15px; background: #f5f5f5; margin: 20px 0; }
        .form-group { margin-bottom: 15px; }
        .validation-error { color: red; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>客户管理</h2>
            
            <!-- 新增客户表单 -->
            <div class="form-panel">
                <div class="form-group">
                    <asp:Label AssociatedControlID="txtCName" Text="客户名称：" runat="server"/>
                    <asp:TextBox ID="txtCName" runat="server" CssClass="form-control"/>
                    <asp:RequiredFieldValidator ID="rfvCName" runat="server" 
                        ControlToValidate="txtCName"
                        ErrorMessage="客户名称不能为空"
                        CssClass="validation-error"
                        Display="Dynamic"/>
                </div>
                
                <div class="form-group">
                    <asp:Label AssociatedControlID="ddlDepartments" Text="所属部门：" runat="server"/>
                    <asp:DropDownList ID="ddlDepartments" runat="server" 
                        DataTextField="DepartName" 
                        DataValueField="Id"
                        CssClass="form-control"/>
                </div>

                <div class="form-group">
                    <asp:Button ID="btnAdd" runat="server" Text="新增客户" 
                        OnClick="btnAdd_Click" CssClass="btn btn-primary"/>
                </div>
            </div>

            <!-- 客户列表 -->
            <asp:GridView ID="gvCustomers" runat="server" CssClass="gridview"
                AutoGenerateColumns="False" DataKeyNames="Id"
                OnRowEditing="gvCustomers_RowEditing"
                OnRowCancelingEdit="gvCustomers_RowCancelingEdit"
                OnRowUpdating="gvCustomers_RowUpdating"
                OnRowDeleting="gvCustomers_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="ID" ReadOnly="true"/>
                    <asp:TemplateField HeaderText="客户名称">
                        <ItemTemplate><%# Eval("CName") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditCName" runat="server" 
                                Text='<%# Bind("CName") %>'
                                CssClass="form-control"/>
                            <asp:RequiredFieldValidator runat="server" 
                                ControlToValidate="txtEditCName"
                                ErrorMessage="不能为空"
                                CssClass="validation-error"
                                Display="Dynamic"/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="所属部门">
                        <ItemTemplate><%# Eval("Department.DepartName") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditDepartment" runat="server" 
                                DataSourceID="sqlDepartments"
                                DataTextField="DepartName" 
                                DataValueField="Id"
                                SelectedValue='<%# Bind("DepartmentId") %>'
                                CssClass="form-control"/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="年龄">
                        <ItemTemplate><%# Eval("Age") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditAge" runat="server" 
                                Text='<%# Bind("Age") %>'
                                TextMode="Number"
                                CssClass="form-control"/>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" 
                        ControlStyle-CssClass="btn btn-sm"/>
                </Columns>
            </asp:GridView>

            <!-- 部门数据源 -->
            <asp:SqlDataSource ID="sqlDepartments" runat="server" 
                ConnectionString="<%$ ConnectionStrings:AppConn %>"
                SelectCommand="SELECT Id, DepartName FROM Departments"/>
        </div>
    </form>
</body>
</html>