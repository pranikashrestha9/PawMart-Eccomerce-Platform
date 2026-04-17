using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
    public class OrderViewModel
    {
        public int OrderID { get; set; }
        public string FullName { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string OrderStatus { get; set; }
        public string PaymentMethod { get; set; }

        public string PaymentStatus { get; set; }
    }
}