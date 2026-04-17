using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
	public class ProductReviewSummaryViewModel
	{
        public int ProductItemID { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }

        public double AverageRating { get; set; }
        public int ReviewCount { get; set; }
        public int OrderCount { get; set; }
    }
}