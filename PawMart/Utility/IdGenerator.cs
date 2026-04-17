using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.Utility
{
    public class IdGenerator
    {
        public static int GenerateUserId()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 10000);

            return code;
        }

        public static int GenerateCategoryId()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 20000);

            return code;
        }

        public static int GenerateProductItemId()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 30000);

            return code;
        }

        public static int GenerateOrderId()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 40000);

            return code;
        }
        public static int GenerateOrderItemId()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 50000);

            return code;
        }

        public static int GenerateOrderStatusUpdateId()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 60000);

            return code;
        }

        public static int GenerateCartItemID()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 70000);

            return code;
        }

        public static int GeneratePaymentID()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 80000);

            return code; 
        }

        public static int GenerateTransactionID()
        {
            // Get the current time in ticks (a long number)
            long ticks = DateTime.Now.Ticks;

            // Convert ticks to a 4-digit code
            int code = (int)(ticks % 90000);

            return code; 
        }
    }
}