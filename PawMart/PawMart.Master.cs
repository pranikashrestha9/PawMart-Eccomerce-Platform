using PawMart.Models;
using PawMart.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PawMart
{
	public partial class PawMart : System.Web.UI.MasterPage
	{

        private string ModalAction
        {
            get { return ViewState["ModalAction"]?.ToString(); }
            set { ViewState["ModalAction"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
		{

		}
        public void ShowModal(string title, string message, string action = "")
        {
            modalTitle.InnerText = title;
            modalMessage.InnerText = message;

            ModalAction = action; 

            pnlModal.Style["display"] = "flex";
        }
       

        protected void btnModalOk_Click(object sender, EventArgs e)
        {
            if (ModalAction == "CONFIRM_ADD_TO_CART")
            {
                var user = (User)Session["User"];

                int productId = Convert.ToInt32(Session["Cart_ProductID"]);
                int quantity = Convert.ToInt32(Session["Cart_Quantity"]);

                CartService cartService = new CartService();
                cartService.AddToCart(user.UserID, productId, quantity);

                Response.Redirect("ProductCart.aspx"); // or stay same page
            }

            pnlModal.Style["display"] = "none";
        }

        protected void btnModalCancel_Click(object sender, EventArgs e)
        {
            // ❗ ONLY CLOSE
            pnlModal.Style["display"] = "none";

            // Optional cleanup (good practice)
            ModalAction = null;
            Session.Remove("Cart_ProductID");
            Session.Remove("Cart_Quantity");
        }

    }
}