<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PawMart.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <style>
        .login-container {
            max-width: 450px;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .login-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .login-header h2 {
            color: #FF6B35;
            margin-bottom: 10px;
        }

        .login-header p {
            color: #666;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #FF6B35;
            outline: none;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background-color: #FF6B35;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background-color: #e55a29;
            transform: translateY(-2px);
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
            font-size: 15px;
            color: #666;
        }

        .form-footer a {
            color: #FF6B35;
            text-decoration: none;
            font-weight: 500;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .validation-error {
            color: #dc3545;
            font-size: 14px;
            margin-top: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="login-container">
        <div class="login-header">
            <h2>Welcome Back!</h2>
            <p>Sign in to access your account</p>
        </div>

        <div class="form-group">
            <label for="txtEmail">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" TextMode="Email" required></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                ErrorMessage="Email is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter your password" TextMode="Password" required></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                ErrorMessage="Password is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <asp:CheckBox ID="chkRemember" runat="server" Text="Remember me" />
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn-login" OnClick="btnLogin_Click" />

        <asp:Label ID="lblErrorMessage" runat="server" CssClass="validation-error" Style="display: block; margin-top: 15px; text-align: center;"></asp:Label>

        <div class="form-footer">
<%--            <p>Forgot your password? <a href="ForgotPassword.aspx">Reset it here</a></p>--%>
            <p>Don't have an account? <a href="Register.aspx">Sign up</a></p>
        </div>
    </div>
</asp:Content>
