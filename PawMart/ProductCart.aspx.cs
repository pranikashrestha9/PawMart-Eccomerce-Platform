using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using PawMart.Models;
using PawMart.service;
using PawMart.Services;

namespace PawMart
{
    public partial class ProductCart : System.Web.UI.Page  // Changed from 'Cart' to 'FoodCart' to match ASPX
    {
        private CartService _cartService;
        private ProductService _productService;

        protected void Page_Load(object sender, EventArgs e)
        {
            _cartService = new CartService();
            _productService = new ProductService();

            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            User currentUser = (User)Session["User"];

            // Get cart from session
            List<CartItemViewModel> cartItems = _cartService.GetCartItemsWithDetails(currentUser.UserID);  // Changed from 'userID' to '1' for testing

            if (cartItems == null || cartItems.Count == 0)
            {
                pnlEmptyCart.Visible = true;
                rptCartItems.Visible = false;
            }
            else
            {
                pnlEmptyCart.Visible = false;
                rptCartItems.DataSource = cartItems;
                rptCartItems.DataBind();

                // Calculate and display total
                decimal cartTotal = CalculateCartTotal(cartItems);
                var footer = rptCartItems.Controls[rptCartItems.Controls.Count - 1] as RepeaterItem;
                Literal litCartTotal = footer?.FindControl("litCartTotal") as Literal;
                if (litCartTotal != null)
                {
                    litCartTotal.Text = cartTotal.ToString("0.00");
                }
            }
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

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int cartItemId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "DecreaseQuantity":
                    _cartService.UpdateQuantity(cartItemId, -1);
                    break;

                case "IncreaseQuantity":
                    _cartService.UpdateQuantity(cartItemId, +1);
                    break;

                case "RemoveItem":
                    _cartService.DeleteCartItem(cartItemId);
                    break;
            }

            LoadCartItems();
        }

        private void DecreaseItemQuantity(List<CartItem> cartItems, int cartItemId)
        {
            var item = cartItems.Find(i => i.CartItemID == cartItemId);
            if (item != null)
            {
                if (item.Quantity > 1)
                {
                    item.Quantity--;
                }
                else
                {
                    cartItems.Remove(item);
                }
            }
        }

        private void IncreaseItemQuantity(List<CartItem> cartItems, int cartItemId)
        {
            var item = cartItems.Find(i => i.ProductItemID == cartItemId);
            if (item != null)
            {
                item.Quantity++;
            }
        }

        private void RemoveCartItem(List<CartItem> cartItems, int cartItemId)
        {
            var item = cartItems.Find(i => i.ProductItemID == cartItemId);  // Changed from FoodID to FoodItemId for consistency
            if (item != null)
            {
                cartItems.Remove(item);
            }
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductListing.aspx");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Checkout.aspx");
        }
    }
}