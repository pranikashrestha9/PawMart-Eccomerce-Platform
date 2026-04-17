using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
    public class OrderStatusViewModel : OrderDetailViewModel
    {
        public string CurrentStatus { get; set; }
        public DateTime LastUpdated { get; set; }
        public List<OrderStatusUpdate> StatusUpdates { get; set; }
    }
}