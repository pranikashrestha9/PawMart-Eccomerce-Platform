using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using PawMart.Models;
using PawMart.service;
using PawMart.Services;
//using PawMart.Models;

namespace PawMart
{
  public partial class Default : System.Web.UI.Page
    {
        private ProductService _productService;
        private CartService _cartService;


        protected void Page_Init(object sender, EventArgs e)
        {
            // Initialize the UserService
            _productService = new ProductService();
            _cartService = new CartService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load categories
                LoadCategories();

                // Load featured products
                LoadFeaturedProducts();
            }
        }

        private void LoadCategories()
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["PawMartConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT TOP 4 CategoryID, Name, Description FROM Category ORDER BY CreatedAt";

                    SqlCommand command = new SqlCommand(query, connection);
                    connection.Open();

                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable categoriesTable = new DataTable();
                    adapter.Fill(categoriesTable);

                    // Add image URLs (you can create an array of your hardcoded image paths)
                    string[] categoryImages = {
                "/Images/dash.jpeg",
                "/Images/categories/pizza.jpg",
                "/Images/categories/sushi.jpg",
                "/Images/categories/desserts.jpg"
            };

                    // Add the ImageUrl column
                    categoriesTable.Columns.Add("ImageUrl", typeof(string));

                    for (int i = 0; i < categoriesTable.Rows.Count; i++)
                    {
                        // Cycle through the image array if you have fewer images than categories
                        categoriesTable.Rows[i]["ImageUrl"] = categoryImages[i % categoryImages.Length];
                    }

                    rptCategories.DataSource = categoriesTable;
                    rptCategories.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading categories: " + ex.Message);
                lblError.Text = "Error loading categories: " + ex.Message;
                lblError.Visible = true;
            }
        }   

      private void LoadFeaturedProducts()
{
    try
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PawMartConnectionString"].ConnectionString;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = @"
                SELECT TOP 4 p.ProductItemID AS ProductID, p.Name, p.Description, p.Price, 
                       p.ImageURL AS ImageUrl, c.CategoryID, c.Name as CategoryName
                FROM Product p
                INNER JOIN Category c ON p.CategoryID = c.CategoryID
                WHERE p.IsAvailable = 1 AND p.IsFeatured = 1
                ORDER BY NEWID()";

            SqlCommand command = new SqlCommand(query, connection);
            connection.Open();

            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable productsTable = new DataTable();
            adapter.Fill(productsTable);

            // Bind directly to the DataTable
            rptFeaturedProducts.DataSource = productsTable;
            rptFeaturedProducts.DataBind();

            // Debug output
            System.Diagnostics.Debug.WriteLine($"Loaded {productsTable.Rows.Count} featured products");
        }
    }
    catch (Exception ex)
    {
        System.Diagnostics.Debug.WriteLine("Error loading featured products: " + ex.Message);
        // Make the error visible during development
        lblError.Text = "Error loading products: " + ex.Message;
        lblError.Visible = true;
    }
}
        protected void btnOrderNow_Click(object sender, EventArgs e)
        {
            if(Session["User"] == null)
            {
                // Redirect to login page if user is not logged in
                Response.Redirect("~/Login.aspx");
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            // Redirect to the menu page
            Response.Redirect("~/ProductListing.aspx");
        }

        protected void rptFeaturedProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                if (Session["User"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }
                int productId = Convert.ToInt32(e.CommandArgument);

                // Store in session
                Session["Cart_ProductID"] = productId;
                Session["Cart_Quantity"] = 1;

                // Show modal
                var master = (PawMart)this.Master;
                master.ShowModal("Confirm", "Add this item to cart?", "CONFIRM_ADD_TO_CART");
            }
        }



        //protected override void OnPreRender(EventArgs e)
        //{
        //    base.OnPreRender(e);

        //    // Register event handler for the repeater
        //    if (!IsPostBack)
        //    {
        //        rptFeaturedProducts.ItemCommand += new RepeaterCommandEventHandler(rptFeaturedProducts_ItemCommand);
        //    }
        //}
    }
}