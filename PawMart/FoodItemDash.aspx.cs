using FoodyMan.Models;
using FoodyMan.service;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FoodyMan
{
    public partial class FoodItemDash : System.Web.UI.Page
    {
        private readonly FoodItemService _foodItemService;
        private readonly CategoryService _categoryService;

        public FoodItemDash()
        {
            _foodItemService = new FoodItemService();
            _categoryService = new CategoryService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFoodItems();
                LoadCategories();
            }
        }

        private void LoadFoodItems()
        {
            // Bind the GridView with food items
            gvFoodItems.DataSource = _foodItemService.GetAllFoodItems();
            gvFoodItems.DataBind();
        }

        private void LoadCategories()
        {
            // Bind the Category dropdowns
            ddlCategoryID.DataSource = _categoryService.GetAllCategories();
            ddlCategoryID.DataTextField = "Name";
            ddlCategoryID.DataValueField = "CategoryID";
            ddlCategoryID.DataBind();

            ddlEditCategoryID.DataSource = _categoryService.GetAllCategories();
            ddlEditCategoryID.DataTextField = "Name";
            ddlEditCategoryID.DataValueField = "CategoryID";
            ddlEditCategoryID.DataBind();
        }

        protected void btnAddFoodItem_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {

                    if (fileUploadImage.HasFile)
                    {
                        // Define the folder to save the uploaded image
                        string uploadFolder = Server.MapPath("~/Uploads/");

                        // Ensure the upload folder exists
                        if (!System.IO.Directory.Exists(uploadFolder))
                        {
                            System.IO.Directory.CreateDirectory(uploadFolder);
                        }

                        // Generate a unique file name to avoid conflicts
                        string fileName = Guid.NewGuid().ToString() + System.IO.Path.GetExtension(fileUploadImage.FileName);

                        // Save the file to the upload folder
                        string filePath = System.IO.Path.Combine(uploadFolder, fileName);
                     

                        FoodItem newFoodItem = new FoodItem
                        {

                            Name = txtName.Text.Trim(),
                            Description = txtDescription.Text.Trim(),
                            Price = Convert.ToDecimal(txtPrice.Text),
                            DiscountPrice = Convert.ToDecimal(txtDiscountPrice.Text),
                            ImageURL = "~/Uploads/" + fileName,
                            CategoryID = Convert.ToInt32(ddlCategoryID.SelectedValue),
                            IsAvailable = chkIsAvailable.Checked,
                            IsFeatured = chkIsFeatured.Checked,
                            CreatedAt = DateTime.Now,
                            UpdatedAt = DateTime.Now
                        };

                        if (_foodItemService.AddFoodItem(newFoodItem))
                        {
                            fileUploadImage.SaveAs(filePath);
                            LoadFoodItems();
                            lblMessage.Text = "Food item added successfully!";
                            lblMessage.CssClass = "success-message";
                            ClearForm();

                            // Add JavaScript to close the modal after successful addition
                            ClientScript.RegisterStartupScript(this.GetType(), "closeModal", "closeAddModal();", true);
                        }
                        else
                        {
                            lblMessage.Text = "Failed to add food item. Please try again.";
                            lblMessage.CssClass = "error-message";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred: " + ex.Message;
                    lblMessage.CssClass = "error-message";
                }
            }
        }

        protected void btnUpdateFoodItem_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    if (fileUploadImage.HasFile)
                    {
                        // Define the folder to save the uploaded image
                        string uploadFolder = Server.MapPath("~/Uploads/");

                        // Ensure the upload folder exists
                        if (!System.IO.Directory.Exists(uploadFolder))
                        {
                            System.IO.Directory.CreateDirectory(uploadFolder);
                        }

                        // Generate a unique file name to avoid conflicts
                        string fileName = Guid.NewGuid().ToString() + System.IO.Path.GetExtension(fileUploadImage.FileName);

                        // Save the file to the upload folder
                        string filePath = System.IO.Path.Combine(uploadFolder, fileName);
                        int foodItemId = Convert.ToInt32(hdnFoodItemID.Value);
                    FoodItem existingFoodItem = _foodItemService.GetFoodItemById(foodItemId);

                        if (existingFoodItem != null)
                        {
                            existingFoodItem.Name = txtEditName.Text.Trim();
                            existingFoodItem.Description = txtEditDescription.Text.Trim();
                            existingFoodItem.Price = Convert.ToDecimal(txtEditPrice.Text);
                            existingFoodItem.DiscountPrice = Convert.ToDecimal(txtEditDiscountPrice.Text);
                            existingFoodItem.ImageURL = "~/Uploads/" + fileName;
                            existingFoodItem.CategoryID = Convert.ToInt32(ddlEditCategoryID.SelectedValue);
                            existingFoodItem.IsAvailable = chkEditIsAvailable.Checked;
                            existingFoodItem.IsFeatured = chkEditIsFeatured.Checked;
                            existingFoodItem.UpdatedAt = DateTime.Now;

                            if (_foodItemService.UpdateFoodItem(existingFoodItem))
                            {
                                LoadFoodItems();
                                lblEditMessage.Text = "Food item updated successfully!";
                                lblEditMessage.CssClass = "success-message";

                                // Add JavaScript to close the modal after successful update
                                ClientScript.RegisterStartupScript(this.GetType(), "closeEditModal", "closeEditModal();", true);
                            }
                            else
                            {
                                lblEditMessage.Text = "Failed to update food item. Please try again.";
                                lblEditMessage.CssClass = "error-message";
                            }
                        }
                    }
                    else
                    {
                        lblEditMessage.Text = "Food item not found.";
                        lblEditMessage.CssClass = "error-message";
                    }
                }
                catch (Exception ex)
                {
                    lblEditMessage.Text = "An error occurred: " + ex.Message;
                    lblEditMessage.CssClass = "error-message";
                }
            }
        }

        protected void gvFoodItems_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteFoodItem")
            {
                try
                {
                    int foodItemId = Convert.ToInt32(e.CommandArgument);
                    if (_foodItemService.DeleteFoodItem(foodItemId))
                    {
                        LoadFoodItems();
                        // Display a success message (optional)
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteSuccess",
                            "alert('Food item deleted successfully.');", true);
                    }
                    else
                    {
                        // Display an error message
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteError",
                            "alert('Failed to delete food item. Please try again.');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception and display an error message
                    ScriptManager.RegisterStartupScript(this, GetType(), "DeleteException",
                        $"alert('An error occurred: {ex.Message}');", true);
                }
            }
            else if (e.CommandName == "EditFoodItem")
            {
                int foodItemId = Convert.ToInt32(e.CommandArgument);
                FoodItem foodItem = _foodItemService.GetFoodItemById(foodItemId);

                if (foodItem != null)
                {
                    // Populate the Edit modal fields
                    hdnFoodItemID.Value = foodItem.FoodItemID.ToString();
                    txtEditName.Text = foodItem.Name;
                    txtEditDescription.Text = foodItem.Description;
                    txtEditPrice.Text = foodItem.Price.ToString();
                    txtEditDiscountPrice.Text = foodItem.DiscountPrice.ToString();
                    lblEditImageURL.Text = foodItem.ImageURL;
                    ddlEditCategoryID.SelectedValue = foodItem.CategoryID.ToString();
                    chkEditIsAvailable.Checked = foodItem.IsAvailable;
                    chkEditIsFeatured.Checked = foodItem.IsFeatured;

                    // Show the Edit modal
                    ClientScript.RegisterStartupScript(this.GetType(), "openEditModal", "openEditModal();", true);
                }
            }
        }
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int foodItemId = Convert.ToInt32(btn.CommandArgument);

            FoodItem foodItem = _foodItemService.GetFoodItemById(foodItemId);

            if (foodItem != null)
            {
                // Populate the Edit modal fields
                hdnFoodItemID.Value = foodItem.FoodItemID.ToString();
                txtEditName.Text = foodItem.Name;
                txtEditDescription.Text = foodItem.Description;
                txtEditPrice.Text = foodItem.Price.ToString();
                txtEditDiscountPrice.Text = foodItem.DiscountPrice.ToString() ?? "";
                lblEditImageURL.Text = foodItem.ImageURL;
                ddlEditCategoryID.SelectedValue = foodItem.CategoryID.ToString();
                chkEditIsAvailable.Checked = foodItem.IsAvailable;
                chkEditIsFeatured.Checked = foodItem.IsFeatured;

                // Show the Edit modal using JavaScript
                ScriptManager.RegisterStartupScript(this, GetType(), "showEditModal",
                    "document.getElementById('editFoodItemModal').style.display = 'flex';", true);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Navigate back to the previous page
            Response.Redirect("Dashboard.aspx");
        }

        private void ClearForm()
        {
            txtName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            txtPrice.Text = string.Empty;
            txtDiscountPrice.Text = string.Empty;
            lblImageURL.Text = string.Empty;
            ddlCategoryID.SelectedIndex = 0;
            chkIsAvailable.Checked = true;
            chkIsFeatured.Checked = false;
        }
    }
}