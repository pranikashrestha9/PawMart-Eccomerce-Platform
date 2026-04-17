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
	public partial class UserManagement : System.Web.UI.Page
	{

        private readonly UserService _userService;

        public UserManagement()
        {
            _userService = new UserService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            // Bind the GridView with users
            gvUsers.DataSource = _userService.GetAllUsers();
            gvUsers.DataBind();
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                User newUser = new User
                {
                    FullName = txtFullName.Text.Trim(),
                    Email = txtEmail.Text.Trim(),
                    Password = txtPassword.Text.Trim(), // Consider hashing the password
                    Phone = txtPhone.Text.Trim(),
                    Address = txtAddress.Text.Trim(),
                    UserType = ddlUserType.SelectedValue,
                    RegistrationDate = DateTime.Now,
                    IsActive = chkIsActive.Checked
                };

                if (_userService.AddUser(newUser))
                {
                    LoadUsers();
                    lblMessage.Text = "User added successfully!";
                    lblMessage.CssClass = "success-message";
                    ClearForm();

                    // Add JavaScript to close the modal after successful addition
                    ClientScript.RegisterStartupScript(this.GetType(), "closeModal", "closeAddModal();", true);
                }
                else
                {
                    lblMessage.Text = "Failed to add user. Please try again.";
                    lblMessage.CssClass = "error-message";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }

        protected void btnUpdateUser_Click(object sender, EventArgs e)
        {
            try
            {
                int userId = Convert.ToInt32(hdnUserID.Value);
                User existingUser = _userService.GetUserById(userId);

                if (existingUser != null)
                {
                    existingUser.FullName = txtEditFullName.Text.Trim();
                    existingUser.Email = txtEditEmail.Text.Trim();
                    existingUser.Phone = txtEditPhone.Text.Trim();
                    existingUser.Address = txtEditAddress.Text.Trim();
                    existingUser.UserType = ddlEditUserType.SelectedValue;
                    existingUser.IsActive = chkEditIsActive.Checked;

                    if (_userService.UpdateUser(existingUser))
                    {
                        LoadUsers();
                        lblEditMessage.Text = "User updated successfully!";
                        lblEditMessage.CssClass = "success-message";

                        // Add JavaScript to close the modal after successful update
                        ClientScript.RegisterStartupScript(this.GetType(), "closeEditModal", "closeEditModal();", true);
                    }
                    else
                    {
                        lblEditMessage.Text = "Failed to update user. Please try again.";
                        lblEditMessage.CssClass = "error-message";
                    }
                }
                else
                {
                    lblEditMessage.Text = "User not found.";
                    lblEditMessage.CssClass = "error-message";
                }
            }
            catch (Exception ex)
            {
                lblEditMessage.Text = "An error occurred: " + ex.Message;
                lblEditMessage.CssClass = "error-message";
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteUser")
            {
                try
                {
                    int userId = Convert.ToInt32(e.CommandArgument);
                    if (_userService.DeleteUser(userId))
                    {
                        LoadUsers();
                        // Display a success message (optional)
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteSuccess",
                            "alert('User deleted successfully.');", true);
                    }
                    else
                    {
                        // Display an error message
                        ScriptManager.RegisterStartupScript(this, GetType(), "DeleteError",
                            "alert('Failed to delete user. Please try again.');", true);
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception and display an error message
                    ScriptManager.RegisterStartupScript(this, GetType(), "DeleteException",
                        $"alert('An error occurred: {ex.Message}');", true);
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
            txtFullName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtAddress.Text = string.Empty;
            ddlUserType.SelectedIndex = 0;
            chkIsActive.Checked = true;
        }
    }
}