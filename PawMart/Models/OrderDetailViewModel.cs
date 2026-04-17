using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
    public class OrderDetailViewModel
    {
        public int OrderID { get; set; }
        public int UserID { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public string OrderStatus { get; set; }
        public string PaymentMethod { get; set; }
        public string PaymentStatus { get; set; }
        public string DeliveryAddress { get; set; }
        public string ContactPhone { get; set; }
        public string Notes { get; set; }
        public List<OrderItemViewModel> OrderItems { get; set; }
    }
}