<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="CategoryDash.aspx.cs" Inherits="PawMart.CategoryDash" %>
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

            .header-buttons .btn-add-category {
                background-color: #007bff;
                color: #fff;
            }

                .header-buttons .btn-add-category:hover {
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
            .form-group textarea,
            .form-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
            }

                .form-group input[type="text"]:focus,
                .form-group textarea:focus,
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
        .category-table-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 20px;
        }

        .category-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

            .category-table th, .category-table td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .category-table th {
                background-color: #f8f9fa;
                color: #333;
                font-weight: bold;
            }

            .category-table tr:hover {
                background-color: #f1f1f1;
            }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-edit, .btn-delete {
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
            background-color: #dc3545;
            color: #fff;
        }

            .btn-edit:hover {
                background-color: #e0a800;
            }

            .btn-delete:hover {
                background-color: #c82333;
            }

        /* Responsive design */
        @media (max-width: 768px) {
            .category-table {
                font-size: 14px;
            }

                .category-table th, .category-table td {
                    padding: 8px 10px;
                }

            .btn-edit, .btn-delete {
                padding: 4px 8px;
                font-size: 12px;
            }
        }

        @media (max-width: 576px) {
            .category-table th, .category-table td {
                padding: 6px 8px;
                font-size: 12px;
            }
        }
    </style>
    <h2>Category Dashboard</h2>
    <hr />

    <div class="header-buttons">
        <!-- Back Button -->
           <button type="button" class="btn btn-back" onclick="window.location.href='Admindash.aspx'">Back</button>
        <!-- Add Category Button (Top-Right) -->
        <button type="button" class="btn btn-add-category" onclick="openAddModal()">Add Category</button>
    </div>

    <!-- Category Table -->
    <div class="category-table-container">
        <asp:GridView ID="gvCategories" runat="server" CssClass="category-table" AutoGenerateColumns="false"
            OnRowCommand="gvCategories_RowCommand" DataKeyNames="CategoryID">
            <Columns>
                <asp:BoundField DataField="CategoryID" HeaderText="ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Created At" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <div class="action-buttons">
                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn-edit" CommandName="EditCategory"
                                CommandArgument='<%# Eval("CategoryID") %>' OnClientClick='<%# "return openEditModal(" + Eval("CategoryID") + ");" %>'>
                                Edit
                            </asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn-delete" CommandName="DeleteCategory"
                                CommandArgument='<%# Eval("CategoryID") %>' OnClientClick="return confirm('Are you sure you want to delete this category?');">
                                Delete
                            </asp:LinkButton>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <div style="text-align: center; padding: 20px;">No categories found.</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

    <!-- Add Category Modal -->
    <div id="addCategoryModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Category</h2>   
                <span class="close" onclick="closeAddModal()">&times;</span>
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

            <!-- Name -->
            <div class="form-group">
                <asp:Label ID="lblName" runat="server" Text="Name:" AssociatedControlID="txtName"></asp:Label>
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required." CssClass="error-message" ValidationGroup="AddCategoryGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Description -->
            <div class="form-group">
                <asp:Label ID="lblDescription" runat="server" Text="Description:" AssociatedControlID="txtDescription"></asp:Label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                    ErrorMessage="Description is required." CssClass="error-message" ValidationGroup="AddCategoryGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Submit Button -->
            <div class="btn-container">
                <asp:Button ID="btnAddCategory" runat="server" Text="Add Category" OnClick="btnAddCategory_Click"
                    CssClass="btn" ValidationGroup="AddCategoryGroup" />
            </div>
        </div>
    </div>

    <!-- Edit Category Modal -->
    <div id="editCategoryModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Category</h2>
                <span class="close" onclick="closeEditModal()">&times;</span>
            </div>
            <asp:Label ID="lblEditMessage" runat="server" CssClass="error-message"></asp:Label>

            <asp:HiddenField ID="hdnCategoryID" runat="server" />

            <!-- Name -->
            <div class="form-group">
                <asp:Label ID="lblEditName" runat="server" Text="Name:" AssociatedControlID="txtEditName"></asp:Label>
                <asp:TextBox ID="txtEditName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditName" runat="server" ControlToValidate="txtEditName"
                    ErrorMessage="Name is required." CssClass="error-message" ValidationGroup="EditCategoryGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Description -->
            <div class="form-group">
                <asp:Label ID="lblEditDescription" runat="server" Text="Description:" AssociatedControlID="txtEditDescription"></asp:Label>
                <asp:TextBox ID="txtEditDescription" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditDescription" runat="server" ControlToValidate="txtEditDescription"
                    ErrorMessage="Description is required." CssClass="error-message" ValidationGroup="EditCategoryGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Submit Button -->
            <div class="btn-container">
                <asp:Button ID="btnUpdateCategory" runat="server" Text="Update Category" OnClick="btnUpdateCategory_Click"
                    CssClass="btn" ValidationGroup="EditCategoryGroup" />
            </div>
        </div>
    </div>

    <script>
        // JavaScript to handle modal open/close
        function openAddModal() {
            // Clear all form fields
            document.getElementById('<%=txtName.ClientID%>').value = '';
            document.getElementById('<%=txtDescription.ClientID%>').value = '';
            
            // Clear error messages
            document.getElementById('<%=lblMessage.ClientID%>').innerText = '';
            
            // Show the modal
            document.getElementById("addCategoryModal").style.display = "flex";
        }

        function closeAddModal() {
            document.getElementById("addCategoryModal").style.display = "none";
        }

        function openEditModal(categoryId) {
            // Store the category ID for the update operation
            document.getElementById('<%=hdnCategoryID.ClientID%>').value = categoryId;
            
            // Make an AJAX call to get category data
            fetch('GetAllCategories.ashx?categoryId=' + categoryId)
                .then(response => response.json())
                .then(data => {
                    // Populate the form fields with the retrieved data
                    document.getElementById('<%=txtEditName.ClientID%>').value = data.Name;
                    document.getElementById('<%=txtEditDescription.ClientID%>').value = data.Description;
                    
                    // Clear error messages
                    document.getElementById('<%=lblEditMessage.ClientID%>').innerText = '';
                })
                .catch(error => {
                    console.error('Error fetching category data:', error);
                    alert('Failed to load category data. Please try again.');
                });

            // Show the modal
            document.getElementById("editCategoryModal").style.display = "flex";

            // Prevent the default action of the link
            return false;
        }

        function closeEditModal() {
            document.getElementById("editCategoryModal").style.display = "none";
        }

        // Close modals if user clicks outside the modal content
        window.onclick = function (event) {
            var addModal = document.getElementById("addCategoryModal");
            var editModal = document.getElementById("editCategoryModal");

            if (event.target === addModal) {
                closeAddModal();
            }

            if (event.target === editModal) {
                closeEditModal();
            }
        };
    </script>
</asp:Content>

