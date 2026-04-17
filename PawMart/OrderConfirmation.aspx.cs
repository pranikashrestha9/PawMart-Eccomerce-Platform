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
    public partial class OrderConfirmation : System.Web.UI.Page
    {
        private OrderService _orderService;

        protected void Page_Load(object sender, EventArgs e)
        {
            _orderService = new OrderService();

            if (!IsPostBack)
            {
                LoadOrderConfirmation();
            }
        }

        private void LoadOrderConfirmation()
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

                // Get order details with items
                OrderDetailViewModel orderDetails = _orderService.GetOrderDetails(orderId, currentUser.UserID);

                if (orderDetails == null)
                {
                    // Order not found or doesn't belong to current user
                    Response.Redirect("MyOrders.aspx");
                    return;
                }

                // Set order details
                DisplayOrderDetails(orderDetails);
            }
            else
            {
                Response.Redirect("Menu.aspx");
            }
        }

        private void DisplayOrderDetails(OrderDetailViewModel orderDetails)
        {
            // Set basic order information
            lblOrderId.Text = orderDetails.OrderID.ToString();
            lblOrderDate.Text = orderDetails.OrderDate.ToString("MMM dd, yyyy hh:mm tt");
            lblPaymentMethod.Text = orderDetails.PaymentMethod;
            lblOrderStatus.Text = orderDetails.OrderStatus;
            lblPaymentStatus.Text = orderDetails.PaymentStatus;
            lblTotalAmount.Text = $"${orderDetails.TotalAmount:0.00}";
            lblDeliveryAddress.Text = orderDetails.DeliveryAddress;
            lblContactPhone.Text = orderDetails.ContactPhone;
            lblNotes.Text = string.IsNullOrEmpty(orderDetails.Notes) ? "N/A" : orderDetails.Notes;

            // Set status badge colors
            SetStatusBadgeColors(orderDetails.OrderStatus, orderDetails.PaymentStatus);

            // Bind order items
            rptOrderItems.DataSource = orderDetails.OrderItems;
            rptOrderItems.DataBind();

            // Set track order link
            lnkTrackOrder.NavigateUrl = $"~/OrderStatus.aspx?OrderID={orderDetails.OrderID}";
        }

        private void SetStatusBadgeColors(string orderStatus, string paymentStatus)
        {
            // Set order status badge color
            switch (orderStatus.ToLower())
            {
                case "pending":
                    lblOrderStatus.CssClass = "badge bg-warning";
                    break;
                case "processing":
                    lblOrderStatus.CssClass = "badge bg-info";
                    break;
                case "shipped":
                case "out for delivery":
                    lblOrderStatus.CssClass = "badge bg-primary";
                    break;
                case "delivered":
                    lblOrderStatus.CssClass = "badge bg-success";
                    break;
                case "cancelled":
                    lblOrderStatus.CssClass = "badge bg-danger";
                    break;
                default:
                    lblOrderStatus.CssClass = "badge bg-secondary";
                    break;
            }

            // Set payment status badge color
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
    }
}