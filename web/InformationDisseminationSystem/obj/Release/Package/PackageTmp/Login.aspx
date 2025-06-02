<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebInfoSystem.Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>管理员登录 | 漫游篝火</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f8f9fa;
        }
        .card {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            border-radius: 0.5rem;
        }
        .card-header {
            background-color: #343a40;
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
            text-align: center;
            border-top-left-radius: 0.5rem;
            border-top-right-radius: 0.5rem;
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
            font-weight: 600;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
            border-color: #0a58ca;
        }
        .form-label {
            font-weight: 600;
        }
        #lblMessage {
            min-height: 1.5em;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="container mt-5">
        <div class="card col-md-4 offset-md-4">
            <div class="card-header">
                管理员登录
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label" for="<%= txtUsername.ClientID %>">用户名</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label class="form-label" for="<%= txtPassword.ClientID %>">密码</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" />
                </div>
                <asp:Button ID="btnLogin" runat="server" Text="登录" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-2 d-block" />
            </div>
        </div>
    </form>
</body>
</html>
