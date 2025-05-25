<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommentSubmit.aspx.cs" Inherits="WebInfoSystem.CommentSubmit" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>提交留言 | 漫游篝火</title>
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
                    <asp:HyperLink ID="hlBackHome" runat="server" NavigateUrl="Index.aspx" CssClass="btn btn-sm btn-outline-light">返回首页</asp:HyperLink>
                </div>
            </div>
        </nav>

        <!-- 留言卡片 -->
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    留言
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">留言内容：</label>
                        <asp:TextBox ID="txtComment" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" />
                    </div>
                    <asp:Button ID="btnSubmit" runat="server" Text="提交" CssClass="btn btn-success" OnClick="btnSubmit_Click" />
                    <asp:Label ID="lblMsg" runat="server" CssClass="d-block mt-3 fw-semibold text-success" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
