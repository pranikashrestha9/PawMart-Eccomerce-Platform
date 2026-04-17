using System;
using System.Collections.Generic;
using PawMart.Models;
using PawMart.service;
using PawMart.Services;
using PawMart.Utility;


namespace PawMart
{
    public partial class Checkout : System.Web.UI.Page
    {
        private CartService _cartService;
        private OrderService _orderService;
        private UserService _userService;

        protected void Page_Load(object sender, EventArgs e)
        {
            _cartService = new CartService();
            _orderService = new OrderService();
            _userService = new UserService();

            if (!IsPostBack)
            {
                LoadOrderSummary();
                LoadUserData();
            }
        }
        private void LoadUserData()
        {
            User currentUser = (User)Session["User"];

            // If we need fresh data from database (optional)
            // currentUser = _userService.GetUserById(currentUser.UserID);

            if (currentUser != null)
            {
                txtFullName.Text = currentUser.FullName;
                txtEmail.Text = currentUser.Email;
                txtPhone.Text = currentUser.Phone;

                // If user has a default address stored
                if (!string.IsNullOrEmpty(currentUser.Address))
                {
                    txtAddress.Text = currentUser.Address;
                }
            }
        }   
        private void LoadOrderSummary()
        {
            User currentUser = (User)Session["User"];
            List<CartItemViewModel> cartItems = _cartService.GetCartItemsWithDetails(currentUser.UserID);

            if (cartItems == null || cartItems.Count == 0)
            {
                // Redirect to cart if no items
                Response.Redirect("FoodCart.aspx");
                return;
            }

            // Bind cart items to repeater
            rptOrderItems.DataSource = cartItems;
            rptOrderItems.DataBind();

            // Calculate and display total
            decimal total = CalculateCartTotal(cartItems);
            lblTotalAmount.Text = $"${total:0.00}";
        }

        private decimal CalculateCartTotal(List<CartItemViewModel> cartItems)
        {
            decimal total = 0;
            foreach (var item in cartItems)
            {
                total += item.Price * item.Quantity;
            }
            return total;
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            // Validate input
            if (!ValidateCheckoutForm())
            {
                return;
            }

            User currentUser = (User)Session["User"];
            List<CartItemViewModel> cartItems = _cartService.GetCartItemsWithDetails(currentUser.UserID);

            // Create Order
            Order newOrder = new Order
            {
                UserID = currentUser.UserID,
                OrderDate = DateTime.Now,
                TotalAmount = CalculateCartTotal(cartItems),
                OrderStatus = "Pending",
                PaymentMethod = hdnPaymentMethod.Value,
                PaymentStatus = "Pending",
                DeliveryAddress = txtAddress.Text,
                DeliveryDate = DateTime.Now.AddDays(1),
                ContactPhone = txtPhone.Text,
                Notes = txtNotes.Text
            };

            // Create OrderItems
            List<OrderItem> orderItems = new List<OrderItem>();
            foreach (var cartItem in cartItems)
            {
                orderItems.Add(new OrderItem
                {
                    ProductItemID = cartItem.ProductID,
                    Quantity = cartItem.Quantity,
                    Price = cartItem.Price,
                    Subtotal = cartItem.Price * cartItem.Quantity
                });
            }

            // Save Order
            int orderId = _orderService.CreateOrder(newOrder, orderItems);
           
          
            // Clear cart
            _cartService.ClearCart(currentUser.UserID);
            EmailHelper.SendOrderConfirmationEmail(currentUser.Email, newOrder);
            // Redirect to order confirmation
            Response.Redirect($"OrderConfirmation.aspx?OrderID={orderId}");
        }

        private bool ValidateCheckoutForm()
        {
            bool isValid = true;

            // Basic validation
            if (string.IsNullOrWhiteSpace(txtFullName.Text))
            {
                // You might want to add client-side error display
                isValid = false;
            }

            if (string.IsNullOrWhiteSpace(hdnPaymentMethod.Value))
            {
                // Ensure payment method is selected
                isValid = false;
            }

            return isValid;
        }
    }
}