<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RandomNumberGenerator._Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>随机数生成器</title>
    <style>
        .container {
            text-align: center;
            margin-top: 100px;
            font-family: Arial, sans-serif;
        }
        .result {
            font-size: 24px;
            color: #2c3e50;
            margin: 20px;
            padding: 15px;
            border: 2px solid #3498db;
            border-radius: 5px;
            display: inline-block;
            min-width: 200px;
        }
        .generate-btn {
            padding: 12px 24px;
            font-size: 18px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .generate-btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>随机数生成器</h1>
            <asp:Button 
                ID="btnGenerate" 
                runat="server" 
                Text="生成随机数" 
                CssClass="generate-btn" 
                OnClick="btnGenerate_Click" />
            <asp:Label 
                ID="lblResult" 
                runat="server" 
                CssClass="result" 
                Text="" />
        </div>
    </form>
</body>
</html>