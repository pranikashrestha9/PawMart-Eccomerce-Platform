using PawMart.Models;
using PawMart.service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PawMart
{
    public partial class Login : System.Web.UI.Page
    {


        UserService userService = new UserService();
        protected void Page_Load(object sender, EventArgs e)
        {
            //// If user is already logged in, redirect to homepage
            //if (Session["UserRole"] == "Admin")
            //{
            //    Response.Redirect("~/Admindash.aspx");
            //}
            //else
            //{
            //    Response.Redirect("~/Default.aspx");
            //}
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                string email = txtEmail.Text.Trim();
                string password = txtPassword.Text;

                // Try to get the user from the service layer
                User user = userService.GetUserByEmail(email);

                // If user exists and password matches
                if (userService.ValidateUser(email,password))
                {
                    // Store user information in session
                    Session["User"] = user;
                    Session["UserRole"] = user.UserType;

                    string[] nameParts = user.FullName.Split(' ');
                    if (nameParts.Length >= 0)
                    {
                        Session["UserName"] = nameParts[0];
                    }

                    if (user.UserType == "Admin")
                    {
                        Response.Redirect("~/Admindash.aspx");
                    }
                    else
                    {
                        Response.Redirect("~/ProductListing.aspx");
                    }
                }
                else
                {
                    // If email is not valid or password doesn't match, throw a login error
                    throw new Exception("Invalid email or password.");
                }
            }
            catch (Exception ex)
            {
                // Catch any exception and show a user-friendly message
                string script = $"alert('Login failed. Please try again.');";
                ClientScript.RegisterStartupScript(this.GetType(), "LoginFailedAlert", script, true);

            }
        }

        public  int GetCurrentUserId()
        {
            if (Session["User"] != null)
            {
                // Cast the Session object back to your User type
                User currentUser = (User)Session["User"];
                return currentUser.UserID;
            }

            // Return -1 or throw exception if no user is logged in
            return -1;
        }

    }
}
