using PawMart.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PawMart
{
	public partial class ReviewDash : System.Web.UI.Page
	{
        private ProductReviewService _service;

        protected void Page_Load(object sender, EventArgs e)
		{
            _service = new ProductReviewService();

            if (!IsPostBack)
            {
                LoadReviews();
            }
        }

        private void LoadReviews()
        {
            gvReviews.DataSource = _service.GetReviewSummary();
            gvReviews.DataBind();

            gvLatestReviews.DataSource = _service.GetLatestReviews();
            gvLatestReviews.DataBind();
        }
        protected string GetRatingClass(object ratingObj)
        {
            if (ratingObj == null || ratingObj == DBNull.Value)
                return "rating rating-low";

            double r;
            if (!double.TryParse(ratingObj.ToString(), out r))
                return "rating rating-low";

            if (r >= 4) return "rating rating-high";
            if (r >= 2.5) return "rating rating-mid";
            return "rating rating-low";
        }
    }

}
