<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="StudentInfoSystem.Students" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>学生信息管理</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>添加新学生</h2>
            <asp:TextBox ID="txtName" runat="server" placeholder="姓名"></asp:TextBox>
            <asp:TextBox ID="txtAge" runat="server" placeholder="年龄" TextMode="Number"></asp:TextBox>
            <asp:TextBox ID="txtEmail" runat="server" placeholder="邮箱" TextMode="Email"></asp:TextBox>
            <asp:Button ID="btnAdd" runat="server" Text="添加" OnClick="btnAdd_Click" />
        </div>

        <hr />

        <div>
            <h2>学生列表</h2>
            <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="ID" OnRowEditing="gvStudents_RowEditing"
                OnRowUpdating="gvStudents_RowUpdating" OnRowCancelingEdit="gvStudents_RowCancelingEdit"
                OnRowDeleting="gvStudents_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="true" />
                    <asp:TemplateField HeaderText="姓名">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="年龄">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditAge" runat="server" Text='<%# Bind("Age") %>' TextMode="Number"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="邮箱">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditEmail" runat="server" Text='<%# Bind("Email") %>' TextMode="Email"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>