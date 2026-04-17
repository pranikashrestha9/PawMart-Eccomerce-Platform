using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using PawMart.Models;
using PawMart.Repository;
using PawMart.service;
using PawMart.Services;
using Org.BouncyCastle.Bcpg;

namespace PawMart
{
    public partial class AllOrders : System.Web.UI.Page
    {
        private OrderService _orderService;
        private UserService _userService;

        protected void Page_Load(object sender, EventArgs e)
        {
            _orderService = new OrderService();
            _userService = new UserService();

            if (!IsPostBack)
            {
                LoadAllOrders();
            }
        }

        private void LoadAllOrders()
        {
            try
            {
                // Fetch all orders with user details
                List<OrderViewModel> allOrders = _orderService.GetAllOrdersWithUserDetails();

                gvAllOrders.DataSource = allOrders;
                gvAllOrders.DataBind();
            }
            catch (Exception ex)
            {
                // Log error and show user-friendly message
                ShowErrorMessage("Unable to load orders. Please try again later.");
            }
        }

        protected void gvAllOrders_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAllOrders.PageIndex = e.NewPageIndex;
            LoadAllOrders();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearchOrder.Text.Trim();

            try
            {
                List<OrderViewModel> filteredOrders = _orderService.SearchOrders(searchTerm);

                gvAllOrders.DataSource = filteredOrders;
                gvAllOrders.DataBind();
            }
            catch (Exception ex)
            {
                ShowErrorMessage("Search failed. Please try again.");
            }
        }

        protected void gvAllOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewOrder" || e.CommandName == "UpdateStatus")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                hfCurrentOrderId.Value = orderId.ToString();
                LoadOrderDetails(orderId);

                // Display the modal
                orderDetailsModal.Style["display"] = "flex";
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowModal", "showModal();", true);
            }
        }

        private void LoadOrderDetails(int orderId)
        {
            var orderDetails = _orderService.GetOrderDetails(orderId);
            
            var userDetails = _userService.GetUserById(orderDetails.UserID);

            // Set order summary details
            litOrderId.Text = orderDetails.OrderID.ToString();
            litOrderDate.Text = orderDetails.OrderDate.ToString("dd MMM yyyy");
            litOrderStatus.Text = $"<span class='status-badge status-{orderDetails.OrderStatus.ToLower()}'>{orderDetails.OrderStatus}</span>";
            litPaymentMethod.Text = orderDetails.PaymentMethod;
            litPaymentStatus.Text = $"<span class='status-badge status-{orderDetails.PaymentStatus.ToLower()}'>{orderDetails.PaymentStatus}</span>";

            // Set customer details
            litCustomerName.Text = userDetails.FullName;
            litEmail.Text = userDetails.Email;
            litPhone.Text = userDetails.Phone;
            litAddress.Text = userDetails.Address;

            // Set current dropdown value to match order status
            ddlOrderStatus.SelectedValue = orderDetails.OrderStatus;

            // Load order items
            gvOrderItems.DataSource = _orderService.GetOrderedItemsByOrderId(orderId);
            gvOrderItems.DataBind();
        }

        private void LoadOrders()
        {
            gvAllOrders.DataSource = _orderService.GetAllOrdersWithUserDetails();
            gvAllOrders.DataBind();
        }
        protected void btnCloseModal_Click(object sender, EventArgs e)
        {
            orderDetailsModal.Style["display"] = "none";
            ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", "closeModal();", true);
        }

        protected void btnSaveStatus_Click(object sender, EventArgs e)
        {
            int orderId = Convert.ToInt32(hfCurrentOrderId.Value);
            string newStatus = ddlOrderStatus.SelectedValue;

            // Update the order status
            bool result = _orderService.UpdateOrderStatus(orderId, newStatus);

            if (result)
            {
                // Reload the grid and close the modal
                LoadOrders();
                orderDetailsModal.Style["display"] = "none";
                ScriptManager.RegisterStartupScript(this, GetType(), "CloseModal", "closeModal(); alert('Order status updated successfully!');", true);
            }
            else
            {
                // Show error message
                ScriptManager.RegisterStartupScript(this, GetType(), "ShowError", "alert('Failed to update order status. Please try again.');", true);
            }
        }

        private void ShowErrorMessage(string message)
        {
            // You could implement this to show error in a label or using a modal
            // For now, we'll just redirect to an error page
            Session["ErrorMessage"] = message;
            Response.Redirect("~/Admin/ErrorPage.aspx");
        }

        public bool UpdateOrderStatus(int orderId, string newStatus)
        {
         

            // You could add validation such as:
            if (string.IsNullOrWhiteSpace(newStatus))
            {
                return false;
            }

            // Validate if the status value is valid
            string[] validStatuses = { "Pending", "processing", "out for delivery","Delivered", "Cancelled" };
            bool isValidStatus = false;

            foreach (string status in validStatuses)
            {
                if (status.Equals(newStatus))
                {
                    isValidStatus = true;
                    break;
                }
            }

            if (!isValidStatus)
            {
                return false;
            }

            // Update the status in the database
            return _orderService.UpdateOrderStatus(orderId, newStatus);
        }
    }
}