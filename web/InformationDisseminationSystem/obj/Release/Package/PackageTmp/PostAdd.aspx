<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PostAdd.aspx.cs" Inherits="WebInfoSystem.PostAdd" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>添加信息 | 漫游篝火</title>
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
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">漫游篝火</a>
                <div class="ms-auto">
                    <asp:HyperLink ID="hlBack" runat="server" NavigateUrl="AdminDashboard.aspx" CssClass="btn btn-sm btn-outline-light">返回后台</asp:HyperLink>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    添加信息
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">标题：</label>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">内容：</label>
                        <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">栏目：</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select" />
                    </div>
                    <div class="d-flex justify-content-between">
                        <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn btn-success" OnClick="btnSave_Click" />
                        <asp:HyperLink ID="hlBackToList" runat="server" NavigateUrl="PostManage.aspx" CssClass="btn btn-outline-secondary">返回信息管理</asp:HyperLink>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
