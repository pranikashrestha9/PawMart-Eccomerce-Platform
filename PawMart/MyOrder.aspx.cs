using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PawMart.Services;
using PawMart.Models;
using PawMart.Service;

namespace PawMart
{
    public partial class MyOrders : System.Web.UI.Page
    {
        private OrderService _orderService;
        private int _userId;
        private Dictionary<int, List<OrderItemViewModel>> _orderItemsCache;

        protected void Page_Load(object sender, EventArgs e)
        {
            _orderService = new OrderService();
            _orderItemsCache = new Dictionary<int, List<OrderItemViewModel>>();

            // Check if user is logged in
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            _userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                rptOrders.ItemDataBound += RptOrders_ItemDataBound;
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            string statusFilter = ddlStatusFilter.SelectedValue;
            string sortBy = ddlSortBy.SelectedValue;
            User currentUser = (User)Session["User"];

            List<OrderDetailViewModel> orders = _orderService.GetUserFilteredOrders(currentUser.UserID, statusFilter, sortBy);

            if (orders != null && orders.Count > 0)
            {
                rptOrders.DataSource = orders;
                rptOrders.DataBind();
                pnlNoOrders.Visible = false;
            }
            else
            {
                rptOrders.DataSource = null;
                rptOrders.DataBind();
                pnlNoOrders.Visible = true;
            }
        }

      
        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadOrders();
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadOrders();
        }

        protected string GetFormattedDate(object date)
        {
            if (date != null && date is DateTime)
            {
                DateTime orderDate = (DateTime)date;
                return orderDate.ToString("MMM dd, yyyy hh:mm tt");
            }
            return string.Empty;
        }

        protected string GetStatusClass(string status)
        {
            switch (status.ToLower())
            {
                case "pending":
                    return "pending";
                case "processing":
                    return "processing";
                case "delivery":
                    return "delivery";
                case "delivered":
                    return "delivered";
                case "cancelled":
                    return "cancelled";
                default:
                    return "pending";
            }
        }

        protected string GetFormattedStatus(string status)
        {
            switch (status.ToLower())
            {
                case "delivery":
                    return "Out for Delivery";
                default:
                    return status;
            }
        }
        private void RptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int orderId = (int)DataBinder.Eval(e.Item.DataItem, "OrderID");
                Repeater rptOrderItems = (Repeater)e.Item.FindControl("rptOrderItems");

                if (rptOrderItems != null)
                {
                    rptOrderItems.DataSource = GetOrderItems(orderId);
                    rptOrderItems.DataBind();
                }
            }
        }

        protected void rptOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Track")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"OrderStatus.aspx?OrderID={orderId}");
            }
            if (e.CommandName == "Review")
            {
                string[] ids = e.CommandArgument.ToString().Split(',');

                int productId = Convert.ToInt32(ids[0]);
                int orderId = Convert.ToInt32(ids[1]);

                Response.Redirect($"Review.aspx?productId={productId}&orderId={orderId}");
            }
        }


        protected int GetItemCount(object orderId)
        {
            if (orderId != null)
            {
                int id = Convert.ToInt32(orderId);
                List<OrderItemViewModel> items = GetOrderItems(id);
                return items.Count;
            }
            return 0;
        }

   

        protected List<OrderItemViewModel> GetOrderItems(int orderId)
        {
            // Check if items are already in cache
            if (!_orderItemsCache.ContainsKey(orderId))
            {
                List<OrderItemViewModel> items = _orderService.GetOrderItems(orderId);
                _orderItemsCache[orderId] = items;
            }

            return _orderItemsCache[orderId];
        }

        protected string GetImagePath(object imagePath)
        {
            if (imagePath != null && !string.IsNullOrWhiteSpace(imagePath.ToString()))
            {
                return "Images/FoodItems/" + imagePath.ToString();
            }
            return "Images/default-food.jpg";
        }
        protected void rptOrderItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Review")
            {
                string[] ids = e.CommandArgument.ToString().Split(',');

                int productId = Convert.ToInt32(ids[0]);
                int orderId = Convert.ToInt32(ids[1]);

                try
                {
                    // optional: pre-check (better UX)
                    var reviewService = new ProductReviewService();

                    // If you don't have this method, skip and rely on catch below
                    Response.Redirect($"Review.aspx?ProductID={productId}&OrderID={orderId}");
                }
                catch (Exception ex)
                {
                    pnlMessage.Visible = true;
                    lblMessage.Text = "⚠️ You have already reviewed this product for this order.";
                }
            }
        }
    }
}
