using PawMart.Models;
using PawMart.service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PawMart
{
	public partial class CategoryDash : System.Web.UI.Page
	{
        private readonly CategoryService _categoryService;

        public CategoryDash()
        {
            _categoryService = new CategoryService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            // Bind the GridView with categories
            gvCategories.DataSource = _categoryService.GetAllCategories();
            gvCategories.DataBind();
        }

        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    Category newCategory = new Category
                    {
                        Name = txtName.Text.Trim(),
                        Description = txtDescription.Text.Trim(),
                        CreatedAt = DateTime.Now
                    };

                    if (_categoryService.AddCategory(newCategory))
                    {
                        LoadCategories();
                        lblMessage.Text = "Category added successfully!";
                        lblMessage.CssClass = "success-message";
                        ClearForm();

                        // Add JavaScript to close the modal after successful addition
                        ClientScript.RegisterStartupScript(this.GetType(), "closeModal", "closeAddModal();", true);
                    }
                    else
                    {
                        lblMessage.Text = "Failed to add category. Please try again.";
                        lblMessage.CssClass = "error-message";
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred: " + ex.Message;
                    lblMessage.CssClass = "error-message";
                }
            }
        }

        protected void btnUpdateCategory_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    int categoryId = Convert.ToInt32(hdnCategoryID.Value);
                    Category existingCategory = _categoryService.GetCategoryById(categoryId);

                    if (existingCategory != null)
                    {
                        existingCategory.Name = txtEditName.Text.Trim();
                        existingCategory.Description = txtEditDescription.Text.Trim();

                        if (_categoryService.UpdateCategory(existingCategory))
                        {
                            LoadCategories();
                            lblEditMessage.Text = "Category updated successfully!";
                       

                            // Add JavaScript to close the modal after successful update
                            ClientScript.RegisterStartupScript(this.GetType(), "closeEditModal", "closeEditModal();", true);
                        }
                        else
                        {
                            lblEditMessage.Text = "Failed to update category. Please try again.";
                            lblEditMessage.CssClass = "error-message";
                        }
                    }
                    else
                    {
                        lblEditMessage.Text = "Category not found.";
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

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteCategory")
            {
                try
                {
                    int categoryId = Convert.ToInt32(e.CommandArgument);
                    if (_categoryService.DeleteCategory(categoryId))
                    {
                        LoadCategories();
                        // Display a success message (optional)
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteSuccess",
                            "alert('Category deleted successfully.');", true);
                    }
                    else
                    {
                        // Display an error message
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteError",
                            "alert('Failed to delete category. Please try again.');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception and display an error message
                    ScriptManager.RegisterStartupScript(this, GetType(), "DeleteException",
                        $"alert('An error occurred: {ex.Message}');", true);
                }
            }
            else if (e.CommandName == "EditCategory")
                {
                    int categoryId = Convert.ToInt32(e.CommandArgument);
                    Category category = _categoryService.GetCategoryById(categoryId);

                    if (category != null)
                    {
                        // Populate the Edit modal fields
                        hdnCategoryID.Value = category.CategoryID.ToString();
                        txtEditName.Text = category.Name;
                        txtEditDescription.Text = category.Description;

                        // Show the Edit modal
                       
                        ClientScript.RegisterStartupScript(this.GetType(), "openEditModal", "openEditModal();", true);
                    }
                }
                else if (e.CommandName == "DeleteCategory")
                {
                    int categoryId = Convert.ToInt32(e.CommandArgument);
                    if (_categoryService.DeleteCategory(categoryId))
                    {
                        LoadCategories();
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteSuccess", "alert('Category deleted successfully.');", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteError", "alert('Failed to delete category. Please try again.');", true);
                    }
                
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
        }
    }
}