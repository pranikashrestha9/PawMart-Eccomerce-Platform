<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="PawMart.UserManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <style>
     /* Custom CSS for the form and modal */
     body {
         font-family: Arial, sans-serif;
         background-color: #f4f4f9;
         margin: 0;
         padding: 0;
     }

     .header-buttons {
         display: flex;
         justify-content: space-between;
         margin-bottom: 20px;
     }

         .header-buttons .btn {
             padding: 10px 20px;
             border: none;
             border-radius: 4px;
             font-size: 16px;
             cursor: pointer;
         }

         .header-buttons .btn-back {
             background-color: #6c757d;
             color: #fff;
         }

             .header-buttons .btn-back:hover {
                 background-color: #5a6268;
             }

         .header-buttons .btn-add-user {
             background-color: #007bff;
             color: #fff;
         }

             .header-buttons .btn-add-user:hover {
                 background-color: #0056b3;
             }

     /* Modal Styles */
     .modal {
         display: none; /* Hidden by default */
         position: fixed;
         top: 0;
         left: 0;
         width: 100%;
         height: 100%;
         background-color: rgba(0, 0, 0, 0.5); /* Semi-transparent background */
         justify-content: center;
         align-items: center;
         z-index: 1000;
     }

     .modal-content {
         background-color: #fff;
         padding: 20px;
         border-radius: 8px;
         box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
         max-width: 600px;
         width: 90%;
         max-height: 90vh;
         overflow-y: auto; /* Scrollable if content exceeds height */
     }

     .modal-header {
         display: flex;
         justify-content: space-between;
         align-items: center;
         margin-bottom: 20px;
     }

         .modal-header h2 {
             margin: 0;
             color: #333;
         }

         .modal-header .close {
             font-size: 24px;
             cursor: pointer;
             color: #333;
         }

             .modal-header .close:hover {
                 color: #000;
             }

     .form-group {
         margin-bottom: 15px;
     }

         .form-group label {
             display: block;
             font-weight: bold;
             margin-bottom: 5px;
             color: #555;
         }

         .form-group input[type="text"],
         .form-group input[type="password"],
         .form-group select {
             width: 100%;
             padding: 10px;
             border: 1px solid #ddd;
             border-radius: 4px;
             font-size: 16px;
         }

             .form-group input[type="text"]:focus,
             .form-group input[type="password"]:focus,
             .form-group select:focus {
                 border-color: #007bff;
                 outline: none;
             }

         .form-group .error-message {
             color: red;
             font-size: 14px;
             margin-top: 5px;
         }

     .btn-container {
         text-align: center;
         margin-top: 20px;
     }

         .btn-container .btn {
             padding: 10px 20px;
             background-color: #28a745;
             color: #fff;
             border: none;
             border-radius: 4px;
             font-size: 16px;
             cursor: pointer;
         }

             .btn-container .btn:hover {
                 background-color: #218838;
             }
             
     /* Table Styles */
     .user-table-container {
         width: 100%;
         overflow-x: auto;
         margin-top: 20px;
     }
     
     .user-table {
         width: 100%;
         border-collapse: collapse;
         margin-bottom: 20px;
     }
     
     .user-table th, .user-table td {
         padding: 12px 15px;
         text-align: left;
         border-bottom: 1px solid #ddd;
     }
     
     .user-table th {
         background-color: #f8f9fa;
         color: #333;
         font-weight: bold;
     }
     
     .user-table tr:hover {
         background-color: #f1f1f1;
     }
     
     .action-buttons {
         display: flex;
         gap: 10px;
     }
     
     .btn-edit, .btn-delete {
          text-decoration:none;
         padding: 6px 12px;
         border: none;
         border-radius: 4px;
         cursor: pointer;
         font-size: 14px;
     }
     
     .btn-edit {
        
         background-color: #ffc107;
         color: #212529;
     }
     
     .btn-delete {
           text-decoration:none;
         background-color: #dc3545;
         color: #fff;
     }
     
     .btn-edit:hover {
         background-color: #e0a800;
     }
     
     .btn-delete:hover {
         background-color: #c82333;
     }
     
     /* Status Indicator */
     .status-active {
         color: #28a745;
         font-weight: bold;
     }
     
     .status-inactive {
         color: #dc3545;
         font-weight: bold;
     }
     
     /* Responsive design */
     @media (max-width: 768px) {
         .user-table {
             font-size: 14px;
         }
         
         .user-table th, .user-table td {
             padding: 8px 10px;
         }
         
         .btn-edit, .btn-delete {
             padding: 4px 8px;
             font-size: 12px;
         }
     }
     
     @media (max-width: 576px) {
         .user-table th, .user-table td {
             padding: 6px 8px;
             font-size: 12px;
         }
     }
 </style>
    <h2>User Management</h2>
    <hr />
   

    <div class="header-buttons">
        <!-- Back Button -->
           <button type="button" class="btn btn-back" onclick="window.location.href='Admindash.aspx'">Back</button>
        <!-- Add User Button (Top-Right) -->
        <button type="button" class="btn btn-add-user" onclick="openAddModal()">Add User</button>
    </div>

    <!-- User Table -->
    <div class="user-table-container">
        <asp:GridView ID="gvUsers" runat="server" CssClass="user-table" AutoGenerateColumns="false" 
            OnRowCommand="gvUsers_RowCommand" DataKeyNames="UserID">
            <Columns>
                <asp:BoundField DataField="UserID" HeaderText="ID" />
                <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" />
                <asp:BoundField DataField="Address" HeaderText="Address" />
                <asp:BoundField DataField="UserType" HeaderText="User Type" />
                <asp:BoundField DataField="RegistrationDate" HeaderText="Registration Date" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <span class='<%# (bool)Eval("IsActive") ? "status-active" : "status-inactive" %>'>
                            <%# (bool)Eval("IsActive") ? "Active" : "Inactive" %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <div class="action-buttons">
                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn-edit" CommandName="EditUser" 
                                CommandArgument='<%# Eval("UserID") %>' OnClientClick='<%# "return openEditModal(" + Eval("UserID") + ");" %>'>
                                Edit
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn-delete" CommandName="DeleteUser" 
                                CommandArgument='<%# Eval("UserID") %>' OnClientClick="return confirm('Are you sure you want to delete this user?');">
                                Delete
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <div style="text-align: center; padding: 20px;">No users found.</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

    <!-- Add User Modal -->
    <div id="addUserModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New User</h2>
                <span class="close" onclick="closeAddModal()">&times;</span>
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

            <!-- Full Name -->
            <div class="form-group">
                <asp:Label ID="lblFullName" runat="server" Text="Full Name:" AssociatedControlID="txtFullName"></asp:Label>
                <asp:TextBox ID="txtFullName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." CssClass="error-message" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
            </div>
            <!-- Email -->
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" Text="Email:" AssociatedControlID="txtEmail"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." CssClass="error-message" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-message" ValidationGroup="AddUserGroup"></asp:RegularExpressionValidator>
            </div>

            <!-- Password -->
            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" Text="Password:" AssociatedControlID="txtPassword"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="error-message" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Phone -->
            <div class="form-group">
                <asp:Label ID="lblPhone" runat="server" Text="Phone:" AssociatedControlID="txtPhone"></asp:Label>
                <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone is required." CssClass="error-message" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Address -->
            <div class="form-group">
                <asp:Label ID="lblAddress" runat="server" Text="Address:" AssociatedControlID="txtAddress"></asp:Label>
                <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="Address is required." CssClass="error-message" ValidationGroup="AddUserGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- User Type -->
            <div class="form-group">
                <asp:Label ID="lblUserType" runat="server" Text="User Type:" AssociatedControlID="ddlUserType"></asp:Label>
                <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                    <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <!-- Is Active -->
            <div class="form-group">
                <asp:CheckBox ID="chkIsActive" runat="server" Text="Is Active" Checked="true" />
            </div>

            <!-- Submit Button -->
            <div class="btn-container">
                <asp:Button ID="btnAddUser" runat="server" Text="Add User" OnClick="btnAddUser_Click" CssClass="btn" ValidationGroup="AddUserGroup" />
            </div>
        </div>
    </div>
    
    <!-- Edit User Modal -->
    <div id="editUserModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit User</h2>
                <span class="close" onclick="closeEditModal()">&times;</span>
            </div>
            <asp:Label ID="lblEditMessage" runat="server" CssClass="error-message"></asp:Label>
            
            <asp:HiddenField ID="hdnUserID" runat="server" />

            <!-- Full Name -->
            <div class="form-group">
                <asp:Label ID="lblEditFullName" runat="server" Text="Full Name:" AssociatedControlID="txtEditFullName"></asp:Label>
                <asp:TextBox ID="txtEditFullName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditFullName" runat="server" ControlToValidate="txtEditFullName" ErrorMessage="Full Name is required." CssClass="error-message" ValidationGroup="EditUserGroup"></asp:RequiredFieldValidator>
            </div>
         <!-- Email -->
<div class="form-group">
    <asp:Label ID="lblEditEmail" runat="server" Text="Email:" AssociatedControlID="txtEditEmail"></asp:Label>
    <asp:TextBox ID="txtEditEmail" runat="server"></asp:TextBox>
    <asp:RequiredFieldValidator ID="rfvEditEmail" runat="server" ControlToValidate="txtEditEmail" ErrorMessage="Email is required." CssClass="error-message" ValidationGroup="EditUserGroup"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="revEditEmail" runat="server" ControlToValidate="txtEditEmail" ErrorMessage="Invalid email format." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-message" ValidationGroup="EditUserGroup"></asp:RegularExpressionValidator>
</div>

            <!-- Phone -->
            <div class="form-group">
                <asp:Label ID="lblEditPhone" runat="server" Text="Phone:" AssociatedControlID="txtEditPhone"></asp:Label>
                <asp:TextBox ID="txtEditPhone" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditPhone" runat="server" ControlToValidate="txtEditPhone" ErrorMessage="Phone is required." CssClass="error-message" ValidationGroup="EditUserGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Address -->
            <div class="form-group">
                <asp:Label ID="lblEditAddress" runat="server" Text="Address:" AssociatedControlID="txtEditAddress"></asp:Label>
                <asp:TextBox ID="txtEditAddress" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditAddress" runat="server" ControlToValidate="txtEditAddress" ErrorMessage="Address is required." CssClass="error-message" ValidationGroup="EditUserGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- User Type -->
            <div class="form-group">
                <asp:Label ID="lblEditUserType" runat="server" Text="User Type:" AssociatedControlID="ddlEditUserType"></asp:Label>
                <asp:DropDownList ID="ddlEditUserType" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                    <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <!-- Is Active -->
            <div class="form-group">
                <asp:CheckBox ID="chkEditIsActive" runat="server" Text="Is Active" />
            </div>

            <!-- Submit Button -->
            <div class="btn-container">
                <asp:Button ID="btnUpdateUser" runat="server" Text="Update User" OnClick="btnUpdateUser_Click" CssClass="btn" ValidationGroup="EditUserGroup" />
            </div>
        </div>
    </div>

    <script>
        // JavaScript to handle modal open/close
        function openAddModal() {
            // Clear all form fields
            document.getElementById('<%=txtFullName.ClientID%>').value = '';
            document.getElementById('<%=txtEmail.ClientID%>').value = '';
            document.getElementById('<%=txtPassword.ClientID%>').value = '';
            document.getElementById('<%=txtPhone.ClientID%>').value = '';
            document.getElementById('<%=txtAddress.ClientID%>').value = '';
            document.getElementById('<%=ddlUserType.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=chkIsActive.ClientID%>').checked = true;
            
            // Clear error messages
            document.getElementById('<%=lblMessage.ClientID%>').innerText = '';
            
            // Show the modal
            document.getElementById("addUserModal").style.display = "flex";
        }

        function closeAddModal() {
            document.getElementById("addUserModal").style.display = "none";
        }
        
        function openEditModal(userId) {
            // Store the user ID for the update operation
            document.getElementById('<%=hdnUserID.ClientID%>').value = userId;
            
            // Make an AJAX call to get user data
            fetch('GetUserData.ashx?userId=' + userId)
                .then(response => response.json())
                .then(data => {
                    // Populate the form fields with the retrieved data
                    document.getElementById('<%=txtEditFullName.ClientID%>').value = data.FullName;
                    document.getElementById('<%=txtEditEmail.ClientID%>').value = data.Email;
                    document.getElementById('<%=txtEditPhone.ClientID%>').value = data.Phone;
                    document.getElementById('<%=txtEditAddress.ClientID%>').value = data.Address;
                    
                    // Set dropdown selection
                    const userTypeDropdown = document.getElementById('<%=ddlEditUserType.ClientID%>');
                    for(let i = 0; i < userTypeDropdown.options.length; i++) {
                        if(userTypeDropdown.options[i].value === data.UserType) {
                            userTypeDropdown.selectedIndex = i;
                            break;
                        }
                    }
                    
                    // Set checkbox state
                    document.getElementById('<%=chkEditIsActive.ClientID%>').checked = data.IsActive;
                    
                    // Clear error messages
                    document.getElementById('<%=lblEditMessage.ClientID%>').innerText = '';
                })
                .catch(error => {
                    console.error('Error fetching user data:', error);
                    alert('Failed to load user data. Please try again.');
                });

            // Show the modal
            document.getElementById("editUserModal").style.display = "flex";

            // Prevent the default action of the link
            return false;
        }

        function closeEditModal() {
            document.getElementById("editUserModal").style.display = "none";
        }

        // Close modals if user clicks outside the modal content
        window.onclick = function (event) {
            var addModal = document.getElementById("addUserModal");
            var editModal = document.getElementById("editUserModal");

            if (event.target === addModal) {
                closeAddModal();
            }

            if (event.target === editModal) {
                closeEditModal();
            }
        };
    </script>
</asp:Content>