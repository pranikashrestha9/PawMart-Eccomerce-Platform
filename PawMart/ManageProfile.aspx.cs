using PawMart.Models;
using PawMart.service;
using System;
using System.Web.UI;

namespace PawMart
{
    public partial class ManageProfile : System.Web.UI.Page
    {
        private UserService _userService;
        private User _currentUser;


        protected void Page_Load(object sender, EventArgs e)
        {
            _userService = new UserService();

            // Check if user is logged in
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            //_userId = Convert.ToInt32(Session["UserID"]);
            //_currentUser = _userService.GetUserById(_userId);
            _currentUser = Session["User"] as User;

            if (!IsPostBack)
            {
                // Load user data
                LoadUserData();
            }
        }

        private void LoadUserData()
        {
            if (_currentUser != null)
            {
                // Set the profile information
                litRegistrationDate.Text = _currentUser.RegistrationDate.ToString("MMMM dd, yyyy");
                litEmail.Text = _currentUser.Email;

                // Fill in the form fields
                txtFullName.Text = _currentUser.FullName;
                txtPhone.Text = _currentUser.Phone;
                txtAddress.Text = _currentUser.Address;
            }
            else
            {
                ShowAlert("Unable to load user data. Please try again later.", "danger");
            }
        }

        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                    return;

                // Update user data
                _currentUser.FullName = txtFullName.Text.Trim();
                _currentUser.Phone = txtPhone.Text.Trim();
                _currentUser.Address = txtAddress.Text.Trim();

                // Save changes
                bool updateSuccess = _userService.UpdateUser(_currentUser);

                if (updateSuccess)
                {
                    // Update the session name if it changed
                    Session["UserName"] = _currentUser.FullName;

                    ShowAlert("Your profile has been updated successfully!", "success");
                }
                else
                {
                    ShowAlert("Failed to update profile. Please try again.", "danger");
                }
            }
            catch (Exception ex)
            {
                ShowAlert("An error occurred: " + ex.Message, "danger");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            try
            {
                if (!Page.IsValid)
                    return;

                string currentPassword = txtCurrentPassword.Text;
                string newPassword = txtNewPassword.Text;

                

                // Attempt to change password
                bool passwordChangeSuccess = _userService.ChangePassword(_currentUser.UserID, currentPassword, newPassword);

                if (passwordChangeSuccess)
                {
                    // Clear password fields
                    txtCurrentPassword.Text = string.Empty;
                    txtNewPassword.Text = string.Empty;
                    txtConfirmPassword.Text = string.Empty;

                    ShowAlert("Your password has been changed successfully!", "success");
                }
                else
                {
                    ShowAlert("Failed to change password. Please check your current password and try again.", "danger");
                }
            }
            catch (ArgumentException ex)
            {
                // This catches the password strength validation exception
                ShowAlert("Password change failed: " + ex.Message, "danger");
            }
            catch (Exception ex)
            {
                ShowAlert("An error occurred: " + ex.Message, "danger");
            }
        }

        private void ShowAlert(string message, string type)
        {
            pnlAlert.Visible = true;
            pnlAlert.CssClass = "alert alert-" + type;
            litAlertMessage.Text = message;
        }
    }
}