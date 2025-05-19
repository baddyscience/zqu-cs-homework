<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InfoCollector.aspx.cs" Inherits="YourProject.InfoCollector" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>用户信息收集</title>
    <style>
        .form-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: Segoe UI;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-submit {
            background: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-submit:hover {
            background: #45a049;
        }
        .result-panel {
            margin-top: 20px;
            padding: 15px;
            background: #f0f0f0;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">
            <h2>用户信息登记表</h2>
            
            <!-- 姓名输入 -->
            <div class="form-group">
                <asp:Label CssClass="form-label" runat="server" Text="姓名（必填）"/>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"/>
                <asp:RequiredFieldValidator 
                    runat="server" 
                    ControlToValidate="txtName"
                    ErrorMessage="姓名不能为空"
                    ForeColor="Red"
                    Display="Dynamic"/>
            </div>

            <!-- 邮箱输入 -->
            <div class="form-group">
                <asp:Label CssClass="form-label" runat="server" Text="电子邮箱"/>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"/>
                <asp:RegularExpressionValidator 
                    runat="server" 
                    ControlToValidate="txtEmail"
                    ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                    ErrorMessage="邮箱格式不正确"
                    ForeColor="Red"
                    Display="Dynamic"/>
            </div>

            <!-- 年龄输入 -->
            <div class="form-group">
                <asp:Label CssClass="form-label" runat="server" Text="年龄"/>
                <asp:TextBox ID="txtAge" runat="server" CssClass="form-control" TextMode="Number"/>
                <asp:RangeValidator 
                    runat="server" 
                    ControlToValidate="txtAge"
                    Type="Integer"
                    MinimumValue="0" 
                    MaximumValue="150"
                    ErrorMessage="请输入0-150之间的数字"
                    ForeColor="Red"
                    Display="Dynamic"/>
            </div>

            <!-- 性别选择 -->
            <div class="form-group">
                <asp:Label CssClass="form-label" runat="server" Text="性别"/>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                    <asp:ListItem Text="请选择" Value=""/>
                    <asp:ListItem Text="男" Value="M"/>
                    <asp:ListItem Text="女" Value="F"/>
                </asp:DropDownList>
            </div>

            <!-- 提交按钮 -->
            <asp:Button 
                ID="btnSubmit" 
                runat="server" 
                Text="提交信息" 
                CssClass="btn-submit" 
                OnClick="btnSubmit_Click"/>

            <!-- 结果显示面板 -->
            <asp:Panel 
                ID="pnlResult" 
                runat="server" 
                CssClass="result-panel" 
                Visible="false">
                <h3>提交结果：</h3>
                <asp:Literal ID="litResult" runat="server"/>
            </asp:Panel>
        </div>
    </form>
</body>
</html>