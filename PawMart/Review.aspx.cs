    using System;
    using PawMart.Models;
    using PawMart.Service;

    namespace PawMart
    {
        public partial class Review : System.Web.UI.Page
        {
            private ProductReviewService _reviewService;

            protected void Page_Load(object sender, EventArgs e)
            {
                _reviewService = new ProductReviewService();

                if (!IsPostBack)
                {
                    hfProductID.Value = Request.QueryString["ProductID"];
                    hfOrderID.Value = Request.QueryString["OrderID"];

               
            }
            }

            protected void btnSubmit_Click(object sender, EventArgs e)
            {
                try
                {
                    User user = (User)Session["User"];
                    if (user == null)
                    {
                        Response.Redirect("Login.aspx");
                        return;
                    }

                    int rating = GetSelectedRating();

                    if (rating == 0)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        lblMessage.Text = "Please select a rating.";
                        return;
                    }

                    ProductReview review = new ProductReview
                    {
                        ProductItemID = Convert.ToInt32(hfProductID.Value),
                        OrderID = Convert.ToInt32(hfOrderID.Value),
                        UserID = user.UserID,
                        Rating = rating,
                        ReviewText = txtReview.Text.Trim()
                    };
                var result = _reviewService.AddReview(review);

                lblMessage.Text = result.Message;
                lblMessage.ForeColor = result.Success
                    ? System.Drawing.Color.Green
                    : System.Drawing.Color.Red;

                if (result.Success)
                {
                    Response.Redirect("MyOrders.aspx", true);
                }


                }
                catch (Exception ex)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                   
                }
            }

            private int GetSelectedRating()
            {
                if (star5.Checked) return 5;
                if (star4.Checked) return 4;
                if (star3.Checked) return 3;
                if (star2.Checked) return 2;
                if (star1.Checked) return 1;
                return 0;
            }
        }
    }