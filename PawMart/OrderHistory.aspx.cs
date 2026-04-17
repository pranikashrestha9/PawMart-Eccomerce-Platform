using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using PawMart.Models;
using PawMart.Repository;

namespace PawMart
{
    public partial class OrderHistory : System.Web.UI.Page
    {
        private OrderRepository orderRepo = new OrderRepository();
        private int userId;
        private const int PageSize = 5;
        private int currentPage = 1;
        private List<OrderDetailViewModel> allOrders = new List<OrderDetailViewModel>();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Login.aspx?returnUrl=OrderHistory.aspx");
                return;
            }

            userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                // Get page from query string if present
                if (!string.IsNullOrEmpty(Request.QueryString["page"]))
                {
                    int.TryParse(Request.QueryString["page"], out currentPage);
                    if (currentPage < 1) currentPage = 1;
                }

                // Load initial data
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            // Get filter values
            string statusFilter = ddlStatusFilter.SelectedValue;
            string sortOrder = ddlSortOrder.SelectedValue;

            // Get filtered orders
            allOrders = orderRepo.GetFilteredOrdersByUserId(userId, statusFilter, sortOrder);

            // Display no orders message if applicable
            pnlNoOrders.Visible = (allOrders.Count == 0);

            // Calculate pagination
            int totalPages = (int)Math.Ceiling((double)allOrders.Count / PageSize);
            if (currentPage > totalPages && totalPages > 0)
            {
                currentPage = totalPages;
            }

            lblCurrentPage.Text = currentPage.ToString();
            lblTotalPages.Text = totalPages.ToString();

            // Enable/disable pagination buttons
            lnkPrevious.Enabled = (currentPage > 1);
            lnkNext.Enabled = (currentPage < totalPages);

            // Apply pagination
            int startIndex = (currentPage - 1) * PageSize;
            List<OrderDetailViewModel> pagedOrders;

            if (allOrders.Count > 0)
            {
                if (startIndex < allOrders.Count)
                {
                    int count = Math.Min(PageSize, allOrders.Count - startIndex);
                    pagedOrders = allOrders.GetRange(startIndex, count);
                }
                else
                {
                    pagedOrders = new List<OrderDetailViewModel>();
                }
            }
            else
            {
                pagedOrders = new List<OrderDetailViewModel>();
            }

            // Bind to repeater
            rptOrders.DataSource = pagedOrders;
            rptOrders.DataBind();
        }

        protected void ApplyFilters(object sender, EventArgs e)
        {
            // Reset to page 1 when filters change
            currentPage = 1;
            LoadOrders();
        }

        protected void lnkPrevious_Click(object sender, EventArgs e)
        {
            if (currentPage > 1)
            {
                currentPage--;
                LoadOrders();
            }
        }

        protected void lnkNext_Click(object sender, EventArgs e)
        {
            int totalPages = (int)Math.Ceiling((double)allOrders.Count / PageSize);
            if (currentPage < totalPages)
            {
                currentPage++;
                LoadOrders();
            }
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "ViewDetails")
            {
                // Redirect to order details page
                Response.Redirect($"~/OrderDetails.aspx?id={orderId}");
            }
            else if (e.CommandName == "TrackOrder")
            {
                // Redirect to order tracking page
                Response.Redirect($"~/OrderStatus.aspx?id={orderId}");
            }
        }

        protected void btnStartShopping_Click(object sender, EventArgs e)
        {
            // Redirect to menu or home page
            Response.Redirect("~/Menu.aspx");
        }

        // Helper methods for CSS classes
        protected string GetOrderStatusClass(string status)
        {
            // Remove spaces and convert to lowercase for CSS class
            status = status.ToLower().Replace(" ", "");
            return status;
        }

        protected string GetPaymentStatusClass(string status)
        {
            status = status.ToLower().Replace(" ", "");
            return status;
        }

        protected bool IsOrderTrackable(string status)
        {
            // Only show tracking button for orders that are not delivered or cancelled
            return status != "Delivered" && status != "Cancelled";
        }
    }
}