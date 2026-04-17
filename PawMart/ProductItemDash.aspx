<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ProductItemDash.aspx.cs" Inherits="PawMart.ProductItemDash" %>
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

            .header-buttons .btn-add-food-item {
                background-color: #007bff;
                color: #fff;
            }

                .header-buttons .btn-add-food-item:hover {
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
            .form-group select,
            .form-group input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
            }

                .form-group input[type="text"]:focus,
                .form-group textarea:focus,
                .form-group select:focus,
                .form-group input[type="number"]:focus {
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
        .food-item-table-container {
            width: 100%;
            overflow-x: auto;
            margin-top: 20px;
        }

        .food-item-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

            .food-item-table th, .food-item-table td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            .food-item-table th {
                background-color: #f8f9fa;
                color: #333;
                font-weight: bold;
            }

            .food-item-table tr:hover {
                background-color: #f1f1f1;
            }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn-edit, .btn-delete {
            -webkit-text-decoration: none;
            text-decoration: none;
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
            .food-item-table {
                font-size: 14px;
            }

                .food-item-table th, .food-item-table td {
                    padding: 8px 10px;
                }

            .btn-edit, .btn-delete {
                padding: 4px 8px;
                font-size: 12px;
            }
        }

        @media (max-width: 576px) {
            .food-item-table th, .food-item-table td {
                padding: 6px 8px;
                font-size: 12px;
            }
        }
    </style>
    <h2>Product Item Dashboard</h2>
    <hr />

    <div class="header-buttons">
        <!-- Back Button -->
               <button type="button" class="btn btn-back" onclick="window.location.href='Admindash.aspx'">Back</button>
        <!-- Add Food Item Button (Top-Right) -->
        <button type="button" class="btn btn-add-food-item" onclick="openAddModal()">Add Product Item</button>
    </div>

    <!-- Food Item Table -->
    <div class="food-item-table-container">
        <asp:GridView ID="gvProductItems" runat="server" CssClass="food-item-table" AutoGenerateColumns="false"
            OnRowCommand="gvProductItems_RowCommand" DataKeyNames="ProductItemID">
            <Columns>
                <asp:BoundField DataField="ProductItemID" HeaderText="ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="DiscountPrice" HeaderText="Discount Price" DataFormatString="{0:C}" />
                <asp:BoundField DataField="CategoryID" HeaderText="Category ID" />
                <asp:BoundField DataField="IsAvailable" HeaderText="Available" />
                <asp:BoundField DataField="IsFeatured" HeaderText="Featured" />
                <asp:BoundField DataField="CreatedAt" HeaderText="Created At" DataFormatString="{0:MM/dd/yyyy}" />
         <asp:TemplateField HeaderText="Actions">
    <ItemTemplate>
        <div class="action-buttons">
            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn-edit" CommandName="EditProductItem"
                CommandArgument='<%# Eval("ProductItemID") %>' >
                Edit
            </asp:LinkButton>
            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn-delete" CommandName="DeleteProductItem"
                CommandArgument='<%# Eval("ProductItemID") %>' OnClientClick="return confirm('Are you sure you want to delete this product item?');">
                Delete
            </asp:LinkButton>
        </div>
    </ItemTemplate>
</asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <div style="text-align: center; padding: 20px;">No product items found.</div>
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

    <!-- Add Product Item Modal -->
    <div id="addProductItemModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Product Item</h2>
                <span class="close" onclick="closeAddModal()">&times;</span>
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>

            <!-- Name -->
            <div class="form-group">
                <asp:Label ID="lblName" runat="server" Text="Name:" AssociatedControlID="txtName"></asp:Label>
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                    ErrorMessage="Name is required." CssClass="error-message" ValidationGroup="AddProductItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Description -->
            <div class="form-group">
                <asp:Label ID="lblDescription" runat="server" Text="Description:" AssociatedControlID="txtDescription"></asp:Label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription"
                    ErrorMessage="Description is required." CssClass="error-message" ValidationGroup="AddProductItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Price -->
            <div class="form-group">
                <asp:Label ID="lblPrice" runat="server" Text="Price:" AssociatedControlID="txtPrice"></asp:Label>
                <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" step="0.01"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice"
                    ErrorMessage="Price is required." CssClass="error-message" ValidationGroup="AddItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Discount Price -->
            <div class="form-group">
                <asp:Label ID="lblDiscountPrice" runat="server" Text="Discount Price:" AssociatedControlID="txtDiscountPrice"></asp:Label>
                <asp:TextBox ID="txtDiscountPrice" runat="server" TextMode="Number" step="0.01"></asp:TextBox>
            </div>

            <!-- Image URL -->
           <div class="form-group">
    <asp:Label ID="lblImageURL" runat="server" Text="Image:" AssociatedControlID="fileUploadImage"></asp:Label>
    <asp:FileUpload ID="fileUploadImage" runat="server" CssClass="form-control" />
    <asp:RequiredFieldValidator ID="rfvImageURL" runat="server" ControlToValidate="fileUpload1"
        ErrorMessage="Image is required." CssClass="error-message" ValidationGroup="AddProductItemGroup"></asp:RequiredFieldValidator>
</div>

            <!-- Category ID -->
            <div class="form-group">
                <asp:Label ID="lblCategoryID" runat="server" Text="Category ID:" AssociatedControlID="ddlCategoryID"></asp:Label>
                <asp:DropDownList ID="ddlCategoryID" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategoryID" runat="server" ControlToValidate="ddlCategoryID"
                    ErrorMessage="Category ID is required." CssClass="error-message" ValidationGroup="AddFoodItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Is Available -->
            <div class="form-group">
                <asp:CheckBox ID="chkIsAvailable" runat="server" Text="Is Available" Checked="true" />
            </div>

            <!-- Is Featured -->
            <div class="form-group">
                <asp:CheckBox ID="chkIsFeatured" runat="server" Text="Is Featured" />
            </div>

            <!-- Submit Button -->
            <div class="btn-container">
                <asp:Button ID="btnAddProductItem" runat="server" Text="Add Product Item" OnClick="btnAddProductItem_Click"
                    CssClass="btn" ValidationGroup="AddProductItemGroup" />
            </div>
        </div>
    </div>

    <!-- Edit Food Item Modal -->
    <div id="editProductItemModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Product Item</h2>
                <span class="close" onclick="closeEditModal()">&times;</span>
            </div>
            <asp:Label ID="lblEditMessage" runat="server" CssClass="error-message"></asp:Label>

            <asp:HiddenField ID="hdnProductItemID" runat="server" />

            <!-- Name -->
            <div class="form-group">
                <asp:Label ID="lblEditName" runat="server" Text="Name:" AssociatedControlID="txtEditName"></asp:Label>
                <asp:TextBox ID="txtEditName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditName" runat="server" ControlToValidate="txtEditName"
                    ErrorMessage="Name is required." CssClass="error-message" ValidationGroup="EditProductItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Description -->
            <div class="form-group">
                <asp:Label ID="lblEditDescription" runat="server" Text="Description:" AssociatedControlID="txtEditDescription"></asp:Label>
                <asp:TextBox ID="txtEditDescription" runat="server" TextMode="MultiLine" Rows="4"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditDescription" runat="server" ControlToValidate="txtEditDescription"
                    ErrorMessage="Description is required." CssClass="error-message" ValidationGroup="EditProductItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Price -->
            <div class="form-group">
                <asp:Label ID="lblEditPrice" runat="server" Text="Price:" AssociatedControlID="txtEditPrice"></asp:Label>
                <asp:TextBox ID="txtEditPrice" runat="server" TextMode="Number" step="0.01"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditPrice" runat="server" ControlToValidate="txtEditPrice"
                    ErrorMessage="Price is required." CssClass="error-message" ValidationGroup="EditProductItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Discount Price -->
            <div class="form-group">
                <asp:Label ID="lblEditDiscountPrice" runat="server" Text="Discount Price:" AssociatedControlID="txtEditDiscountPrice"></asp:Label>
                <asp:TextBox ID="txtEditDiscountPrice" runat="server" TextMode="Number" step="0.01"></asp:TextBox>
            </div>

                     <!-- Image URL -->
           <div class="form-group">
    <asp:Label ID="lblEditImageURL" runat="server" Text="Image:" AssociatedControlID="fileUploadImage"></asp:Label>
    <asp:FileUpload ID="fileUpload1" runat="server" CssClass="form-control" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="fileUploadImage"
        ErrorMessage="Image is required." CssClass="error-message" ValidationGroup="AddProductItemGroup"></asp:RequiredFieldValidator>
</div>

            <!-- Category ID -->
            <div class="form-group">
                <asp:Label ID="lblEditCategoryID" runat="server" Text="Category ID:" AssociatedControlID="ddlEditCategoryID"></asp:Label>
                <asp:DropDownList ID="ddlEditCategoryID" runat="server" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvEditCategoryID" runat="server" ControlToValidate="ddlEditCategoryID"
                    ErrorMessage="Category ID is required." CssClass="error-message" ValidationGroup="EditProductItemGroup"></asp:RequiredFieldValidator>
            </div>

            <!-- Is Available -->
            <div class="form-group">
                <asp:CheckBox ID="chkEditIsAvailable" runat="server" Text="Is Available" />
            </div>

            <!-- Is Featured -->
            <div class="form-group">
                <asp:CheckBox ID="chkEditIsFeatured" runat="server" Text="Is Featured" />
            </div>

            <!-- Submit Button -->
            <div class="btn-container">
                <asp:Button ID="btnUpdateProductItem" runat="server" Text="Update Product Item" OnClick="btnUpdateProductItem_Click"
                    CssClass="btn" ValidationGroup="EditProductItemGroup" />
            </div>
        </div>
    </div>

    <script>
        // JavaScript to handle modal open/close
        function openAddModal() {
            // Clear all form fields
            document.getElementById('<%=txtName.ClientID%>').value = '';
            document.getElementById('<%=txtDescription.ClientID%>').value = '';
            document.getElementById('<%=txtPrice.ClientID%>').value = '';
            document.getElementById('<%=txtDiscountPrice.ClientID%>').value = '';
            document.getElementById('<%=lblImageURL.ClientID%>').value = '';
            document.getElementById('<%=ddlCategoryID.ClientID%>').selectedIndex = 0;
            document.getElementById('<%=chkIsAvailable.ClientID%>').checked = true;
            document.getElementById('<%=chkIsFeatured.ClientID%>').checked = false;

            // Clear error messages
            document.getElementById('<%=lblMessage.ClientID%>').innerText = '';

            // Show the modal
            document.getElementById("addProductItemModal").style.display = "flex";
        }

        function closeAddModal() {
            document.getElementById("addProductItemModal").style.display = "none";
        }

        function openEditModal() {
            // Just show the modal - data will be populated server-side
            document.getElementById("editProductItemModal").style.display = "flex";
            return false; // Prevent default action
        }

        function closeEditModal() {
            document.getElementById("editProductItemModal").style.display = "none";
        }

        // Close modals if user clicks outside the modal content
        window.onclick = function (event) {
            var addModal = document.getElementById("addProductItemModal");
            var editModal = document.getElementById("editProductItemModal");

            if (event.target === addModal) {
                closeAddModal();
            }

            if (event.target === editModal) {
                closeEditModal();
            }
        };
    </script>
</asp:Content>

