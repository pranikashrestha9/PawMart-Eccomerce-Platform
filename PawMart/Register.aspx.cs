using PawMart.Models;
using PawMart.service;
using PawMart.Utility;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PawMart
{
    public partial class Register : System.Web.UI.Page
    {

        private readonly UserService _userService;

        public Register()
        {
            _userService = new UserService();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // If user is already logged in, redirect to homepage
            if (Session["UserName"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try {
                if (IsValid)
                {
                    User newUser = new User
                    {
                        FullName = txtFullName.Text.Trim(),
                        Email = txtEmail.Text.Trim(),
                        Password = txtPassword.Text.Trim(), // Consider hashing the password
                        Phone = txtPhone.Text.Trim(),
                        Address = txtAddress.Text.Trim(),
                        UserType = "Customer",
                        RegistrationDate = DateTime.Now,
                        IsActive = true
                    };
                    if (_userService.AddUser(newUser))
                    {
                        EmailHelper.SendWelcomeEmail(newUser.Email, newUser.FullName);
                        lblMessage.Text = "User added successfully!";
                        lblMessage.CssClass = "success-message";

                        // Redirect to login page
                        Response.Redirect("Login.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();

                    }
                    else
                    {
                        lblMessage.Text = "Failed to add user. Please try again.";
                        lblMessage.CssClass = "error-message";
                    }
                }



            } catch (Exception ex) {
                lblMessage.Text = "Failed to add user. Please try again.";
                lblMessage.CssClass = "error-message";

            }
        }
    }
}
