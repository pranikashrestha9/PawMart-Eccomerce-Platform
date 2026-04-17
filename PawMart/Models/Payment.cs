using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
	public class Payment
	{

        public int PaymentID { get; set; }
        public int OrderID { get; set; }
        public decimal Amount { get; set; }
        public string PaymentMethod { get; set; }
        public string TransactionID { get; set; }
        public string PaymentStatus { get; set; }
        public DateTime PaymentDate { get; set; }
    }
}