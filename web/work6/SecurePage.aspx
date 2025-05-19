<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SecurePage.aspx.cs" Inherits="YourNamespace.SecurePage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>安全页面</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>欢迎, <%= User.Identity.Name %>!</h1>
            <asp:Button 
                ID="btnLogout" 
                runat="server" 
                Text="退出登录" 
                OnClick="btnLogout_Click"/>
        </div>
    </form>
</body>
</html>