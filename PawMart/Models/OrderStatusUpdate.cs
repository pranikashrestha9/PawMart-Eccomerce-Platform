using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
    public class OrderStatusUpdate
    {
        public int StatusUpdateID { get; set; }
        public int OrderID { get; set; }
        public string OrderStatus { get; set; }
        public string Description { get; set; }
        public DateTime UpdatedDate { get; set; }
    }
}