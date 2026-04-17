using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Models
{
	public class User
	{
        public int UserID { get; set; }
       
        public string Email { get; set; }
        public string Password { get; set; } 
        public string FullName { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public DateTime RegistrationDate { get; set; }
        public string UserType { get; set; } // Admin, Customer
        public bool IsActive { get; set; }
    }
}