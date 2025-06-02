<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostManage.aspx.cs" Inherits="WebInfoSystem.PostManage" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>信息管理 | 漫游篝火</title>
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- 顶部导航 -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">漫游篝火</a>
                <div class="ms-auto">
                    <asp:HyperLink ID="hlBack" runat="server" NavigateUrl="AdminDashboard.aspx" CssClass="btn btn-sm btn-outline-light">返回后台</asp:HyperLink>
                </div>
            </div>
        </nav>

        <!-- 主体内容 -->
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    信息管理
                </div>
                <div class="card-body">
                    <asp:Button ID="btnAddPost" runat="server" Text="添加信息" CssClass="btn btn-primary mb-3" OnClick="btnAddPost_Click" />

                    <asp:GridView ID="gvPosts" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover" DataKeyNames="PostID"
                        OnRowDeleting="gvPosts_RowDeleting" OnRowEditing="gvPosts_RowEditing">
                        <Columns>
                            <asp:BoundField DataField="PostID" HeaderText="ID" ReadOnly="True" />
                            <asp:BoundField DataField="Title" HeaderText="标题" />
                            <asp:BoundField DataField="CategoryName" HeaderText="所属栏目" />
                            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
