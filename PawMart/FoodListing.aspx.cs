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
    public partial class FoodListing : System.Web.UI.Page
    {
        // Services
        private readonly FoodItemService _foodItemService;
        private readonly CategoryService _categoryService;
        private readonly CartService _cartService;

        // Page size for pagination
        private const int PageSize = 12;

        public FoodListing()
        {
            _foodItemService = new FoodItemService();
            _categoryService = new CategoryService();
            _cartService = new CartService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialize the page with default values
                ViewState["CurrentPage"] = 1;
                ViewState["CurrentCategory"] = 0; // 0 means all categories
                ViewState["SearchTerm"] = string.Empty;

                // Load categories for filter buttons
                LoadCategories();

                // Bind data to repeaters
                BindProductData();

                // Setup pagination
                SetupPagination();
            }
        }

        private void LoadCategories()
        {
            try
            {
                var categories = _categoryService.GetAllCategories();
                rptCategories.DataSource = categories;
                rptCategories.DataBind();
            }
            catch (Exception ex)
            {
                // Log error and show message to user
                System.Diagnostics.Debug.WriteLine("Error loading categories: " + ex.Message);
                ScriptManager.RegisterStartupScript(this, GetType(), "LoadCategoriesError",
                    "alert('Failed to load categories. Please try again later.');", true);
            }
        }

        private void BindProductData()
        {
            try
            {
                // Get the current category, search term, and page
                int categoryId = Convert.ToInt32(ViewState["CurrentCategory"]);
                string searchTerm = ViewState["SearchTerm"].ToString();
                int currentPage = Convert.ToInt32(ViewState["CurrentPage"]);

                // Get all food items
                List<FoodItem> allItems = _foodItemService.GetAllFoodItems();

                // Filter by category if needed
                if (categoryId > 0)
                {
                    allItems = allItems.Where(item => item.CategoryID == categoryId).ToList();
                }

                // Filter by search term if provided
                if (!string.IsNullOrEmpty(searchTerm))
                {
                    allItems = allItems.Where(item =>
                        item.Name.ToLower().Contains(searchTerm.ToLower()) ||
                        item.Description.ToLower().Contains(searchTerm.ToLower())).ToList();
                }

                // Check if there are any results
                if (allItems.Count == 0)
                {
                    pnlNoResults.Visible = true;
                    pnlPagination.Visible = false;
                    pnlFeatured.Visible = false;
                    rptProducts.Visible = false;
                    rptProductsMobile.Visible = false;
                    return;
                }
                else
                {
                    pnlNoResults.Visible = false;
                    rptProducts.Visible = true;
                    rptProductsMobile.Visible = true;
                }

                // Separate featured items
                List<FoodItem> featuredItems = allItems.Where(item => item.IsFeatured).ToList();
                List<FoodItem> regularItems = allItems.Where(item => !item.IsFeatured).ToList();

                // Determine if we should show the featured section
                pnlFeatured.Visible = featuredItems.Count > 0;

                // Bind featured items (no pagination for featured items)
                if (featuredItems.Count > 0)
                {
                    rptFeaturedProducts.DataSource = featuredItems;
                    rptFeaturedProducts.DataBind();

                    rptFeaturedProductsMobile.DataSource = featuredItems;
                    rptFeaturedProductsMobile.DataBind();
                }

                // Calculate pagination for regular items
                int totalPages = (int)Math.Ceiling((double)regularItems.Count / PageSize);
                ViewState["TotalPages"] = totalPages;

                // Ensure current page is within bounds
                if (currentPage > totalPages && totalPages > 0)
                {
                    currentPage = totalPages;
                    ViewState["CurrentPage"] = currentPage;
                }

                // Paginate the regular items data
                int startIndex = (currentPage - 1) * PageSize;
                List<FoodItem> pagedItems;

                if (regularItems.Count > 0)
                {
                    pagedItems = regularItems
                        .Skip(startIndex)
                        .Take(Math.Min(PageSize, regularItems.Count - startIndex))
                        .ToList();
                }
                else
                {
                    pagedItems = new List<FoodItem>();
                }

                // Bind data to repeaters
                rptProducts.DataSource = pagedItems;
                rptProducts.DataBind();

                rptProductsMobile.DataSource = pagedItems;
                rptProductsMobile.DataBind();

                // Update pagination visibility
                pnlPagination.Visible = totalPages > 1;
                SetupPagination();
            }
            catch (Exception ex)
            {
                // Log error and show message to user
                System.Diagnostics.Debug.WriteLine("Error binding product data: " + ex.Message);
                ScriptManager.RegisterStartupScript(this, GetType(), "BindProductDataError",
                    "alert('Failed to load products. Please try again later.');", true);
            }
        }

        private void SetupPagination()
        {
            try
            {
                int currentPage = Convert.ToInt32(ViewState["CurrentPage"]);
                int totalPages = Convert.ToInt32(ViewState["TotalPages"]);

                // Only setup pagination if there are multiple pages
                if (totalPages <= 1)
                {
                    pnlPagination.Visible = false;
                    return;
                }

                // Enable/disable first/prev buttons
                btnFirstPage.Enabled = currentPage > 1;
                btnPrevPage.Enabled = currentPage > 1;

                // Enable/disable next/last buttons
                btnNextPage.Enabled = currentPage < totalPages;
                btnLastPage.Enabled = currentPage < totalPages;

                // Create page number buttons
                List<object> pages = new List<object>();

                // Determine range of page numbers to show
                int startPage = Math.Max(1, currentPage - 2);
                int endPage = Math.Min(totalPages, startPage + 4);

                // Adjust start page if needed
                if (endPage - startPage < 4)
                {
                    startPage = Math.Max(1, endPage - 4);
                }

                // Create page number objects
                for (int i = startPage; i <= endPage; i++)
                {
                    pages.Add(new { PageNumber = i });
                }

                // Bind page numbers to repeater
                rptPageNumbers.DataSource = pages;
                rptPageNumbers.DataBind();
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error setting up pagination: " + ex.Message);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ViewState["SearchTerm"] = txtSearch.Text.Trim();
            ViewState["CurrentPage"] = 1; // Reset to first page
            BindProductData();
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ViewState["SearchTerm"] = string.Empty;
            ViewState["CurrentPage"] = 1; // Reset to first page
            BindProductData();
        }

        protected void btnCategory_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int categoryId = Convert.ToInt32(btn.CommandArgument);

            // Update active category
            ViewState["CurrentCategory"] = categoryId;
            ViewState["CurrentPage"] = 1; // Reset to first page

            // Update button styles
            UpdateCategoryButtonStyles(categoryId);

            // Rebind data
            BindProductData();
        }

        protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "FilterByCategory")
            {
                int categoryId = Convert.ToInt32(e.CommandArgument);

                // Update active category
                ViewState["CurrentCategory"] = categoryId;
                ViewState["CurrentPage"] = 1; // Reset to first page

                // Update button styles
                UpdateCategoryButtonStyles(categoryId);

                // Rebind data
                BindProductData();
            }
        }

        private void UpdateCategoryButtonStyles(int activeCategoryId)
        {
            // Update "All" button
            btnAllCategories.CssClass = activeCategoryId == 0 ? "filter-btn active" : "filter-btn";

            // Update category buttons
            foreach (RepeaterItem item in rptCategories.Items)
            {
                LinkButton btn = (LinkButton)item.FindControl("btnCategory");
                int categoryId = Convert.ToInt32(btn.CommandArgument);
                btn.CssClass = categoryId == activeCategoryId ? "filter-btn active" : "filter-btn";
            }
        }

        protected void btnPagination_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string action = btn.CommandArgument.ToString();

            int currentPage = Convert.ToInt32(ViewState["CurrentPage"]);
            int totalPages = Convert.ToInt32(ViewState["TotalPages"]);

            switch (action)
            {
                case "first":
                    ViewState["CurrentPage"] = 1;
                    break;
                case "prev":
                    if (currentPage > 1)
                    {
                        ViewState["CurrentPage"] = currentPage - 1;
                    }
                    break;
                case "next":
                    if (currentPage < totalPages)
                    {
                        ViewState["CurrentPage"] = currentPage + 1;
                    }
                    break;
                case "last":
                    ViewState["CurrentPage"] = totalPages;
                    break;
            }

            BindProductData();
        }

        protected void rptPageNumbers_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "GoToPage")
            {
                int pageNumber = Convert.ToInt32(e.CommandArgument);
                ViewState["CurrentPage"] = pageNumber;
                BindProductData();
            }
        }

        protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int foodItemId = Convert.ToInt32(e.CommandArgument);

            switch (e.CommandName)
            {
                case "ViewDetails":
                    // Redirect to product details page
                    Response.Redirect($"FoodDetails.aspx?id={foodItemId}");
                    break;
                case "AddToCart":
                    // Add item to cart (implement shopping cart functionality)
                    AddToCart(foodItemId);
                    break;
            }
        }

        private void AddToCart(int foodItemId)
        {
            try
            {
                User currentUser = (User)Session["User"];
                if (currentUser == null)
                {
                    // User is not logged in
                    ScriptManager.RegisterStartupScript(this, GetType(), "AddToCartError",
                        "alert('Please log in to add items to your cart.');", true);
                    Response.Redirect("Login.aspx");

                }

                Cart cart = _cartService.EnsureCartExists(currentUser.UserID); // Changed from 'GetCurrentUserId()' to '1' for testing
                // Get the food item
                FoodItem item = _foodItemService.GetFoodItemById(foodItemId);

                if (item == null || !item.IsAvailable)
                {
                    // Item not found or not available
                    ScriptManager.RegisterStartupScript(this, GetType(), "AddToCartError",
                        "alert('This item is currently not available.');", true);
                    return;
                }

                // Get or create shopping cart
                List<CartItem> cartitem =Session["ShoppingCart"] as List<CartItem> ?? new List<CartItem>();




                // Check if item already exists in cart
                CartItem existingItem = cartitem.FirstOrDefault(i => i.FoodItemID == foodItemId);

                if (existingItem != null)
                {
                    // Increment quantity
                    existingItem.Quantity++;
                }
                else
                {
                    // Add new item to cart
                 

                    _cartService.AddToCart(currentUser.UserID,foodItemId);
                }

                // Save cart to session
                Session["ShoppingCart"] = cartitem;

                // Update cart item count in UI (if needed)
                //UpdateCartCount(cartItem.Sum(i => i.Quantity));

                // Show success message
                ScriptManager.RegisterStartupScript(this, GetType(), "AddToCartSuccess",
                    "alert('Item added to cart successfully!');", true);
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine("Error adding item to cart: " + ex.Message);

                // Show error message
                ScriptManager.RegisterStartupScript(this, GetType(), "AddToCartError",
                    "alert('Failed to add item to cart. Please try again.');", true);
            }
        }

        private void UpdateCartCount(int count)
        {



         
        }

      
    }
}