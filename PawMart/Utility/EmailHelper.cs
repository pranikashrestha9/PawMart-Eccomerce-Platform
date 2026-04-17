using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using PawMart.Models;
using PawMart.Services;

namespace PawMart.Utility
{
    public static class EmailHelper
    {
        private static readonly string fromEmail = "shrlaxman9861@gmail.com"; // Your Gmail
        private static readonly string fromDisplayName = "PawMart";
        private static readonly string appPassword = "rtkk uovd ukvg rjdz"; // Gmail App Password

        public static bool SendWelcomeEmail(string toEmail, string userName)
        {
            try
            {
                var fromAddress = new MailAddress(fromEmail, fromDisplayName);
                var toAddress = new MailAddress(toEmail);
                const string subject = "🎉 Welcome to PawMart!";
                string body = $@"
                    <div style='font-family:Segoe UI, sans-serif; padding:20px;'>
                        <h2>Hi {userName},</h2>
                        <p>Thank you for registering with <strong>PawMart</strong>! We're thrilled to have you on board.</p>
                        <p>Explore our varieties of food categories and enjoy delicious food items here.</p>
                        <br/>
                        <p>Cheers,</p>
                        <p><strong>PawMart Team</strong></p>
                    </div>";

                var message = new MailMessage
                {
                    From = fromAddress,
                    Subject = subject,
                    Body = body,
                    IsBodyHtml = true
                };
                message.To.Add(toAddress);

                var smtp = new SmtpClient("smtp.gmail.com", 587)
                {
                    EnableSsl = true,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromEmail, appPassword),
                    DeliveryMethod = SmtpDeliveryMethod.Network
                };

                smtp.Send(message);
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Email send error: " + ex.Message);
                return false;
            }
        }

        public static bool SendOrderConfirmationEmail(string userEmail, Order order)
        {
            try
            {
                if (string.IsNullOrEmpty(userEmail))
                    return false;

                var fromAddress = new MailAddress(fromEmail, fromDisplayName);
                var toAddress = new MailAddress(userEmail);
                string subject = $"Your Order Confirmation #{order.OrderID} - PawMart";

                // Get order items with food names (assuming you have this data)
                var orderService = new OrderService();
                var orderItems = orderService.GetOrderItems(order.OrderID);

                // Build email body
                string emailBody = BuildOrderConfirmationEmailBody(order, orderItems);

                var message = new MailMessage
                {
                    From = fromAddress,
                    Subject = subject,
                    Body = emailBody,
                    IsBodyHtml = true
                };
                message.To.Add(toAddress);

                var smtp = new SmtpClient("smtp.gmail.com", 587)
                {
                    EnableSsl = true,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential(fromEmail, appPassword),
                    DeliveryMethod = SmtpDeliveryMethod.Network
                };

                smtp.Send(message);
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Order confirmation email send error: " + ex.Message);
                return false;
            }
        }

        private static string BuildOrderConfirmationEmailBody(Order order, List<OrderItemViewModel> orderItems)
        {
            // Calculate totals if not already set
            decimal subtotal = orderItems.Sum(oi => oi.Subtotal);
            decimal tax = order.TotalAmount - subtotal; // Assuming tax is the difference
            decimal shipping = 0; // Adjust as needed

            // Build the email template
            string emailBody = @"
            <html>
            <head>
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; }
                    .header { background-color: #4CAF50; color: white; padding: 20px; text-align: center; }
                    .content { padding: 20px; background-color: #f9f9f9; }
                    .order-info { background-color: white; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
                    .footer { background-color: #f1f1f1; padding: 10px; text-align: center; font-size: 12px; }
                    table { width: 100%; border-collapse: collapse; margin: 15px 0; }
                    th, td { padding: 12px 8px; text-align: left; border-bottom: 1px solid #ddd; }
                    th { background-color: #f2f2f2; }
                    .totals { text-align: right; }
                    .btn { display: inline-block; padding: 10px 20px; background-color: #4CAF50; color: white; 
                          text-decoration: none; border-radius: 4px; font-weight: bold; }
                </style>
            </head>
            <body>
                <div class='container'>
                    <div class='header'>
                        <h1>Order Confirmation</h1>
                    </div>
                    <div class='content'>
                        <p>Dear Customer,</p>
                        <p>Thank you for your order! We're pleased to confirm that we've received your order and it's being processed.</p>
                        
                        <div class='order-info'>
                            <h2>Order #" + order.OrderID + @"</h2>
                            <p>Order Date: " + order.OrderDate.ToString("MMMM dd, yyyy") + @"</p>
                            <p>Delivery Address: " + order.DeliveryAddress + @"</p>
                            <p>Contact Phone: " + order.ContactPhone + @"</p>
                        </div>
                        
                        <h3>Order Summary</h3>
                        <table>
                            <tr>
                                <th>Food Item</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Subtotal</th>
                            </tr>";

            // Add order details rows
            foreach (var item in orderItems)
            {
                emailBody += $@"
                <tr>
                    <td>{item.ProductName}</td>
                    <td>{item.Quantity}</td>
                    <td>{item.Price:C2}</td>
                    <td>{item.Subtotal:C2}</td>
                </tr>";
            }

            // Add order totals
            emailBody += $@"
                        </table>
                        
                        <div class='totals'>
                            <p><strong>Subtotal:</strong> {subtotal:C2}</p>
                            <p><strong>Shipping:</strong> {shipping:C2}</p>
                            <p><strong>Tax:</strong> {tax:C2}</p>
                            <p style='font-size: 18px;'><strong>Total:</strong> {order.TotalAmount:C2}</p>
                        </div>
                        
                        <p>We'll send you another email when your order ships.</p>
                        <p>Thank you for ordering with PawMart!</p>
                        
                        <p style='text-align: center; margin-top: 30px;'>
                            <a href='https://yourdomain.com/User/OrderHistory.aspx' class='btn'>View Order History</a>
                        </p>
                    </div>
                    <div class='footer'>
                        <p>© " + DateTime.Now.Year + @" PawMart. All rights reserved.</p>
                        <p>If you have any questions, please contact our customer service at support@PawMart.com</p>
                    </div>
                </div>
            </body>
            </html>";

            return emailBody;
        }
    }
}