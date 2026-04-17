using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PawMart.Models;
using PawMart.Services;

namespace PawMart
{
    public partial class OrderStatus : System.Web.UI.Page
    {
        private OrderService _orderService;

        protected void Page_Load(object sender, EventArgs e)
        {
            _orderService = new OrderService();

            if (!IsPostBack)
            {
                LoadOrderStatus();
            }
        }

        private void LoadOrderStatus()
        {
            // Get order ID from query string
            if (!string.IsNullOrEmpty(Request.QueryString["OrderID"]) && int.TryParse(Request.QueryString["OrderID"], out int orderId))
            {
                // Get current user
                User currentUser = (User)Session["User"];
                if (currentUser == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Get order details with items and status history
                OrderStatusViewModel orderStatus = _orderService.GetOrderStatusDetails(orderId, currentUser.UserID);

                if (orderStatus == null)
                {
                    // Order not found or doesn't belong to current user
                    Response.Redirect("MyOrders.aspx");
                    return;
                }

                // Display order status
                DisplayOrderStatus(orderStatus);
            }
            else
            {
                Response.Redirect("MyOrders.aspx");
            }
        }

        private void DisplayOrderStatus(OrderStatusViewModel orderStatus)
        {
            // Set basic order information
            lblOrderId.Text = orderStatus.OrderID.ToString();
            lblOrderDate.Text = orderStatus.OrderDate.ToString("MMM dd, yyyy hh:mm tt");
            lblPaymentMethod.Text = orderStatus.PaymentMethod;
            lblPaymentStatus.Text = orderStatus.PaymentStatus;
            lblTotalAmount.Text = $"${orderStatus.TotalAmount:0.00}";
            lblDeliveryAddress.Text = orderStatus.DeliveryAddress;
            lblContactPhone.Text = orderStatus.ContactPhone;
            lblOrderStatus.Text = orderStatus.CurrentStatus;
            lblLastUpdated.Text = orderStatus.LastUpdated.ToString("MMM dd, yyyy hh:mm tt");

            // Set payment status badge color
            SetPaymentStatusBadgeColor(orderStatus.PaymentStatus);

            // Set status description based on current status
            SetStatusDescription(orderStatus.CurrentStatus);

            // Update tracking progress
            UpdateTrackingProgress(orderStatus.CurrentStatus);

            // Bind order items
            rptOrderItems.DataSource = orderStatus.OrderItems;
            rptOrderItems.DataBind();

            // Bind status updates
            rptStatusUpdates.DataSource = orderStatus.StatusUpdates;
            rptStatusUpdates.DataBind();
        }

        private void SetPaymentStatusBadgeColor(string paymentStatus)
        {
            switch (paymentStatus.ToLower())
            {
                case "pending":
                    lblPaymentStatus.CssClass = "badge bg-warning";
                    break;
                case "processing":
                    lblPaymentStatus.CssClass = "badge bg-info";
                    break;
                case "paid":
                case "completed":
                    lblPaymentStatus.CssClass = "badge bg-success";
                    break;
                case "failed":
                case "cancelled":
                    lblPaymentStatus.CssClass = "badge bg-danger";
                    break;
                default:
                    lblPaymentStatus.CssClass = "badge bg-secondary";
                    break;
            }
        }

        private void SetStatusDescription(string status)
        {
            string description = "";
            string iconClass = "fa-clock";

            switch (status.ToLower())
            {
                case "pending":
                    description = "Your order has been received and is awaiting processing.";
                    iconClass = "fa-clock";
                    break;
                case "processing":
                    description = "We're preparing your order in the kitchen.";
                    iconClass = "fa-utensils";
                    break;

                case "out for delivery":
                    description = "Your order is on the way to your location.";
                    iconClass = "fa-truck";
                    break;
                case "delivered":
                    description = "Your order has been delivered successfully. Enjoy your meal!";
                    iconClass = "fa-check-double";
                    break;
                case "cancelled":
                    description = "This order has been cancelled.";
                    iconClass = "fa-times-circle";
                    break;
                default:
                    description = "Status information is being updated.";
                    break;
            }

            lblStatusDescription.Text = description;
            currentStatusIcon.Attributes["class"] = $"fa {iconClass} fa-2x";

            // Set icon color based on status
            if (status.ToLower() == "delivered")
            {
                currentStatusIcon.Attributes["class"] += " text-success";
            }
            else if (status.ToLower() == "cancelled")
            {
                currentStatusIcon.Attributes["class"] += " text-danger";
            }
            else
            {
                currentStatusIcon.Attributes["class"] += " text-primary";
            }
        }

        private void UpdateTrackingProgress(string currentStatus)
        {
            // Reset all steps
            stepOrdered.Attributes["class"] = "tracking-step";
            stepProcessing.Attributes["class"] = "tracking-step";
            stepOutForDelivery.Attributes["class"] = "tracking-step";
            stepDelivered.Attributes["class"] = "tracking-step";

            // Set progress based on current status
            int progressPercentage = 0;
            string lowerStatus = currentStatus.ToLower();

            // Step 1: Ordered - Always completed
            stepOrdered.Attributes["class"] = "tracking-step completed";
            progressPercentage = 25;

            // Step 2: Processing
            if (IsStatusEqualOrBeyond(lowerStatus, "processing"))
            {
                stepProcessing.Attributes["class"] = "tracking-step completed";
                progressPercentage = 50;
            }
            else
            {
                stepProcessing.Attributes["class"] = "tracking-step active";
            }

            // Step 3: Out for Delivery
            if (IsStatusEqualOrBeyond(lowerStatus, "out for delivery"))
            {
                stepOutForDelivery.Attributes["class"] = "tracking-step completed";
                progressPercentage = 75;
            }
            else if (IsStatusEqualOrBeyond(lowerStatus, "processing"))
            {
                stepOutForDelivery.Attributes["class"] = "tracking-step active";
            }

            // Step 4: Delivered
            if (IsStatusEqualOrBeyond(lowerStatus, "delivered"))
            {
                stepDelivered.Attributes["class"] = "tracking-step completed";
                progressPercentage = 100;
            }
            else if (IsStatusEqualOrBeyond(lowerStatus, "out for delivery"))
            {
                stepDelivered.Attributes["class"] = "tracking-step active";
            }

            // If cancelled, show red progress and reset steps
            if (lowerStatus == "cancelled")
            {
                trackingProgressBar.Attributes["class"] = "progress-bar bg-danger";
                // Reset progress to just the first step for cancelled orders
                stepOrdered.Attributes["class"] = "tracking-step completed";
                stepProcessing.Attributes["class"] = "tracking-step";
                stepOutForDelivery.Attributes["class"] = "tracking-step";
                stepDelivered.Attributes["class"] = "tracking-step";
                progressPercentage = 25;
            }
            else
            {
                trackingProgressBar.Attributes["class"] = "progress-bar";
            }

            // Set progress width
            trackingProgressBar.Style["width"] = $"{progressPercentage}%";
            trackingProgressBar.Attributes["aria-valuenow"] = progressPercentage.ToString();
        }

        private bool IsStatusEqualOrBeyond(string currentStatus, string comparedStatus)
        {
            Dictionary<string, int> statusOrder = new Dictionary<string, int>
            {
                { "pending", 1 },
                { "processing", 2 },
                { "out for delivery", 3 },
                { "delivered", 4 },
                { "cancelled", 0 } // Add cancelled with lowest priority
            };

            // Default to 0 if status is not found in the dictionary
            int currentStatusValue = statusOrder.ContainsKey(currentStatus.ToLower()) ? statusOrder[currentStatus.ToLower()] : 0;
            int comparedStatusValue = statusOrder.ContainsKey(comparedStatus.ToLower()) ? statusOrder[comparedStatus.ToLower()] : 0;

            return currentStatusValue >= comparedStatusValue;
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            // Reload order status
            LoadOrderStatus();
        }
        protected string GetTimelineDotClass(string status)
{
    var current = lblOrderStatus.Text.Trim();
    var statuses = new[] { "Pending", "Processing", "Delivery", "Delivered" };
    int currentIdx = Array.IndexOf(statuses, current);
    int itemIdx = Array.IndexOf(statuses, status);
    if (itemIdx < currentIdx) return "done";
    if (itemIdx == currentIdx) return "active";
    return "";
}
    }
}