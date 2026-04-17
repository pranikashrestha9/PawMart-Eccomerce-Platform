<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="ManageProfile.aspx.cs" Inherits="PawMart.ManageProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .profile-header {
            margin-bottom: 30px;
            text-align: center;
        }

        .profile-header h1 {
            color: #333;
            font-size: 28px;
            margin-bottom: 10px;
        }

        .profile-header p {
            color: #666;
            font-size: 16px;
        }

        .tab-container {
            margin-bottom: 30px;
        }

        .tab-buttons {
            display: flex;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .tab-button {
            padding: 12px 20px;
            background: none;
            border: none;
            border-bottom: 3px solid transparent;
            font-size: 16px;
            font-weight: 500;
            color: #666;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .tab-button:hover {
            color: #FF6B35;
        }

        .tab-button.active {
            color: #FF6B35;
            border-bottom-color: #FF6B35;
        }

        .tab-content {
            display: none;
        }

        .tab-content.active {
            display: block;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #FF6B35;
            outline: none;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background-color: #FF6B35;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn:hover {
            background-color: #e55a2a;
            transform: translateY(-2px);
        }

        .alert {
            padding: 12px 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .alert-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }

        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .password-requirements {
            margin-top: 10px;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 4px;
            font-size: 14px;
            color: #666;
        }

        .password-requirements ul {
            padding-left: 20px;
            margin: 5px 0 0;
        }

        .profile-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .profile-info p {
            margin: 8px 0;
            display: flex;
            justify-content: space-between;
        }

        .profile-info span.label {
            font-weight: 500;
            color: #555;
        }

        .profile-info span.value {
            color: #333;
        }

        @media (max-width: 768px) {
            .tab-buttons {
                flex-wrap: wrap;
            }

            .tab-button {
                flex: 1 1 50%;
                text-align: center;
                padding: 10px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="profile-container">
        <div class="profile-header">
            <h1>Manage Your Profile</h1>
            <p>Update your personal information and manage your account settings</p>
        </div>

        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="alert">
            <asp:Literal ID="litAlertMessage" runat="server"></asp:Literal>
        </asp:Panel>

        <div class="tab-container">
            <div class="tab-buttons">
                <button type="button" class="tab-button active" data-tab="profile">Profile Information</button>
                <button type="button" class="tab-button" data-tab="password">Change Password</button>
            </div>

            <div id="profileTab" class="tab-content active">
                <div class="profile-info">
                    <p>
                        <span class="label">Member Since:</span>
                        <span class="value">
                            <asp:Literal ID="litRegistrationDate" runat="server"></asp:Literal>
                        </span>
                    </p>
                    <p>
                        <span class="label">Email:</span>
                        <span class="value">
                            <asp:Literal ID="litEmail" runat="server"></asp:Literal>
                        </span>
                    </p>
                </div>

                <div class="form-group">
                    <label for="txtFullName">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName"
                        ErrorMessage="Full name is required" Display="Dynamic" CssClass="text-danger" ValidationGroup="ProfileUpdate"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label for="txtPhone">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                        ErrorMessage="Phone number is required" Display="Dynamic" CssClass="text-danger" ValidationGroup="ProfileUpdate"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone"
                        ErrorMessage="Please enter a valid phone number" Display="Dynamic" CssClass="text-danger"
                        ValidationExpression="^\d{10,15}$" ValidationGroup="ProfileUpdate"></asp:RegularExpressionValidator>
                </div>

                <div class="form-group">
                    <label for="txtAddress">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter your address"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                        ErrorMessage="Address is required" Display="Dynamic" CssClass="text-danger" ValidationGroup="ProfileUpdate"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" CssClass="btn" OnClick="btnUpdateProfile_Click" ValidationGroup="ProfileUpdate" />
                </div>
            </div>

            <div id="passwordTab" class="tab-content">
                <div class="form-group">
                    <label for="txtCurrentPassword">Current Password</label>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your current password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCurrentPassword" runat="server" ControlToValidate="txtCurrentPassword"
                        ErrorMessage="Current password is required" Display="Dynamic" CssClass="text-danger" ValidationGroup="PasswordUpdate"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label for="txtNewPassword">New Password</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your new password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword"
                        ErrorMessage="New password is required" Display="Dynamic" CssClass="text-danger" ValidationGroup="PasswordUpdate"></asp:RequiredFieldValidator>
                    
                    <div class="password-requirements">
                        <strong>Password Requirements:</strong>
                        <ul>
                            <li>At least 8 characters long</li>
                            <li>Include at least one uppercase letter</li>
                            <li>Include at least one lowercase letter</li>
                            <li>Include at least one number</li>
                            <li>Include at least one special character</li>
                        </ul>
                    </div>
                </div>

                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm New Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm your new password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                        ErrorMessage="Password confirmation is required" Display="Dynamic" CssClass="text-danger" ValidationGroup="PasswordUpdate"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvPasswordMatch" runat="server" ControlToValidate="txtConfirmPassword"
                        ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match" Display="Dynamic"
                        CssClass="text-danger" ValidationGroup="PasswordUpdate"></asp:CompareValidator>
                </div>

                <div class="form-group">
                    <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn" OnClick="btnChangePassword_Click" ValidationGroup="PasswordUpdate" />
                </div>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Tab navigation
            const tabButtons = document.querySelectorAll('.tab-button');
            const tabContents = document.querySelectorAll('.tab-content');

            tabButtons.forEach(button => {
                button.addEventListener('click', function () {
                    const tabName = this.getAttribute('data-tab');
                    
                    // Update active button
                    tabButtons.forEach(btn => btn.classList.remove('active'));
                    this.classList.add('active');
                    
                    // Show active tab content
                    tabContents.forEach(content => content.classList.remove('active'));
                    
                    if (tabName === 'profile') {
                        document.getElementById('profileTab').classList.add('active');
                    } else if (tabName === 'password') {
                        document.getElementById('passwordTab').classList.add('active');
                    }
                });
            });

            // Auto-hide alerts after 5 seconds
            const alertPanel = document.querySelector('.alert');
            if (alertPanel) {
                setTimeout(function () {
                    alertPanel.style.display = 'none';
                }, 5000);
            }
        });
    </script>
</asp:Content>
