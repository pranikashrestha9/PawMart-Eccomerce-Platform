<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="OrderHistory.aspx.cs" Inherits="PawMart.OrderHistory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .order-history-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    font-family: Arial, sans-serif;
}

.page-title {
    font-size: 28px;
    color: #333;
    margin-bottom: 30px;
    padding-bottom: 10px;
    border-bottom: 2px solid #eee;
}

/* Filters */
.filter-section {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    margin-bottom: 25px;
    background-color: #f9f9f9;
    padding: 15px;
    border-radius: 8px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.filter-group {
    display: flex;
    align-items: center;
    gap: 10px;
}

.filter-group label {
    font-weight: 500;
    color: #555;
}

.filter-dropdown {
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: white;
    font-size: 14px;
    min-width: 180px;
}

/* No Orders Panel */
.no-orders {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 300px;
}

.no-orders-content {
    text-align: center;
    background-color: #f9f9f9;
    padding: 40px;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
    max-width: 400px;
}

.no-orders-icon {
    font-size: 50px;
    display: block;
    margin-bottom: 20px;
}

.no-orders-content h2 {
    color: #333;
    margin-bottom: 10px;
}

.no-orders-content p {
    color: #666;
    margin-bottom: 25px;
}

.start-shopping-btn {
    background-color: #4CAF50;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 500;
    transition: background-color 0.2s;
}

.start-shopping-btn:hover {
    background-color: #3f9142;
}

/* Order Cards */
.orders-list {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.order-card {
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    transition: transform 0.2s, box-shadow 0.2s;
}

.order-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.order-header {
    display: flex;
    justify-content: space-between;
    padding: 15px;
    background-color: #f8f8f8;
    border-bottom: 1px solid #eee;
}

.order-id, .order-date {
    font-size: 14px;
}

.label {
    font-weight: 500;
    color: #666;
    margin-right: 5px;
}

.value {
    color: #333;
    font-weight: 500;
}

.order-details {
    display: flex;
    justify-content: space-between;
    padding: 15px;
}

.order-info {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.info-item {
    font-size: 14px;
}

.order-status {
    display: flex;
    align-items: center;
}

.status-badge {
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 500;
    text-align: center;
    min-width: 100px;
}

.status-pending {
    background-color: #FFF3CD;
    color: #856404;
}

.status-processing {
    background-color: #CCE5FF;
    color: #004085;
}

.status-outfordelivery {
    background-color: #D4EDDA;
    color: #155724;
}

.status-delivered {
    background-color: #D1E7DD;
    color: #0F5132;
}

.status-cancelled {
    background-color: #F8D7DA;
    color: #721C24;
}

.payment-status-paid {
    color: #28a745;
}

.payment-status-pending {
    color: #fd7e14;
}

.payment-status-failed {
    color: #dc3545;
}

.order-actions {
    display: flex;
    padding: 15px;
    border-top: 1px solid #eee;
    gap: 15px;
}

.action-btn {
    display: flex;
    align-items: center;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    padding: 8px 15px;
    border-radius: 4px;
    transition: background-color 0.2s;
}

.action-icon {
    margin-right: 5px;
    font-size: 16px;
}

.details-btn {
    color: #495057;
    background-color: #f8f9fa;
}

.details-btn:hover {
    background-color: #e9ecef;
}

.track-btn {
    color: white;
    background-color: #007bff;
}

.track-btn:hover {
    background-color: #0069d9;
}

/* Pagination */
.pagination-container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 30px;
    gap: 15px;
}

.page-nav {
    text-decoration: none;
    color: #007bff;
    padding: 8px 15px;
    border-radius: 4px;
    background-color: #f8f9fa;
}

.page-nav:hover:not([disabled]) {
    background-color: #e9ecef;
}

.page-nav[disabled] {
    color: #adb5bd;
    cursor: not-allowed;
}

.page-info {
    color: #495057;
    font-size: 14px;
}

/* Responsive Design */
@media (max-width: 768px) {
    .order-header, .order-details {
        flex-direction: column;
        gap: 10px;
    }
    
    .order-status {
        margin-top: 10px;
        justify-content: flex-start;
    }
    
    .filter-section {
        flex-direction: column;
        gap: 15px;
    }
    
    .filter-group {
        width: 100%;
    }
    
    .filter-dropdown {
        flex-grow: 1;
    }
}

@media (max-width: 480px) {
    .page-title {
        font-size: 24px;
    }
    
    .order-actions {
        flex-direction: column;
        gap: 10px;
    }
    
    .action-btn {
        width: 100%;
        justify-content: center;
    }
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="order-history-container">
        <h1 class="page-title">My Orders</h1>
        
        <!-- Filters and Sorting -->
        <div class="filter-section">
            <div class="filter-group">
                <label for="ddlStatusFilter">Filter by Status:</label>
                <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ApplyFilters" CssClass="filter-dropdown">
                    <asp:ListItem Text="All Orders" Value="" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="Processing" Value="Processing"></asp:ListItem>
                    <asp:ListItem Text="Out for Delivery" Value="Out for Delivery"></asp:ListItem>
                    <asp:ListItem Text="Delivered" Value="Delivered"></asp:ListItem>
                    <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="filter-group">
                <label for="ddlSortOrder">Sort by:</label>
                <asp:DropDownList ID="ddlSortOrder" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ApplyFilters" CssClass="filter-dropdown">
                    <asp:ListItem Text="Date (Newest First)" Value="DateDesc" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Date (Oldest First)" Value="DateAsc"></asp:ListItem>
                    <asp:ListItem Text="Amount (High to Low)" Value="AmountDesc"></asp:ListItem>
                    <asp:ListItem Text="Amount (Low to High)" Value="AmountAsc"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        
        <!-- No Orders Message -->
        <asp:Panel ID="pnlNoOrders" runat="server" CssClass="no-orders" Visible="false">
            <div class="no-orders-content">
                <i class="no-orders-icon">📦</i>
                <h2>No Orders Found</h2>
                <p>You haven't placed any orders yet.</p>
                <asp:Button ID="btnStartShopping" runat="server" Text="Start Shopping" OnClick="btnStartShopping_Click" CssClass="start-shopping-btn" />
            </div>
        </asp:Panel>
        
        <!-- Orders List -->
        <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
            <HeaderTemplate>
                <div class="orders-list">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="order-card">
                    <div class="order-header">
                        <div class="order-id">
                            <span class="label">Order #:</span>
                            <span class="value"><%# Eval("OrderID") %></span>
                        </div>
                        <div class="order-date">
                            <span class="label">Ordered on:</span>
                            <span class="value"><%# Eval("OrderDate", "{0:MMM dd, yyyy}") %></span>
                        </div>
                    </div>
                    
                    <div class="order-details">
                        <div class="order-info">
                            <div class="info-item">
                                <span class="label">Total:</span>
                                <span class="value">$<%# Eval("TotalAmount", "{0:0.00}") %></span>
                            </div>
                            <div class="info-item">
                                <span class="label">Payment:</span>
                                <span class="value"><%# Eval("PaymentMethod") %></span>
                            </div>
                            <div class="info-item">
                                <span class="label">Payment Status:</span>
                                <span class="value payment-status-<%# GetPaymentStatusClass(Eval("PaymentStatus").ToString()) %>">
                                    <%# Eval("PaymentStatus") %>
                                </span>
                            </div>
                        </div>
                        
                        <div class="order-status">
                            <div class="status-badge status-<%# GetOrderStatusClass(Eval("OrderStatus").ToString()) %>">
                                <%# Eval("OrderStatus") %>
                            </div>
                        </div>
                    </div>
                    
                    <div class="order-actions">
                        <asp:LinkButton ID="lnkViewDetails" runat="server" CommandName="ViewDetails" 
                            CommandArgument='<%# Eval("OrderID") %>' CssClass="action-btn details-btn">
                            <i class="action-icon">📋</i> View Details
                        </asp:LinkButton>
                        
                        <asp:LinkButton ID="lnkTrackOrder" runat="server" CommandName="TrackOrder" 
                            CommandArgument='<%# Eval("OrderID") %>' CssClass="action-btn track-btn"
                            Visible='<%# IsOrderTrackable(Eval("OrderStatus").ToString()) %>'>
                            <i class="action-icon">🔍</i> Track Order
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>
        
        <!-- Pagination -->
        <div class="pagination-container">
            <asp:LinkButton ID="lnkPrevious" runat="server" OnClick="lnkPrevious_Click" 
                CssClass="page-nav" Enabled="false">
                &laquo; Previous
            </asp:LinkButton>
            
            <div class="page-info">
                Page <asp:Label ID="lblCurrentPage" runat="server" Text="1"></asp:Label> of 
                <asp:Label ID="lblTotalPages" runat="server" Text="1"></asp:Label>
            </div>
            
            <asp:LinkButton ID="lnkNext" runat="server" OnClick="lnkNext_Click" 
                CssClass="page-nav" Enabled="false">
                Next &raquo;
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>
