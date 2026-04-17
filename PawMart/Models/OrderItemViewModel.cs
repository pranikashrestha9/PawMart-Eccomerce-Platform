using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
    public class OrderItemViewModel
    {
        public int OrderItemID { get; set; }
        public int OrderID { get; set; }
        public int ProductItemID { get; set; }
        public string ProductName { get; set; }
        public string ProductImage { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public decimal Subtotal { get; set; }
    }
}