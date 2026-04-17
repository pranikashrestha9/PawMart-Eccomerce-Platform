<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="MyOrder.aspx.cs" Inherits="PawMart.MyOrders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
.order-card {
    background: #fff;
    border: 1px solid #e8e8e8;
    border-radius: 12px;
    margin-bottom: 12px;
    overflow: hidden;
    transition: border-color .15s;
}
.order-card:hover { border-color: #ccc; }

.card-top {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 14px 18px;
    gap: 12px;
    flex-wrap: wrap;
}
.order-id { font-size: 14px; font-weight: 600; }
.order-date { font-size: 12px; color: #888; margin-top: 2px; }

.meta-row {
    display: flex;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
}
.meta-item { display: flex; flex-direction: column; gap: 2px; }
.meta-label { font-size: 11px; color: #aaa; text-transform: uppercase; letter-spacing: .04em; }
.meta-value { font-size: 13px; font-weight: 500; }

.status-badge {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 500;
}
.badge-pending    { background: #FFF3CD; color: #856404; }
.badge-processing { background: #D1ECF1; color: #0C5460; }
.badge-delivery   { background: #CCE5FF; color: #004085; }
.badge-delivered  { background: #D4EDDA; color: #155724; }
.badge-cancelled  { background: #E2E3E5; color: #383D41; }

.card-actions {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-left: auto;
}
.btn-track {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 7px 14px;
    border-radius: 8px;
    font-size: 13px;
    background: #e8f0fe;
    color: #1a56db;
    border: 1px solid #c7d7fc;
    text-decoration: none;
    cursor: pointer;
    transition: opacity .15s;
}
.btn-track:hover { opacity: .85; }

.btn-expand {
    background: none;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    color: #888;
    cursor: pointer;
    font-size: 18px;
    padding: 4px 10px;
    line-height: 1;
    transition: background .1s;
}
.btn-expand:hover { background: #f5f5f5; }

/* Expandable detail panel */
.card-detail { border-top: 1px solid #f0f0f0; display: none; }
.card-detail.open { display: block; }

.detail-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    border-bottom: 1px solid #f0f0f0;
}
.detail-section { padding: 16px 18px; }
.detail-section:first-child { border-right: 1px solid #f0f0f0; }
.detail-section h3 {
    font-size: 11px;
    font-weight: 600;
    color: #aaa;
    text-transform: uppercase;
    letter-spacing: .04em;
    margin-bottom: 10px;
}
.detail-row {
    display: flex;
    justify-content: space-between;
    font-size: 13px;
    margin-bottom: 6px;
}
.detail-row span:first-child { color: #888; }

.items-section { padding: 16px 18px; }
.items-section h3 {
    font-size: 11px;
    font-weight: 600;
    color: #aaa;
    text-transform: uppercase;
    letter-spacing: .04em;
    margin-bottom: 10px;
}
.item-row {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 8px 0;
    border-bottom: 1px solid #f5f5f5;
}
.item-row:last-child { border-bottom: none; }
.item-img {
    width: 44px; height: 44px;
    border-radius: 8px;
    background: #f5f5f5;
    overflow: hidden;
    flex-shrink: 0;
}
.item-img img { width: 100%; height: 100%; object-fit: cover; }
.item-name { font-size: 13px; font-weight: 500; }
.item-qty { font-size: 12px; color: #888; }
.item-sub { font-size: 13px; font-weight: 600; margin-left: auto; }

.total-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 18px;
    background: #f8f9fa;
    font-size: 14px;
    font-weight: 600;
}

.empty-orders {
    text-align: center;
    padding: 48px 20px;
    background: #f8f9fa;
    border-radius: 12px;
    color: #888;
}
.empty-orders i { font-size: 40px; display: block; margin-bottom: 12px; }
.review-btn {
    padding: 6px 12px;
    font-size: 12px;
    border-radius: 6px;
    background: transparent;
    border: 1px solid #ff6b6b;
    color: #ff6b6b;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 4px;
    transition: 0.2s ease;
    margin-left: 8px;
    text-decoration: none;
}

.review-btn:hover {
    background: #ff6b6b;
    color: white;
}

@media (max-width: 640px) {
    .detail-grid { grid-template-columns: 1fr; }
    .detail-section:first-child { border-right: none; border-bottom: 1px solid #f0f0f0; }
    .card-top { flex-direction: column; align-items: flex-start; }
    .card-actions { margin-left: 0; }
}
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-danger">
    <asp:Label ID="lblMessage" runat="server"></asp:Label>
</asp:Panel>
<div class="container py-4" style="max-width:860px">

    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h2 class="mb-0" style="font-size:20px;font-weight:500">My orders</h2>
        <div class="d-flex gap-2 flex-wrap">
            <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select form-select-sm"
                AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                <asp:ListItem Text="All orders" Value="" Selected="True" />
                <asp:ListItem Text="Pending" Value="Pending" />
                <asp:ListItem Text="Processing" Value="Processing" />
                <asp:ListItem Text="Out for delivery" Value="Delivery" />
                <asp:ListItem Text="Delivered" Value="Delivered" />
                <asp:ListItem Text="Cancelled" Value="Cancelled" />
            </asp:DropDownList>
            <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-select form-select-sm"
                AutoPostBack="true" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                <asp:ListItem Text="Newest first" Value="DateDesc" Selected="True" />
                <asp:ListItem Text="Oldest first" Value="DateAsc" />
                <asp:ListItem Text="Amount (high to low)" Value="AmountDesc" />
                <asp:ListItem Text="Amount (low to high)" Value="AmountAsc" />
            </asp:DropDownList>
        </div>
    </div>

    <asp:Panel ID="pnlNoOrders" runat="server" CssClass="empty-orders" Visible="false">
        <i class="fa fa-box-open"></i>
        <h5 class="mb-2">No orders found</h5>
        <p class="mb-3 text-muted" style="font-size:13px">You haven't placed any orders yet.</p>
        <asp:HyperLink ID="lnkBrowseMenu" NavigateUrl="~/ProductListing.aspx" runat="server"
            CssClass="btn btn-primary btn-sm">Browse products</asp:HyperLink>
    </asp:Panel>

    <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
        <ItemTemplate>
            <div class="order-card">

                <%-- Top row: ID + date | meta | actions --%>
                <div class="card-top">
                    <div>
                        <div class="order-id">Order #<%# Eval("OrderID") %></div>
                        <div class="order-date"><%# GetFormattedDate(Eval("OrderDate")) %></div>
                    </div>

                    <div class="meta-row">
                        <div class="meta-item">
                            <span class="meta-label">Status</span>
                            <span class='status-badge badge-<%# GetStatusClass(Eval("OrderStatus").ToString()) %>'>
                                <%# GetFormattedStatus(Eval("OrderStatus").ToString()) %>
                            </span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">Total</span>
                            <span class="meta-value">$<%# Eval("TotalAmount", "{0:0.00}") %></span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">Items</span>
                            <span class="meta-value"><%# GetItemCount(Eval("OrderID")) %></span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">Payment</span>
                            <span class="meta-value"><%# Eval("PaymentMethod") %></span>
                        </div>
                    </div>

                    <div class="card-actions">
                        <asp:LinkButton ID="btnTrack" runat="server" CssClass="btn-track"
                            CommandName="Track" CommandArgument='<%# Eval("OrderID") %>'>
                            <i class="fa fa-truck"></i> Track
                        </asp:LinkButton>
                        <button type="button" class="btn-expand"
                            onclick="toggleDetail('detail-<%# Eval("OrderID") %>', this)"
                            aria-expanded="false">&#9662;</button>
                    </div>
                </div>

                <%-- Expandable detail panel (no modal, no duplicate buttons) --%>
                <div class="card-detail" id="detail-<%# Eval("OrderID") %>">

                    <div class="detail-grid">
                        <div class="detail-section">
                            <h3>Order info</h3>
                            <div class="detail-row">
                                <span>Payment method</span>
                                <span><%# Eval("PaymentMethod") %></span>
                            </div>
                            <div class="detail-row">
                                <span>Payment status</span>
                                <span><%# Eval("PaymentStatus") %></span>
                            </div>
                        </div>
                        <div class="detail-section">
                            <h3>Delivery info</h3>
                            <div class="detail-row">
                                <span>Address</span>
                                <span><%# Eval("DeliveryAddress") %></span>
                            </div>
                            <div class="detail-row">
                                <span>Contact</span>
                                <span><%# Eval("ContactPhone") %></span>
                            </div>
                            <div class="detail-row">
                                <span>Notes</span>
                                <span><%# String.IsNullOrEmpty(Eval("Notes").ToString()) ? "—" : Eval("Notes") %></span>
                            </div>
                        </div>
                    </div>

                    <div class="items-section">
                        <h3>Items</h3>
                        <asp:Repeater ID="rptOrderItems" runat="server" OnItemCommand="rptOrderItems_ItemCommand">
                            <ItemTemplate>
                                <div class="item-row">
                                    <div class="item-img">
                                        <img src='<%# ResolveUrl(Eval("ProductImage").ToString()) %>'
                                             alt='<%# Eval("ProductName") %>'
                                             onerror="this.src='<%# ResolveUrl("~/Images/default-food.jpg") %>';" />
                                    </div>
                                    <div>
                                        <div class="item-name"><%# Eval("ProductName") %></div>
                                        <div class="item-qty">$<%# Eval("Price", "{0:0.00}") %> × <%# Eval("Quantity") %></div>
                                    </div>
                                    <div class="item-sub">$<%# Eval("Subtotal", "{0:0.00}") %></div>
                                  <asp:LinkButton 
    ID="btnReview" 
    runat="server"
    CssClass="review-btn"
    CommandName="Review"
    CommandArgument='<%# Eval("ProductItemID") + "," + Eval("OrderID") %>'>
    Review
</asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="total-bar">
                        <span>Total</span>
                        <span>$<%# Eval("TotalAmount", "{0:0.00}") %></span>
                    </div>
                </div>

            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>

<script>
function toggleDetail(id, btn) {
    var panel = document.getElementById(id);
    var open = panel.classList.toggle('open');
    btn.innerHTML = open ? '&#9652;' : '&#9662;';
    btn.setAttribute('aria-expanded', open);
}
</script>
</asp:Content>