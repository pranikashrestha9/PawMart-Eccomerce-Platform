using PawMart.Models;
using PawMart.Repositories;
using PawMart.service;
using PawMart.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace PawMart
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        // Services
        private readonly ProductService _productService;
        private readonly CategoryService _categoryService;
        private readonly CartService _cartService;

        // Number of related foods to show
        private const int RelatedFoodsCount = 4;

        // Current food item
        private Product _currentProduct;

        public ProductDetails()
        {
            _productService = new ProductService();
            _categoryService = new CategoryService();
            _cartService = new CartService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get food item ID from URL parameter
                if (!string.IsNullOrEmpty(Request.QueryString["id"]) && int.TryParse(Request.QueryString["id"], out int productItemId))
                {
                    // Load the food item details
                    LoadFoodDetails(productItemId);
                }
                else
                {
                    // Invalid or missing food item ID
                    ShowErrorPanel();
                }
            }
        }

        private void LoadFoodDetails(int foodItemId)
        {
            try
            {
                // Get food item from service
                _currentProduct = _productService.GetProductById(foodItemId);

                if (_currentProduct == null)
                {
                    // Food item not found
                    ShowErrorPanel();
                    return;
                }

                // Show food details panel
                pnlFoodDetails.Visible = true;
                pnlError.Visible = false;

                // Set food details in UI
                PopulateFoodDetails(_currentProduct);

                //// Load related foods
                LoadRelatedFoods(_currentProduct.CategoryID, foodItemId);
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error loading food details: " + ex.Message);
                ShowErrorPanel();
            }
        }

        private void PopulateFoodDetails(Product productItem)
        {
            // Set breadcrumb
            currentProduct.InnerText = productItem.Name;

            // Set food item details
            productName.InnerText = productItem.Name;
            productDescription.InnerText = productItem.Description;

            // Set food image
            string imageUrl = ResolveUrl(productItem.ImageURL);
            imgProduct.ImageUrl = imageUrl;
            imgProduct.AlternateText = productItem.Name;
            imgProduct.Attributes["onerror"] = $"this.src='{ResolveUrl("~/Images/placeholder-food.jpg")}'";

            // Set price information
            if (productItem.DiscountPrice < productItem.Price)
            {
                currentPrice.InnerText = $"${productItem.DiscountPrice:0.00}";
                originalPrice.InnerText = $"${productItem.Price:0.00}";
                pnlOriginalPrice.Visible = true;
                pnlDiscountTag.Visible = true;
            }
            else
            {
                currentPrice.InnerText = $"${productItem.Price:0.00}";
                pnlOriginalPrice.Visible = false;
                pnlDiscountTag.Visible = false;
            }

            // Set availability
            if (productItem.IsAvailable)
            {
                pnlAvailable.Visible = true;
                pnlNotAvailable.Visible = false;
                pnlQuantitySelector.Visible = true;
                btnAddToCart.Enabled = true;
            }
            else
            {
                pnlAvailable.Visible = false;
                pnlNotAvailable.Visible = true;
                pnlQuantitySelector.Visible = false;
                btnAddToCart.Enabled = false;
                btnAddToCart.Text = "Out of Stock";
                btnAddToCart.CssClass = "btn btn-primary disabled";
            }

            // Set featured tag
            pnlFeaturedTag.Visible = productItem.IsFeatured;

            // Set category
            try
            {
                var category = _categoryService.GetCategoryById(productItem.CategoryID);
                if (category != null)
                {
                    productCategory.InnerText = category.Name;
                }
                else
                {
                    productCategory.InnerText = "Uncategorized";
                }
            }
            catch
            {
                productCategory.InnerText = "Uncategorized";
            }

           
        }

        private void LoadRelatedFoods(int categoryId, int currentProductId)
        {
            try
            {
                List<Product> related = _productService.GetProductsByCategoryId(categoryId)
                    .Where(p => p.ProductItemID != currentProductId)
                    .Take(RelatedFoodsCount)
                    .ToList();

                if (related.Any())
                {
                    rptRelatedFoods.DataSource = related;
                    rptRelatedFoods.DataBind();
                    pnlRelatedFoods.Visible = true;
                }
                else
                {
                    pnlRelatedFoods.Visible = false;
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Related products error: " + ex.Message);
                pnlRelatedFoods.Visible = false;
            }
        }

        private void ShowErrorPanel()
        {
            pnlFoodDetails.Visible = false;
            pnlError.Visible = true;
            pnlRelatedFoods.Visible = false;
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            int quantity = int.Parse(txtQuantity.Text);
            if (quantity < 10) // Max quantity limit
            {
                txtQuantity.Text = (quantity + 1).ToString();
            }
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            int quantity = int.Parse(txtQuantity.Text);
            if (quantity > 1) // Min quantity limit
            {
                txtQuantity.Text = (quantity - 1).ToString();
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if user is logged in
                User currentUser = (User)Session["User"];
                if (currentUser == null)
                {
                    // Redirect to login page with return URL
                    Response.Redirect($"Login.aspx?returnUrl={HttpUtility.UrlEncode(Request.RawUrl)}");
                    return;
                }

                // Get quantity
                int quantity = int.Parse(txtQuantity.Text);

                // Validate quantity
                if (quantity < 1 || quantity > 10)
                {
                    ShowMessage("Please select a quantity between 1 and 10.");
                    return;
                }

                // Get food item ID
                int productItemId = int.Parse(Request.QueryString["id"]);

                // Add to cart
                var master = (PawMart)this.Master;

                // Store data temporarily (Session or ViewState)
                Session["Cart_ProductID"] = productItemId;
                Session["Cart_Quantity"] = quantity;

                master.ShowModal("Confirm", "Add this item to cart?", "CONFIRM_ADD_TO_CART");
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error adding to cart: " + ex.Message);
               
                var master = (PawMart)this.Master;
                master.ShowModal("Failed", "Failed to add item to cart.Please try again!");
            }
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            // Redirect back to food listing page
            Response.Redirect("ProductListing.aspx");
        }

        protected void btnBackToMenu_Click(object sender, EventArgs e)
        {
            // Redirect back to food listing page
            Response.Redirect("ProductListing.aspx");
        }

        protected void rptRelatedFoods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int productItemId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "ViewDetails":
                    // Redirect to food details page
                    Response.Redirect($"ProductDetails.aspx?id={productItemId}");
                    break;

                case "AddToCart":
                    try
                    {
                        // Check if user is logged in
                        User currentUser = (User)Session["User"];
                        if (currentUser == null)
                        {
                            // Redirect to login page with return URL
                            Response.Redirect($"Login.aspx?returnUrl={HttpUtility.UrlEncode(Request.RawUrl)}");
                            return;
                        }

                        // Add to cart (default quantity = 1)
                        _cartService.AddToCart(currentUser.UserID, productItemId);

                        // Show success message
                        var master = (PawMart)this.Master;

                        // Store data temporarily (Session or ViewState)
                        Session["Cart_ProductID"] = productItemId;
                        Session["Cart_Quantity"] = 1;

                        master.ShowModal("Confirm", "Add this item to cart?", "CONFIRM_ADD_TO_CART");
                    }
                    catch (Exception ex)
                    {
                        // Log error
                        System.Diagnostics.Debug.WriteLine("Error adding related item to cart: " + ex.Message);
                      
                        var master = (PawMart)this.Master;
                        master.ShowModal("Failed", "Failed to add item to cart.Please try again!");
                    }
                    break;
            }
        }

        private void ShowMessage(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowMessage",
                $"alert('{message}');", true);
        }
    }
}