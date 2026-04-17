using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
    public class Order
    {
        public int OrderID { get; set; }
        public int UserID { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public int PaymentID { get; set; }
        public string OrderStatus { get; set; } // Pending, Cancelled, Delivery, Delivered
        public string PaymentMethod { get; set; }
        public string PaymentStatus { get; set; } // Pending, Completed, Failed
        public string DeliveryAddress { get; set; }
        public string ContactPhone { get; set; }
        public DateTime? DeliveryDate { get; set; }
        public string Notes { get; set; }
    }
}