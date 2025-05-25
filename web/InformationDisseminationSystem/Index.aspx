<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebInfoSystem.Index" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>信息浏览 | 漫游篝火</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: #f8f9fa;
        }

        .navbar-custom {
            background-color: #343a40;
        }

        .post-card {
            transition: box-shadow 0.3s ease;
        }

        .post-card:hover {
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }

        .comment-box {
            background-color: #f1f3f5;
            border-left: 4px solid #0d6efd;
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
        <div class="ms-auto d-flex align-items-center">
            <asp:Label ID="lblWelcome" runat="server" CssClass="me-3 text-white fw-semibold" />
            <asp:LinkButton ID="lnkLogout" runat="server" Text="退出" OnClick="lnkLogout_Click" CssClass="btn btn-sm btn-outline-light" />
            <asp:HyperLink ID="loginLink" runat="server" NavigateUrl="Userlogin.aspx" CssClass="btn btn-sm btn-outline-light ms-2">登录</asp:HyperLink>
        </div>
    </div>
</nav>

        <div class="container">
       

            <div class="card shadow-sm">
                <div class="card-body">
                    <div class="mb-4">
                        <label class="form-label fw-semibold">筛选栏目：</label>
                        <asp:DropDownList ID="ddlFilterCategory" runat="server" CssClass="form-select w-auto d-inline-block" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterCategory_SelectedIndexChanged" />
                    </div>

                    <asp:Repeater ID="rptPosts" runat="server">
                        <ItemTemplate>
                            <div class="card mb-4 post-card">
                                <div class="card-body">
                                    <h5 class="card-title"><%# Eval("Title") %></h5>
                                    <p class="card-subtitle mb-2 text-muted">栏目：<%# Eval("CategoryName") %></p>
                                    <p class="card-text"><%# Eval("Content") %></p>
                                    <a href='CommentSubmit.aspx?postid=<%# Eval("PostID") %>' class="btn btn-outline-primary btn-sm">我要留言</a>

                                    <asp:Repeater ID="rptComments" runat="server" DataSource='<%# GetComments(Eval("PostID")) %>'>
                                        <HeaderTemplate>
                                            <hr />
                                            <h6 class="text-secondary mt-3">留言：</h6>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <div class="p-2 my-2 rounded comment-box">
                                                <strong class="text-dark"><%# Eval("Username") %>:</strong>
                                                <p class="mb-1"><%# Eval("Content") %></p>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </form>

</body>
</html>
