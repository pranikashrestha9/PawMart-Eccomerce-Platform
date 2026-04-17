<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="OrderConfirmation.aspx.cs" Inherits="PawMart.OrderConfirmation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
/* Order Confirmation Styles - Enhanced Version */
:root {
    --primary-color: #0d6efd;
    --success-color: #28a745;
    --warning-color: #ffc107;
    --light-gray: #f9f9f9;
    --medium-gray: #6c757d;
    --dark-gray: #495057;
    --border-radius: 8px;
    --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    --transition: all 0.3s ease;
}

/* Card Styling */
.card {
    border-radius: var(--border-radius);
    box-shadow: var(--box-shadow);
    margin-bottom: 30px;
    border: none;
    overflow: hidden;
    transition: var(--transition);
}

.card:hover {
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
}

.card-header {
    border-radius: var(--border-radius) var(--border-radius) 0 0;
    padding: 18px 25px;
    border-bottom: none;
}

.card-body {
    padding: 25px;
}

/* Information Sections */
.order-details, .delivery-info {
    padding: 20px;
    background-color: var(--light-gray);
    border-radius: var(--border-radius);
    margin-bottom: 20px;
    border-left: 4px solid var(--primary-color);
    transition: var(--transition);
}

.delivery-info {
    border-left-color: var(--success-color);
}

.order-details:hover, .delivery-info:hover {
    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
}

/* Badge styling */
.badge {
    padding: 8px 12px;
    font-size: 0.85rem;
    font-weight: 500;
    border-radius: var(--border-radius);
    letter-spacing: 0.5px;
    display: inline-block;
}

.bg-warning {
    background-color: var(--warning-color) !important;
    color: #212529;
}

/* Success icon */
.fa-check-circle {
    color: var(--success-color);
    filter: drop-shadow(0 2px 4px rgba(40, 167, 69, 0.2));
    transition: var(--transition);
}

.text-center:hover .fa-check-circle {
    transform: scale(1.05);
}

/* Table styling - Updated for horizontal scrolling */
.table-responsive {
    border-radius: var(--border-radius);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    overflow-x: auto;
    -webkit-overflow-scrolling: touch;
    width: 100%;
    display: block;
}

.table {
    background-color: white;
    margin-bottom: 0;
    width: 100%;
    min-width: 600px;
}

.table th {
    background-color: #f2f2f2;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 0.85rem;
    letter-spacing: 0.5px;
    padding: 12px 15px;
}

.table td {
    padding: 15px;
    vertical-align: middle;
    border-top: 1px solid #f0f0f0;
}

.table tr:hover {
    background-color: rgba(13, 110, 253, 0.03);
}

/* Buttons */
.btn {
    padding: 10px 24px;
    border-radius: var(--border-radius);
    font-weight: 500;
    transition: var(--transition);
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn i {
    font-size: 0.9rem;
}

.btn-primary {
    background-color: var(--primary-color);
    border-color: var(--primary-color);
}

.btn-primary:hover, .btn-primary:focus {
    background-color: #0b5ed7;
    border-color: #0a58ca;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(13, 110, 253, 0.2);
}

.btn-outline-secondary {
    color: var(--medium-gray);
    border-color: var(--medium-gray);
}

.btn-outline-secondary:hover {
    color: #fff;
    background-color: var(--medium-gray);
    border-color: var(--medium-gray);
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(108, 117, 125, 0.2);
}

/* Typography improvements */
h4, h5 {
    font-weight: 600;
    color: #333;
}

.lead {
    font-size: 1.1rem;
    color: var(--medium-gray);
}

p strong {
    font-weight: 600;
    color: var(--dark-gray);
}

/* Order Tracking Styles */
.order-tracking-container {
    margin: 40px 0;
    display: flex;
    justify-content: space-between;
    position: relative;
}

.order-tracking-container::before {
    content: '';
    position: absolute;
    top: 20px;
    left: 10%;
    right: 10%;
    height: 2px;
    background-color: #dee2e6;
    z-index: 0;
}

.tracking-step {
    text-align: center;
    position: relative;
    width: 20%;
    z-index: 1;
}

.tracking-icon {
    width: 50px;
    height: 50px;
    line-height: 46px;
    text-align: center;
    background-color: #f8f9fa;
    border-radius: 50%;
    margin: 0 auto;
    position: relative;
    border: 2px solid #dee2e6;
    transition: var(--transition);
    z-index: 2;
}

.tracking-step.active .tracking-icon {
    background-color: var(--primary-color);
    color: white;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.2);
}

.tracking-step.completed .tracking-icon {
    background-color: var(--success-color);
    color: white;
    border-color: var(--success-color);
    box-shadow: 0 0 0 4px rgba(40, 167, 69, 0.2);
}

.tracking-label {
    font-size: 14px;
    font-weight: 500;
    color: var(--medium-gray);
    margin-top: 10px;
    transition: var(--transition);
}

.tracking-step.active .tracking-label,
.tracking-step.completed .tracking-label {
    color: #212529;
    font-weight: 600;
}

/* Timeline Styles */
.order-timeline {
    margin-left: 20px;
    border-left: 2px solid #dee2e6;
    padding: 20px 0;
}

.timeline-item {
    position: relative;
    padding-left: 30px;
    margin-bottom: 25px;
}

.timeline-item:last-child {
    margin-bottom: 0;
}

.timeline-item-dot {
    position: absolute;
    width: 16px;
    height: 16px;
    background-color: var(--primary-color);
    border-radius: 50%;
    left: -9px;
    top: 5px;
    box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.2);
}

.timeline-item-content {
    background-color: #f8f9fa;
    padding: 20px;
    border-radius: var(--border-radius);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    border-left: 3px solid var(--primary-color);
    transition: var(--transition);
}

.timeline-item-content:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    transform: translateY(-2px);
}

.timeline-item-title {
    font-weight: 600;
    color: #212529;
    margin-bottom: 5px;
}

.timeline-item-date {
    color: var(--medium-gray);
    font-size: 14px;
    margin-bottom: 8px;
    display: flex;
    align-items: center;
    gap: 5px;
}

.timeline-item-date i {
    font-size: 12px;
}

.timeline-item-text {
    color: var(--dark-gray);
    line-height: 1.5;
}

/*  responsive adjustments */
@media (max-width: 991.98px) {
    .card-body {
        padding: 20px;
    }
    
    .order-details, .delivery-info {
        padding: 15px;
    }
}

@media (max-width: 767.98px) {
    .col-md-6 {
        margin-bottom: 15px;
    }
    
    .tracking-step {
        width: 25%;
    }
    
    .tracking-label {
        font-size: 12px;
    }
    
    .btn {
        padding: 8px 16px;
        font-size: 14px;
    }
    
    .order-tracking-container::before {
        left: 5%;
        right: 5%;
    }
    
    .fa-check-circle {
        font-size: 48px !important;
    }
    
    h4 {
        font-size: 1.3rem;
    }
    
    .lead {
        font-size: 1rem;
    }
    
    .table th {
        font-size: 0.75rem;
    }
    
    .table td {
        padding: 10px;
    }
}

@media (max-width: 575.98px) {
    .card-header {
        padding: 15px;
    }
    
    .card-body {
        padding: 15px;
    }
    
    .tracking-step {
        width: 33.33%;
    }
    
    .order-tracking-container {
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .order-tracking-container::before {
        display: none;
    }
    
    .btn {
        width: 100%;
        margin-bottom: 10px;
    }
    
    .fa-check-circle {
        font-size: 42px !important;
    }
    
    h4 {
        font-size: 1.2rem;
    }
    
    .order-details, .delivery-info {
        margin-bottom: 15px;
    }
}

/* Print styles for receipt printing - enhanced */
@media print {
    body {
        font-size: 12pt;
    }
    
    .btn, 
    .card-header {
        display: none;
    }
    
    .card {
        box-shadow: none;
        border: 1px solid #ddd;
        margin: 0;
    }
    
    .card-body {
        padding: 10px;
    }
    
    .table {
        font-size: 10pt;
        border-collapse: collapse;
    }
    
    .table th, .table td {
        border: 1px solid #ddd;
    }
    
    .container {
        width: 100%;
        max-width: 100%;
        padding: 0;
        margin: 0;
    }
    
    .order-details, .delivery-info {
        border: 1px solid #ddd;
        padding: 10px;
        background-color: white;
        border-left: 2px solid #333;
    }
    
    .badge {
        border: 1px solid #ddd;
        color: black !important;
        background-color: white !important;
    }
    
    .fa-check-circle {
        display: none;
    }
    
    h4, h5 {
        font-size: 14pt;
        margin: 10px 0;
    }
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h3 class="card-title mb-0">Order Confirmation</h3>
                    </div>
                    <div class="card-body">
                        <div class="text-center mb-4">
                            <i class="fa fa-check-circle text-success" style="font-size: 64px;"></i>
                            <h4 class="mt-3">Thank you for your order!</h4>
                            <p class="lead">Your order has been received and is being processed.</p>
                        </div>

                        <div class="order-details">
                            <h5>Order Details</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <p><strong>Order Number:</strong> <asp:Label ID="lblOrderId" runat="server" /></p>
                                    <p><strong>Order Date:</strong> <asp:Label ID="lblOrderDate" runat="server" /></p>
                                    <p><strong>Payment Method:</strong> <asp:Label ID="lblPaymentMethod" runat="server" /></p>
                                </div>
                                <div class="col-md-6">
                                    <p><strong>Order Status:</strong> <asp:Label ID="lblOrderStatus" runat="server" CssClass="badge bg-warning" /></p>
                                    <p><strong>Payment Status:</strong> <asp:Label ID="lblPaymentStatus" runat="server" CssClass="badge bg-warning" /></p>
                                    <p><strong>Total Amount:</strong> <asp:Label ID="lblTotalAmount" runat="server" CssClass="fw-bold" /></p>
                                </div>
                            </div>
                        </div>

                        <div class="delivery-info mt-4">
                            <h5>Delivery Information</h5>
                            <p><strong>Delivery Address:</strong> <asp:Label ID="lblDeliveryAddress" runat="server" /></p>
                            <p><strong>Contact Phone:</strong> <asp:Label ID="lblContactPhone" runat="server" /></p>
                            <p><strong>Order Notes:</strong> <asp:Label ID="lblNotes" runat="server" /></p>
                        </div>

                        <h5 class="mt-4">Order Items</h5>
                        <div class="table-responsive">
                            <asp:Repeater ID="rptOrderItems" runat="server">
                                <HeaderTemplate>
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Item</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>Subtotal</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("ProductName") %></td>
                                        <td>$<%# Eval("Price", "{0:0.00}") %></td>
                                        <td><%# Eval("Quantity") %></td>
                                        <td>$<%# Eval("Subtotal", "{0:0.00}") %></td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                        </tbody>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>

                        <div class="text-center mt-4">
                            <asp:HyperLink ID="lnkTrackOrder" runat="server" CssClass="btn btn-primary me-2">
                                <i class="fa fa-truck me-1"></i> Track Your Order
                            </asp:HyperLink>
                            <asp:HyperLink ID="lnkMenu" NavigateUrl="~/FoodListing.aspx" runat="server" CssClass="btn btn-outline-secondary">
                                <i class="fa fa-utensils me-1"></i> Continue Shopping
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>