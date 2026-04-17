using FoodyMan.Models;
using FoodyMan.Repositories;
using FoodyMan.service;
using FoodyMan.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodyMan
{
    public partial class FoodDetails : System.Web.UI.Page
    {
        // Services
        private readonly FoodItemService _foodItemService;
        private readonly CategoryService _categoryService;
        private readonly CartService _cartService;

        // Number of related foods to show
        private const int RelatedFoodsCount = 4;

        // Current food item
        private FoodItem _currentFoodItem;

        public FoodDetails()
        {
            _foodItemService = new FoodItemService();
            _categoryService = new CategoryService();
            _cartService = new CartService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get food item ID from URL parameter
                if (!string.IsNullOrEmpty(Request.QueryString["id"]) && int.TryParse(Request.QueryString["id"], out int foodItemId))
                {
                    // Load the food item details
                    LoadFoodDetails(foodItemId);
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
                _currentFoodItem = _foodItemService.GetFoodItemById(foodItemId);

                if (_currentFoodItem == null)
                {
                    // Food item not found
                    ShowErrorPanel();
                    return;
                }

                // Show food details panel
                pnlFoodDetails.Visible = true;
                pnlError.Visible = false;

                // Set food details in UI
                PopulateFoodDetails(_currentFoodItem);

                //// Load related foods
                //LoadRelatedFoods(_currentFoodItem.CategoryID, foodItemId);
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error loading food details: " + ex.Message);
                ShowErrorPanel();
            }
        }

        private void PopulateFoodDetails(FoodItem foodItem)
        {
            // Set breadcrumb
            currentFoodName.InnerText = foodItem.Name;

            // Set food item details
            foodName.InnerText = foodItem.Name;
            foodDescription.InnerText = foodItem.Description;

            // Set food image
            string imageUrl = ResolveUrl(foodItem.ImageURL);
            imgFood.ImageUrl = imageUrl;
            imgFood.AlternateText = foodItem.Name;
            imgFood.Attributes["onerror"] = $"this.src='{ResolveUrl("~/Images/placeholder-food.jpg")}'";

            // Set price information
            if (foodItem.DiscountPrice < foodItem.Price)
            {
                currentPrice.InnerText = $"${foodItem.DiscountPrice:0.00}";
                originalPrice.InnerText = $"${foodItem.Price:0.00}";
                pnlOriginalPrice.Visible = true;
                pnlDiscountTag.Visible = true;
            }
            else
            {
                currentPrice.InnerText = $"${foodItem.Price:0.00}";
                pnlOriginalPrice.Visible = false;
                pnlDiscountTag.Visible = false;
            }

            // Set availability
            if (foodItem.IsAvailable)
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
            pnlFeaturedTag.Visible = foodItem.IsFeatured;

            // Set category
            try
            {
                var category = _categoryService.GetCategoryById(foodItem.CategoryID);
                if (category != null)
                {
                    foodCategory.InnerText = category.Name;
                }
                else
                {
                    foodCategory.InnerText = "Uncategorized";
                }
            }
            catch
            {
                foodCategory.InnerText = "Uncategorized";
            }

            // Set serves (this could be added as a property to your FoodItem if needed)
            foodServes.InnerText = "1 Person";
        }

        //private void LoadRelatedFoods(int categoryId, int currentFoodId)
        //{
        //    try
        //    {
        //        // Get foods from the same category
        //        List<FoodItem> categoryFoods = _foodItemService.GetFoodItemByCategoryId(categoryId)
        //            .Where(f => f.FoodItemID != currentFoodId) // Exclude current food
        //            .ToList();

        //        // If not enough items in the same category, add some random items
        //        if (categoryFoods.Count < RelatedFoodsCount)
        //        {
        //            List<FoodItem> otherFoods = _foodItemService.GetAllFoodItems()
        //                .Where(f => f.CategoryID != categoryId && f.FoodItemID != currentFoodId)
        //                .OrderBy(f => Guid.NewGuid()) // Random order
        //                .Take(RelatedFoodsCount - categoryFoods.Count)
        //                .ToList();

        //            categoryFoods.AddRange(otherFoods);
        //        }

        //        // Take only the required number of items
        //        List<FoodItem> relatedFoods = categoryFoods
        //            .OrderBy(f => Guid.NewGuid()) // Random order
        //            .Take(RelatedFoodsCount)
        //            .ToList();

        //        // Bind to repeater
        //        if (relatedFoods.Count > 0)
        //        {
        //            rptRelatedFoods.DataSource = relatedFoods;
        //            rptRelatedFoods.DataBind();
        //            pnlRelatedFoods.Visible = true;
        //        }
        //        else
        //        {
        //            pnlRelatedFoods.Visible = false;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log error
        //        System.Diagnostics.Debug.WriteLine("Error loading related foods: " + ex.Message);
        //        pnlRelatedFoods.Visible = false;
        //    }
        //}

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
                int foodItemId = int.Parse(Request.QueryString["id"]);

                // Add to cart
                _cartService.AddToCart(currentUser.UserID, foodItemId, quantity);

                // Show success message
                ShowMessage("Item added to your cart successfully!");
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error adding to cart: " + ex.Message);
                ShowMessage("Failed to add item to cart. Please try again.");
            }
        }

        protected void btnContinueShopping_Click(object sender, EventArgs e)
        {
            // Redirect back to food listing page
            Response.Redirect("FoodListing.aspx");
        }

        protected void btnBackToMenu_Click(object sender, EventArgs e)
        {
            // Redirect back to food listing page
            Response.Redirect("FoodListing.aspx");
        }

        protected void rptRelatedFoods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int foodItemId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "ViewDetails":
                    // Redirect to food details page
                    Response.Redirect($"FoodDetails.aspx?id={foodItemId}");
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
                        _cartService.AddToCart(currentUser.UserID, foodItemId);

                        // Show success message
                        ShowMessage("Item added to your cart successfully!");
                    }
                    catch (Exception ex)
                    {
                        // Log error
                        System.Diagnostics.Debug.WriteLine("Error adding related item to cart: " + ex.Message);
                        ShowMessage("Failed to add item to cart. Please try again.");
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