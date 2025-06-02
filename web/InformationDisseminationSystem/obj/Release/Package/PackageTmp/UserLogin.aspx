<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="WebInfoSystem.UserLogin" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>用户登录 | 漫游篝火</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
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
                    <asp:HyperLink ID="hlBack" runat="server" NavigateUrl="Index.aspx" CssClass="btn btn-sm btn-outline-light">返回首页</asp:HyperLink>
                </div>
            </div>
        </nav>

        <!-- 登录卡片 -->
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    用户登录
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">用户名：</label>
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">密码：</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>

                    <div class="mb-3">
                        <asp:Button ID="btnLogin" runat="server" Text="登录" CssClass="btn btn-success me-2" OnClick="btnLogin_Click" />
                        <a href="Register.aspx" class="btn btn-outline-primary me-2">注册</a>
                        <a href="Login.aspx" class="btn btn-outline-secondary">管理员登录</a>
                    </div>

                    <asp:Label ID="lblMsg" runat="server" CssClass="text-danger fw-semibold" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
