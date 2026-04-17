<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="PawMart.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <style>
        .register-container {
            max-width: 500px;
            margin: 40px auto;
            padding: 30px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .register-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .register-header h2 {
            color: #FF6B35;
            margin-bottom: 10px;
        }

        .register-header p {
            color: #666;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-row {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
        }

        .form-column {
            flex: 1;
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

        .btn-register {
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

        .btn-register:hover {
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

        .terms-checkbox {
            display: flex;
            align-items: flex-start;
            margin-top: 10px;
        }

        .terms-checkbox input[type="checkbox"] {
            margin-top: 3px;
            margin-right: 10px;
        }

        @media (max-width: 576px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="register-container">
        <div class="register-header">
            <h2>Create an Account</h2>
            <p>Join PawMart to order delicious food</p>
        </div>

        <div class="form-row">
            <div class="form-column">
                <div class="form-group">
                    <label for="txtFullName">First Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your first name" required></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFullName" 
                        ErrorMessage="First name is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
      
        </div>
              <div class="form-column">
         <div class="form-group">
             <label for="txtAddress">Address</label>
             <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter your address" required></asp:TextBox>
             <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" 
                 ErrorMessage="Address is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
         </div>
     </div>

        <div class="form-group">
            <label for="txtEmail">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" TextMode="Email" required></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                ErrorMessage="Email is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                ErrorMessage="Please enter a valid email" ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                CssClass="validation-error" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label for="txtPhone">Phone Number</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number" TextMode="Phone"></asp:TextBox>
        </div>

        <div class="form-row">
            <div class="form-column">
                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Create a password" TextMode="Password" required></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                        ErrorMessage="Password is required" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="Password must be at least 8 characters long and include one uppercase, one lowercase, and one number" 
                        ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"
                        CssClass="validation-error" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>
            <div class="form-column">
                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" placeholder="Confirm your password" TextMode="Password" required></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                        ErrorMessage="Please confirm your password" CssClass="validation-error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                        ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" 
                        CssClass="validation-error" Display="Dynamic"></asp:CompareValidator>
                </div>
            </div>
        </div>

        <div class="form-group terms-checkbox">
            <asp:CheckBox ID="chkTerms" runat="server" required />
            <label for="chkTerms">I agree to the <a href="#" target="_blank">Terms of Service</a> and <a href="#" target="_blank">Privacy Policy</a></label>
        </div>

        <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn-register" OnClick="btnRegister_Click" />

        <asp:Label ID="lblMessage" runat="server" CssClass="validation-error" Style="display: block; margin-top: 15px; text-align: center;"></asp:Label>

        <div class="form-footer">
            <p>Already have an account? <a href="Login.aspx">Sign in</a></p>
        </div>
    </div>
</asp:Content>
