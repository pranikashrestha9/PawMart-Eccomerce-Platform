<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="PawMart.OrderStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
  /* ========== BASE STYLES ========== */
.order-tracking-container {
    margin: 3rem 0;
}

.card-header.bg-primary {
    padding: 1.25rem 1.75rem;
    border-radius: 0.5rem 0.5rem 0 0;
}

.status-icon {
    margin-right: 1.25rem;
    display: flex;
    align-items: center;
    justify-content: center;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: rgba(13, 110, 253, 0.1);
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

/* ========== TRACKING PROGRESS ========== */
.tracking-progress {
    height: 6px;
    background-color: #e9ecef;
    margin-bottom: 3rem;
    border-radius: 3px;
}

.progress {
    height: 6px !important;
    border-radius: 3px;
    overflow: hidden;
}

.tracking-steps {
    display: flex;
    justify-content: space-between;
    position: relative;
    padding: 0 10px;
    margin-top: 20px;
}

.tracking-step {
    text-align: center;
    position: relative;
    z-index: 2;
    flex: 1;
    padding: 0 5px;
}

.tracking-icon {
    width: 45px;
    height: 45px;
    line-height: 42px;
    background-color: #f8f9fa;
    border-radius: 50%;
    margin: 0 auto 2rem;
    border: 2px solid #dee2e6;
    position: relative;
    top: -25px;
    color: #6c757d;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
}

.tracking-step.active .tracking-icon {
    background-color: #0d6efd;
    color: white;
    border-color: #0d6efd;
    transform: scale(1.1);
    box-shadow: 0 0 15px rgba(13, 110, 253, 0.4);
}

.tracking-step.completed .tracking-icon {
    background-color: #198754;
    color: white;
    border-color: #198754;
}

.tracking-label {
    font-size: 0.875rem;
    font-weight: 500;
    color: #495057;
    position: absolute;
    width: 100%;
    left: 0;
    top: 30px;
    text-align: center;
}

/* ========== TIMELINE STYLES ========== */
.order-timeline {
    display: flex;
    flex-direction: column;
    margin-left: 1.5rem;
    border-left: 2px solid #dee2e6;
    padding: 1.5rem 0;
    position: relative;
}

.timeline-item {
    position: relative;
    padding-left: 2rem;
    margin-bottom: 2rem;
}

.custom{
    padding-top:45px;
    display: flex;
    overflow-x: auto;
    padding-bottom: 1.5rem;
}

.timeline-item:last-child {
    margin-bottom: 0;
}

.timeline-item-dot {
    position: absolute;
    width: 16px;
    height: 16px;
    background-color: #0d6efd;
    border-radius: 50%;
    left: -9px;
    top: 6px;
    box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.2);
}

.timeline-item-content {
    background-color: #f8f9fa;
    padding: 1.25rem;
    border-radius: 0.5rem;
    box-shadow: 0 0.125rem 0.375rem rgba(0, 0, 0, 0.08);
    transition: transform 0.3s ease;
}

.timeline-item-content:hover {
    transform: translateY(-3px);
    box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.12);
}

.timeline-item-title {
    font-weight: 600;
    color: #212529;
    margin-bottom: 0.5rem;
}

.timeline-item-date {
    color: #6c757d;
    font-size: 0.875rem;
    margin-bottom: 0.75rem;
}

.timeline-item-text {
    color: #495057;
    font-size: 0.9rem;
    line-height: 1.5;
}

/* ========== DELIVERY INFO ========== */
.delivery-info {
    margin-bottom: 2.5rem;
    padding: 1.75rem;
    background-color: #f8f9fa;
    border-radius: 0.5rem;
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    border-left: 4px solid #0d6efd;
}

.delivery-info h5 {
    margin-bottom: 1.25rem;
    color: #212529;
    font-weight: 600;
}

/* ========== ORDER ITEMS TABLE ========== */
.order-items-table {
    width: 100%;
    margin-top: 1.5rem;
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 0.5rem;
    overflow: hidden;
}

.table {
    border-radius: 0.5rem;
    overflow: hidden;
    border: 1px solid #dee2e6;
}

.table th {
    background-color: #f1f3f5;
    padding: 1rem;
    text-align: left;
    border-bottom: 2px solid #dee2e6;
    font-weight: 600;
}

.table td {
    padding: 0.875rem 1rem;
    border-bottom: 1px solid #dee2e6;
    vertical-align: middle;
}

/* ========== BUTTONS ========== */
.btn {
    padding: 0.5rem 1.25rem;
    font-weight: 500;
    border-radius: 0.375rem;
    transition: all 0.3s ease;
}

.btn-primary {
    box-shadow: 0 0.125rem 0.25rem rgba(13, 110, 253, 0.2);
}

.btn-primary:hover {
    box-shadow: 0 0.25rem 0.5rem rgba(13, 110, 253, 0.3);
    transform: translateY(-2px);
}

.btn-outline-secondary:hover {
    transform: translateY(-2px);
}

/* ========== RESPONSIVE ADJUSTMENTS ========== */
@media (max-width: 768px) {
    .card-body {
        padding: 1.25rem;
    }

    .delivery-info .row > div {
        margin-bottom: 1.75rem;
    }

    .delivery-info .row > div:last-child {
        margin-bottom: 0;
    }

    .tracking-steps {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        gap: 2rem 1rem;
        margin-top: 1.5rem;
    }

    .tracking-step {
        flex: none;
        margin-bottom: 0;
    }

    .tracking-icon {
        margin-bottom: 1rem;
    }

    .tracking-label {
        position: static;
        margin-top: 0.5rem;
    }

    .timeline-item {
        padding-left: 1.5rem;
    }

    .status-icon {
        margin-right: 1rem;
        width: 40px;
        height: 40px;
    }
}

@media (max-width: 576px) {
    .tracking-steps {
        grid-template-columns: 1fr;
    }

    .card-header.bg-primary {
        padding: 1rem 1.25rem;
    }

    .delivery-info {
        padding: 1.25rem;
    }

    .timeline-item-content {
        padding: 1rem;
    }
}

/* Fix for overlapping issue with status labels */
.tracking-icon i {
    font-size: 1.25rem;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container mt-5">
        <div class="row">
            <div class="col-md-10 mx-auto">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="card-title mb-0">Track Your Order</h3>
                    </div>
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h5>Order #<asp:Label ID="lblOrderId" runat="server" /></h5>
                                <p class="text-muted">Placed on <asp:Label ID="lblOrderDate" runat="server" /></p>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <h5>Total: <asp:Label ID="lblTotalAmount" runat="server" CssClass="fw-bold" /></h5>
                                <p>
                                    <span class="me-2">Payment Method: <asp:Label ID="lblPaymentMethod" runat="server" /></span>
                                    <asp:Label ID="lblPaymentStatus" runat="server" CssClass="badge bg-warning" />
                                </p>
                            </div>
                        </div>

                        <!-- Order Tracking Progress -->
                        <div class="order-tracking-container mb-4">
                            <div class="progress" style="height: 5px;">
                                <div class="progress-bar" role="progressbar" id="trackingProgressBar" runat="server" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <div class="tracking-steps custom">
                                <div class="tracking-step" id="stepOrdered" runat="server">
                                    <div class="tracking-icon">
                                        <i class="fa fa-check-circle"></i>
                                    </div>
                                    <div class="tracking-label">Ordered</div>
                                </div>
                                <div class="tracking-step" id="stepProcessing" runat="server">
                                    <div class="tracking-icon">
                                        <i class="fa fa-cog"></i>
                                    </div>
                                    <div class="tracking-label">Processing</div>
                                </div>
                                <div class="tracking-step" id="stepOutForDelivery" runat="server">
                                    <div class="tracking-icon">
                                        <i class="fa fa-truck"></i>
                                    </div>
                                    <div class="tracking-label">Out for Delivery</div>
                                </div>
                                <div class="tracking-step" id="stepDelivered" runat="server">
                                    <div class="tracking-icon">
                                        <i class="fa fa-home"></i>
                                    </div>
                                    <div class="tracking-label">Delivered</div>
                                </div>
                            </div>
                        </div>

                        <div class="delivery-info mb-4">
                            <div class="row">
                                <div class="col-md-6">
                                    <h5>Delivery Details</h5>
                                    <p><strong>Address:</strong> <asp:Label ID="lblDeliveryAddress" runat="server" /></p>
                                    <p><strong>Phone:</strong> <asp:Label ID="lblContactPhone" runat="server" /></p>
                                </div>
                                <div class="col-md-6">
                                    <h5>Current Status</h5>
                                    <div class="d-flex align-items-center">
                                        <div class="status-icon me-3">
                                            <i id="currentStatusIcon" runat="server" class="fa fa-clock fa-2x text-primary"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-0"><asp:Label ID="lblOrderStatus" runat="server" /></h5>
                                            <p class="text-muted mb-0"><asp:Label ID="lblStatusDescription" runat="server" /></p>
                                            <p class="text-muted mb-0">Last Updated: <asp:Label ID="lblLastUpdated" runat="server" /></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Order Status Timeline -->
                        <h5>Order Timeline</h5>
                        <div class="order-timeline">
                            <asp:Repeater ID="rptStatusUpdates" runat="server">
                                <ItemTemplate>
                                    <div class="timeline-item">
                                        <div class="timeline-item-dot"></div>
                                        <div class="timeline-item-content">
                                            <div class="timeline-item-title"><%# Eval("OrderStatus") %></div>
                                            <div class="timeline-item-date"><%# Eval("UpdatedDate", "{0:MMM dd, yyyy hh:mm tt}") %></div>
                                            <div class="timeline-item-text"><%# Eval("Description") %></div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
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
                            <asp:Button ID="btnRefresh" runat="server" Text="Refresh Status" CssClass="btn btn-primary me-2" OnClick="btnRefresh_Click" />
                            <asp:HyperLink ID="lnkMyOrders" NavigateUrl="~/MyOrder.aspx" runat="server" CssClass="btn btn-outline-secondary">
                                View All Orders
                            </asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>