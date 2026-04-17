using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using PawMart.Models;
using PawMart.Repositories;
using PawMart.Repository;
using PawMart.Services;

namespace PawMart.Services
{
    public class OrderService
    {
        private OrderRepository _orderRepository;
        private CartService _cartService;

        public OrderService()
        {
            _orderRepository = new OrderRepository();
            _cartService = new CartService();
        }

        public int CreateOrder(Order order, List<OrderItem> orderItems)
        {
            // Validate order
            if (order == null || orderItems == null || orderItems.Count == 0)
            {
                throw new ArgumentException("Invalid order or order items");
            }

            // Begin transaction
            using (var transaction = new TransactionScope())
            {
                try
                {
                    // Insert order
                    int orderId = _orderRepository.InsertOrder(order);

                    // Update order items with the new order ID
                    foreach (var item in orderItems)
                    {
                        item.OrderID = orderId;
                    }

                    // Insert order items
                    _orderRepository.InsertOrderItems(orderItems, orderId);


                  
                    // Clear user's cart
                    _cartService.ClearCart(order.UserID);

                    // Commit transaction
                    transaction.Complete();

                    return orderId;
                }
                catch (Exception ex)
                {
                    // Log the exception
                    // You might want to use a logging framework here
                    Console.WriteLine($"Order creation failed: {ex.Message}");
                    throw;
                }
            }
        }

        public Order GetOrderDetails(int orderId)
        {
            // Retrieve order details
            Order order = _orderRepository.GetOrderById(orderId);

            if (order == null)
            {
                throw new KeyNotFoundException($"Order with ID {orderId} not found");
            }

            // Retrieve order items
            List<OrderItem> orderItems = _orderRepository.GetOrderItemsByOrderId(orderId);

            // You could enhance this by adding more details like food item names, etc.
            return order;
        }

        public OrderDetailViewModel GetOrderDetails(int orderId, int userId)
        {
            // Get order
            Order order = _orderRepository.GetOrder(orderId, userId);
            if (order == null)
            {
                return null;
            }

            // Get order items
            List<OrderItemViewModel> orderItems = _orderRepository.GetOrderItemsByOrder(orderId);

            // Create view model
            OrderDetailViewModel viewModel = new OrderDetailViewModel
            {
                OrderID = order.OrderID,
                UserID = order.UserID,
                OrderDate = order.OrderDate,
                TotalAmount = order.TotalAmount,
                OrderStatus = order.OrderStatus,
                PaymentMethod = order.PaymentMethod,
                PaymentStatus = order.PaymentStatus,
                DeliveryAddress = order.DeliveryAddress,
                ContactPhone = order.ContactPhone,
                Notes = order.Notes,
                OrderItems = orderItems
            };

            return viewModel;
        }

        public List<Order> GetUserOrders(int userId)
        {
            // Retrieve user's order history
            return _orderRepository.GetOrdersByUserId(userId);
        }

        public List<OrderDetailViewModel> GetUserFilteredOrders(int userId, string statusFilter = "", string sortOrder = "DateDesc")
        {
            // Retrieve user's order history
            return _orderRepository.GetFilteredOrdersByUserId(userId, statusFilter, sortOrder);
        }

        public List<OrderItemViewModel> GetOrderItems(int orderId)
        {
            return _orderRepository.GetFilterdOrderItemByOrder(orderId);
        }

        public OrderStatusViewModel GetOrderStatus(int orderId, int userId)
        {
            return _orderRepository.GetOrderStatusForMyOrder(orderId, userId);
        }

        // Helper method to calculate the percentage of progress based on order status
        public int CalculateOrderProgress(string orderStatus)
        {
            switch (orderStatus.ToLower())
            {
                case "pending":
                    return 25;
                case "processing":
                    return 50;
                case "delivery":
                    return 75;
                case "delivered":
                    return 100;
                case "cancelled":
                    return 0;
                default:
                    return 10; // Default progress for unknown status
            }
        }

        public bool UpdateOrderStatus(int orderId, string newStatus)
        {
            return _orderRepository.UpdateOrderStatus(orderId, newStatus);
          
        }

        public decimal CalculateOrderTotal(List<OrderItem> orderItems)
        {
            decimal total = 0;
            foreach (var item in orderItems)
            {
                total += item.Subtotal;
            }
            return total;
        }

        public List<OrderItem> GetOrderedItemsByOrderId(int orderId)
        {
            try
            {
                return _orderRepository.GetOrderItemsByOrderId(orderId);
            }
            catch (Exception ex)
            {
                // Log the exception
                // You might want to use a logging framework here
                Console.WriteLine($"Failed to get order items for order ID {orderId}: {ex.Message}");
            }
            return null;
        }


        public List<OrderViewModel> GetAllOrdersWithUserDetails()
        {
            // Fetch all orders with user names
            return _orderRepository.GetAllOrdersWithUserDetails();
        }

        public List<OrderViewModel> GetOrdersByStatus(string status)
        {
            return _orderRepository.GetOrdersByStatus(status);
        }

        public List<OrderViewModel> SearchOrders(string searchTerm)
        {
            return _orderRepository.SearchOrders(searchTerm);
        }

        public List<OrderViewModel> SearchPendingOrders(string searchTerm)
        {
            return _orderRepository.SearchOrdersByStatus("Pending", searchTerm);
        }

        public List<OrderViewModel> SearchCompletedOrders(string searchTerm)
        {
            return _orderRepository.SearchOrdersByStatus("Completed", searchTerm);
        }

        public List<OrderViewModel> SearchCancelledOrders(string searchTerm)
        {
            return _orderRepository.SearchOrdersByStatus("Cancelled", searchTerm);
        }


        public OrderStatusViewModel GetOrderStatusDetails(int orderId, int userId)
        {
            // Get order details
            OrderDetailViewModel orderDetails = GetOrderDetails(orderId, userId);
            if (orderDetails == null)
            {
                return null;
            }

            // Get status updates
            List<OrderStatusUpdate> statusUpdates = _orderRepository.GetOrderStatusUpdates(orderId);

            // Create view model
            OrderStatusViewModel viewModel = new OrderStatusViewModel
            {
                OrderID = orderDetails.OrderID,
                UserID = orderDetails.UserID,
                OrderDate = orderDetails.OrderDate,
                TotalAmount = orderDetails.TotalAmount,
                OrderStatus = orderDetails.OrderStatus,
                PaymentMethod = orderDetails.PaymentMethod,
                PaymentStatus = orderDetails.PaymentStatus,
                DeliveryAddress = orderDetails.DeliveryAddress,
                ContactPhone = orderDetails.ContactPhone,
                Notes = orderDetails.Notes,
                OrderItems = orderDetails.OrderItems,
                StatusUpdates = statusUpdates,
                CurrentStatus = orderDetails.OrderStatus,
                LastUpdated = statusUpdates.Any() ? statusUpdates.First().UpdatedDate : orderDetails.OrderDate
            };

            return viewModel;
        }
    }
}