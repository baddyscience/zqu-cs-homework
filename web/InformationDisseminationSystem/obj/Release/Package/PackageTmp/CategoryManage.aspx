<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CategoryManage.aspx.cs" Inherits="WebInfoSystem.CategoryManage" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>栏目管理 | 漫游篝火</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f8f9fa;
        }

        .navbar-custom {
            background-color: #343a40;
        }

        .card-header {
            font-size: 1.25rem;
            font-weight: bold;
        }

        .table th {
            background-color: #e9ecef;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- 顶部导航栏 -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">漫游篝火</a>
                <div class="ms-auto">
                    <asp:HyperLink ID="hlBack" runat="server" NavigateUrl="AdminDashboard.aspx" CssClass="btn btn-sm btn-outline-light">返回后台</asp:HyperLink>
                </div>
            </div>
        </nav>

        <!-- 主内容区 -->
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-info text-white">
                    栏目管理
                </div>
                <div class="card-body">
                    <div class="mb-4 d-flex align-items-center">
                        <asp:TextBox ID="txtNewCategory" runat="server" CssClass="form-control me-2" placeholder="请输入栏目名称" />
                        <asp:Button ID="btnAddCategory" runat="server" Text="添加栏目" CssClass="btn btn-primary" OnClick="btnAddCategory_Click" />
                    </div>

                    <asp:GridView ID="gvCategory" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-bordered table-hover bg-white" DataKeyNames="CategoryID"
                        OnRowEditing="gvCategory_RowEditing"
                        OnRowCancelingEdit="gvCategory_RowCancelingEdit"
                        OnRowUpdating="gvCategory_RowUpdating"
                        OnRowDeleting="gvCategory_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="CategoryID" HeaderText="ID" ReadOnly="True" />
                            <asp:BoundField DataField="CategoryName" HeaderText="栏目名称" />
                            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
