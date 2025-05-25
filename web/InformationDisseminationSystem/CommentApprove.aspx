<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommentApprove.aspx.cs" Inherits="WebInfoSystem.CommentApprove" %>
<!DOCTYPE html>
<html>
<head>
    <title>留言审核 | 漫游篝火</title>
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
        <!-- 顶部导航 -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
            <div class="container">
                <a class="navbar-brand fw-bold" href="#">漫游篝火</a>
                <div class="ms-auto">
                    <asp:HyperLink ID="hlBackToAdmin" runat="server" NavigateUrl="AdminDashboard.aspx" CssClass="btn btn-sm btn-outline-light">返回后台</asp:HyperLink>
                </div>
            </div>
        </nav>

        <!-- 主内容区 -->
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header">
                    留言审核
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-bordered table-hover bg-white"
                        OnRowCommand="gvComments_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="CommentID" HeaderText="ID" />
                            <asp:BoundField DataField="Username" HeaderText="用户" />
                            <asp:BoundField DataField="Content" HeaderText="留言内容" />
                            <asp:TemplateField HeaderText="操作">
                                <ItemTemplate>
                                    <asp:Button ID="btnApprove" runat="server" Text="审核通过"
                                        CommandName="Approve" CommandArgument='<%# Eval("CommentID") %>'
                                        CssClass="btn btn-success btn-sm" />
                                    <asp:Button ID="btnReject" runat="server" Text="不通过"
                                        CommandName="Reject" CommandArgument='<%# Eval("CommentID") %>'
                                        CssClass="btn btn-danger btn-sm ms-2" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
