<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RandomGenerator.aspx.cs" 
    Inherits="YourNamespace.RandomGenerator" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>高级随机数生成器</title>
    <style>
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            font-family: 'Segoe UI', sans-serif;
        }
        .input-group {
            margin: 15px 0;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 10px;
        }
        .input-box {
            padding: 8px;
            border: 2px solid #007bff;
            border-radius: 4px;
            font-size: 16px;
        }
        .btn-generate {
            background: #007bff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .btn-generate:hover {
            background: #0056b3;
        }
        .result-panel {
            margin-top: 20px;
            padding: 15px;
            background: #e9f5ff;
            border-radius: 4px;
        }
        .history-grid {
            margin-top: 20px;
            width: 100%;
            border-collapse: collapse;
        }
        .history-grid th, .history-grid td {
            padding: 10px;
            border: 1px solid #dee2e6;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>高级随机数生成器</h2>
            
            <div class="input-group">
                <asp:TextBox ID="txtMin" runat="server" CssClass="input-box" 
                    placeholder="最小值" Text="1"></asp:TextBox>
                
                <asp:TextBox ID="txtMax" runat="server" CssClass="input-box" 
                    placeholder="最大值" Text="100"></asp:TextBox>
                
                <asp:DropDownList ID="ddlType" runat="server" CssClass="input-box">
                    <asp:ListItem Text="整数" Value="int" Selected="True" />
                    <asp:ListItem Text="小数" Value="double" />
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnGenerate" runat="server" Text="生成随机数" 
                CssClass="btn-generate" OnClick="btnGenerate_Click"/>
            
            <asp:Panel ID="pnlResult" runat="server" CssClass="result-panel">
                <asp:Label ID="lblResult" runat="server" Font-Bold="true" Font-Size="18px"/>
                <br/>
                <asp:Label ID="lblError" runat="server" ForeColor="Red"/>
            </asp:Panel>

            <asp:GridView ID="gvHistory" runat="server" CssClass="history-grid" 
                AutoGenerateColumns="false" Visible="false">
                <Columns>
                    <asp:BoundField DataField="Timestamp" HeaderText="生成时间" />
                    <asp:BoundField DataField="Type" HeaderText="类型" />
                    <asp:BoundField DataField="Range" HeaderText="范围" />
                    <asp:BoundField DataField="Value" HeaderText="生成值" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>