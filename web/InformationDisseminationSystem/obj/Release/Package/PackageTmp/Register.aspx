<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebInfoSystem.Register" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>用户注册 | 漫游篝火</title>
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

        <!-- 注册卡片 -->
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    用户注册
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
                        <asp:Button ID="btnRegister" runat="server" Text="注册" CssClass="btn btn-primary me-2" OnClick="btnRegister_Click" />
                        <a href="UserLogin.aspx" class="btn btn-outline-secondary">已有账号？去登录</a>
                    </div>

                    <asp:Label ID="lblMsg" runat="server" CssClass="fw-semibold text-success" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
