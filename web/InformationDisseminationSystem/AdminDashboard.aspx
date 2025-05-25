<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="WebInfoSystem.AdminDashboard" %>
<!DOCTYPE html>
<html>
<body>
    <head runat="server">
    <title>管理员后台 | 漫游篝火</title>
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
    <form id="form1" runat="server">
        <!-- 顶部导航栏 -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">漫游篝火</a>
                <div class="ms-auto">
                    <asp:Label ID="lblAdmin" runat="server" CssClass="me-3 text-white fw-semibold" Text="管理员" />
                    <asp:Button ID="btnLogoutTop" runat="server" Text="退出" CssClass="btn btn-sm btn-outline-light" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <!-- 主内容区 -->
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    欢迎，管理员！
                </div>
                <div class="card-body">
                    <p class="mb-4">使用下列链接管理信息发布系统：</p>
                    <ul class="list-group">
                        <li class="list-group-item border-0 px-0 mb-2">
                            <a href="CategoryManage.aspx" class="btn btn-outline-primary w-100">栏目管理</a>
                        </li>
                        <li class="list-group-item border-0 px-0 mb-2">
                            <a href="PostManage.aspx" class="btn btn-outline-success w-100">信息管理</a>
                        </li>
                        <li class="list-group-item border-0 px-0 mb-2">
                            <a href="CommentApprove.aspx" class="btn btn-outline-success w-100">留言管理</a>
                        </li>
                        <li class="list-group-item border-0 px-0">
                            <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-outline-danger w-100" Text="退出登录" OnClick="btnLogout_Click" />
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
