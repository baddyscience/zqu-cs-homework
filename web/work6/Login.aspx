<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="YourNamespace.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户登录</title>
    <style>
        .login-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .alert {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
        .alert-danger {
            background-color: #f8d7da;
            border-color: #f5c6cb;
            color: #721c24;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>用户登录</h2>
            
            <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger" Visible="false">
                <asp:Literal ID="litErrorMessage" runat="server"/>
            </asp:Panel>

            <div class="form-group">
                <asp:Label runat="server" Text="用户名"/>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"/>
                <asp:RequiredFieldValidator 
                    runat="server" 
                    ControlToValidate="txtUsername"
                    ErrorMessage="必须填写用户名"
                    ForeColor="Red"/>
            </div>

            <div class="form-group">
                <asp:Label runat="server" Text="密码"/>
                <asp:TextBox ID="txtPassword" runat="server" 
                    TextMode="Password" CssClass="form-control"/>
                <asp:RequiredFieldValidator 
                    runat="server" 
                    ControlToValidate="txtPassword"
                    ErrorMessage="必须填写密码"
                    ForeColor="Red"/>
            </div>

            <asp:Button 
                ID="btnLogin" 
                runat="server" 
                Text="登录" 
                CssClass="btn btn-primary"
                OnClick="btnLogin_Click"/>
        </div>
    </form>
</body>
</html>