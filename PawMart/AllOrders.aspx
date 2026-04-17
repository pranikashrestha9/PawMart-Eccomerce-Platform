<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AllOrders.aspx.cs" Inherits="PawMart.AllOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --text-color: #2d334a;
            --background-color: #f4f4f4;
        }

        .admin-orders-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 15px;
        }

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

            .orders-table th, .orders-table td {
                border: 1px solid #e0e0e0;
                padding: 12px;
                text-align: left;
            }

            .orders-table th {
                background-color: #f8f9fa;
                font-weight: bold;
                color: var(--text-color);
            }

        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 0.9em;
            font-weight: bold;
        }

        .status-pending {
            background-color: #ffd54f;
            color: #333;
        }

        .status-completed, .status-delivered {
            background-color: #4caf50;
            color: white;
        }

        .status-cancelled {
            background-color: #f44336;
            color: white;
        }
        
        .status-shipping {
            background-color: #2196F3;
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .btn {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-view {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-update {
            background-color: var(--primary-color);
            color: white;
        }

        .filter-section {
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-input {
            padding: 10px;
            width: 250px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* Modal Styles */
        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            width: 80%;
            max-width: 800px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            position: relative;
            max-height: 90vh;
            overflow-y: auto;
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 1.5em;
            color: var(--text-color);
            margin: 0;
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 1.5em;
            cursor: pointer;
            color: #666;
        }

        .order-details-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }

        .order-items-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

            .order-items-table th, .order-items-table td {
                border: 1px solid #e0e0e0;
                padding: 8px 12px;
            }

            .order-items-table th {
                background-color: #f8f9fa;
            }

        .status-update-section {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .form-group {
            margin-bottom: 15px;
        }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

        .dropdown {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .btn-save {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 20px;
        }

        @media (max-width: 768px) {
            .orders-table {
                font-size: 0.9em;
            }

                .orders-table td, .orders-table th {
                    padding: 8px;
                }

            .order-details-grid {
                grid-template-columns: 1fr;
            }
        }

    </style>


    <div class="admin-orders-container">
        <h1>All Orders</h1>

        <div class="filter-section">
            <asp:TextBox ID="txtSearchOrder" runat="server" CssClass="search-input"
                placeholder="Search by Order ID or Customer Name"></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-view" OnClick="btnSearch_Click" />
        </div>

        <asp:GridView ID="gvAllOrders" runat="server" CssClass="orders-table"
            AutoGenerateColumns="False" AllowPaging="True" PageSize="10"
            OnPageIndexChanging="gvAllOrders_PageIndexChanging"
            OnRowCommand="gvAllOrders_RowCommand">
            <Columns>
                <asp:BoundField DataField="OrderID" HeaderText="Order ID" />
                <asp:BoundField DataField="FullName" HeaderText="Customer Name" />
                <asp:BoundField DataField="OrderDate" HeaderText="Order Date" DataFormatString="{0:dd MMM yyyy}" />
                <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="${0:0.00}" />
                <asp:TemplateField HeaderText="Order Status">
                    <ItemTemplate>
                        <span class='status-badge status-<%# Eval("OrderStatus").ToString().ToLower() %>'>
                            <%# Eval("OrderStatus") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Payment Method">
                    <ItemTemplate>
                        <span class='status-badge'>
                            <%# Eval("PaymentMethod") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Payment Status">
                    <ItemTemplate>
                        <span class='status-badge status-<%# Eval("PaymentStatus").ToString().ToLower() %>'>
                            <%# Eval("PaymentStatus") %>
                        </span>
                    </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <div class="action-buttons">
                            <asp:Button ID="btnViewDetails" runat="server" Text="View"
                                CommandName="ViewOrder"
                                CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn btn-view" />
                            <asp:Button ID="btnUpdateStatus" runat="server" Text="Update"
                                CommandName="UpdateStatus"
                                CommandArgument='<%# Eval("OrderID") %>'
                                CssClass="btn btn-update" />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

    <!-- Order Details Modal -->
    <div id="orderDetailsModal" class="modal-backdrop" runat="server">
        <div class="modal-content">
            <div class="modal-header">
                <h2 class="modal-title">Order Details</h2>
                <asp:Button ID="btnCloseModal" runat="server" Text="×" CssClass="close-modal" OnClick="btnCloseModal_Click" />
            </div>
            <div class="order-details-grid">
                <div>
                    <p><strong>Order ID:</strong> <asp:Literal ID="litOrderId" runat="server"></asp:Literal></p>
                    <p><strong>Order Date:</strong> <asp:Literal ID="litOrderDate" runat="server"></asp:Literal></p>
                    <p><strong>Status:</strong> <asp:Literal ID="litOrderStatus" runat="server"></asp:Literal></p>
                    <p><strong>Payment Method:</strong> <asp:Literal ID="litPaymentMethod" runat="server"></asp:Literal></p>
                    <p><strong>Payment Status:</strong> <asp:Literal ID="litPaymentStatus" runat="server"></asp:Literal></p>
                </div>
                <div>
                    <p><strong>Customer Name:</strong> <asp:Literal ID="litCustomerName" runat="server"></asp:Literal></p>
                    <p><strong>Email:</strong> <asp:Literal ID="litEmail" runat="server"></asp:Literal></p>
                    <p><strong>Phone:</strong> <asp:Literal ID="litPhone" runat="server"></asp:Literal></p>
                    <p><strong>Address:</strong> <asp:Literal ID="litAddress" runat="server"></asp:Literal></p>
                </div>
            </div>

            <h3>Order Items</h3>
            <asp:GridView ID="gvOrderItems" runat="server" CssClass="order-items-table" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="ProductItemID" HeaderText="Product Item" />
                    <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="${0:0.00}" />
                    <asp:BoundField DataField="SubTotal" HeaderText="Subtotal" DataFormatString="${0:0.00}" />
                </Columns>
            </asp:GridView>

            <div class="status-update-section">
                <h3>Update Order Status</h3>
                <div class="form-group">
                    <label for="ddlOrderStatus">New Status:</label>
                    <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="dropdown">
                        <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                        <asp:ListItem Text="processing" Value="Shipping"></asp:ListItem>
                        <asp:ListItem Text="out for delivery" Value="out for delivery"></asp:ListItem>
                        <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                        <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <asp:HiddenField ID="hfCurrentOrderId" runat="server" />
                <asp:Button ID="btnSaveStatus" runat="server" Text="Save Changes" CssClass="btn btn-save" OnClick="btnSaveStatus_Click" />
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function closeModal() {
            document.getElementById('<%= orderDetailsModal.ClientID %>').style.display = 'none';
        }

        function showModal() {
            document.getElementById('<%= orderDetailsModal.ClientID %>').style.display = 'flex';
        }
    </script>
</asp:Content>