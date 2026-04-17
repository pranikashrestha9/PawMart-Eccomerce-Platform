using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
	public class ProductReview
	{
        public int ReviewID { get; set; }
        public int ProductItemID { get; set; }
        public int UserID { get; set; }

        public int OrderID { get; set; } // Optional, if you want to link the review to a specific order
        public int Rating { get; set; } // 1 to 5
        public string ReviewText { get; set; }  
        public DateTime CreatedAt { get; set; }
    }
}