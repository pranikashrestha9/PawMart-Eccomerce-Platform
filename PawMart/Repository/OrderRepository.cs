using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Configuration;
using PawMart.Models;
using PawMart.Utility;
using MySql.Data.MySqlClient;

namespace PawMart.Repository
{
    public class OrderRepository
    {
        private string connectionString;

        public OrderRepository()
        {
            connectionString = ConfigurationManager.ConnectionStrings["PawMartConnectionString"].ConnectionString;
        }

        public int InsertOrder(Order order)
        {
            order.OrderID = IdGenerator.GenerateOrderId();
            var paymentID = IdGenerator.GeneratePaymentID();


            string query1 = @"
                INSERT INTO Orders 
                (OrderID,UserID, OrderDate, TotalAmount, OrderStatus,PaymentID,DeliveryDate, PaymentMethod, 
                PaymentStatus, DeliveryAddress, ContactPhone, Notes) 
                VALUES 
                (@OrderID,@UserID, @OrderDate, @TotalAmount, @OrderStatus,@PaymentID,@DeliveryDate, @PaymentMethod, 
                @PaymentStatus, @DeliveryAddress, @ContactPhone, @Notes);
                ";
            string query2 = @"
                INSERT INTO OrderStatusUpdates
                (StatusUpdateID,OrderID, OrderStatus, Description, UpdatedDate) 
                VALUES 
                (@StatusUpdateID,@OrderID, @OrderStatus, @Description, @UpdatedDate)";
            string query3 = @"
                INSERT INTO Payments
                (PaymentID,Amount, PaymentMethod, PaymentStatus, TransactionID, PaymentDate) 
                VALUES 
                (@PaymentID,@Amount, @PaymentMethod, @PaymentStatus, @TransactionID, @PaymentDate)";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query3, connection))
                {
                    command.Parameters.AddWithValue("@PaymentID", paymentID);
                    command.Parameters.AddWithValue("@Amount", order.TotalAmount);
                    command.Parameters.AddWithValue("@PaymentMethod", order.PaymentMethod);
                    command.Parameters.AddWithValue("@PaymentStatus", order.PaymentStatus);
                    command.Parameters.AddWithValue("@TransactionID", IdGenerator.GenerateTransactionID());
                    command.Parameters.AddWithValue("@PaymentDate", order.OrderDate);

                    connection.Open();
                    command.ExecuteNonQuery();
                }



                using (SqlCommand command = new SqlCommand(query1, connection))
                {
                    // Add parameters
                    command.Parameters.AddWithValue("@OrderID", order.OrderID);
                    command.Parameters.AddWithValue("@UserID", order.UserID);
                    command.Parameters.AddWithValue("@OrderDate", order.OrderDate);
                    command.Parameters.AddWithValue("@TotalAmount", order.TotalAmount);
                    command.Parameters.AddWithValue("@OrderStatus", order.OrderStatus);
                    command.Parameters.AddWithValue("@PaymentID", paymentID);
                    command.Parameters.AddWithValue("@PaymentMethod", order.PaymentMethod);
                    command.Parameters.AddWithValue("@PaymentStatus", order.PaymentStatus);
                    command.Parameters.AddWithValue("@DeliveryAddress", order.DeliveryAddress);
                    command.Parameters.AddWithValue("@DeliveryDate", order.DeliveryDate ?? (object)DBNull.Value);
                    command.Parameters.AddWithValue("@ContactPhone", order.ContactPhone);
                    command.Parameters.AddWithValue("@Notes", order.Notes ?? (object)DBNull.Value);

                    command.ExecuteNonQuery();
                }
                using (SqlCommand command = new SqlCommand(query2, connection))
                {
                    command.Parameters.AddWithValue("@StatusUpdateID", IdGenerator.GenerateOrderStatusUpdateId());
                    command.Parameters.AddWithValue("@OrderID", order.OrderID);
                    command.Parameters.AddWithValue("@OrderStatus", order.OrderStatus);
                    command.Parameters.AddWithValue("@Description", "Order placed");
                    command.Parameters.AddWithValue("@UpdatedDate", order.OrderDate);
                    command.ExecuteNonQuery();
                }

            }


            return order.OrderID;
        }


        public void InsertOrderItems(List<OrderItem> orderItems, int orderId)
        {
            string query = @"
                INSERT INTO OrderItems
                (OrderItemID,OrderID, ProductItemID, Quantity, Price, Subtotal) 
                VALUES 
                (@OrderItemID,@OrderID, @ProductItemID, @Quantity, @Price, @Subtotal)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                foreach (var item in orderItems)
                {
                    item.OrderItemID = IdGenerator.GenerateOrderItemId();
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters
                        command.Parameters.AddWithValue("@OrderItemID", item.OrderItemID);
                        command.Parameters.AddWithValue("@OrderID", orderId);
                        command.Parameters.AddWithValue("@ProductItemID", item.ProductItemID);
                        command.Parameters.AddWithValue("@Quantity", item.Quantity);
                        command.Parameters.AddWithValue("@Price", item.Price);
                        command.Parameters.AddWithValue("@Subtotal", item.Subtotal);

                        command.ExecuteNonQuery();
                    }
                }
            }
        }


        public Order GetOrderById(int orderId)
        {
            Order order = null;
            string query = @"
                SELECT * FROM Orders
                WHERE OrderID = @OrderID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@OrderID", orderId);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            order = new Order
                            {
                                OrderID = Convert.ToInt32(reader["OrderID"]),
                                UserID = Convert.ToInt32(reader["UserID"]),
                                OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                                TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                                OrderStatus = reader["OrderStatus"].ToString(),
                                PaymentMethod = reader["PaymentMethod"].ToString(),
                                PaymentStatus = reader["PaymentStatus"].ToString(),
                                DeliveryAddress = reader["DeliveryAddress"].ToString(),
                                ContactPhone = reader["ContactPhone"].ToString(),
                                Notes = reader["Notes"] != DBNull.Value ? reader["Notes"].ToString() : null,

                            };
                        }
                    }
                }
            }

            return order;
        }

        public List<OrderItem> GetOrderItemsByOrderId(int orderId)
        {
            List<OrderItem> orderItems = new List<OrderItem>();
            string query = @"
                SELECT * FROM OrderItems
                WHERE OrderID = @OrderID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@OrderID", orderId);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orderItems.Add(new OrderItem
                            {
                                OrderItemID = Convert.ToInt32(reader["OrderItemID"]),
                                OrderID = Convert.ToInt32(reader["OrderID"]),
                                ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                                Quantity = Convert.ToInt32(reader["Quantity"]),
                                Price = Convert.ToDecimal(reader["Price"]),
                                Subtotal = Convert.ToDecimal(reader["Subtotal"])
                            });
                        }
                    }
                }
            }

            return orderItems;
        }

        public List<Order> GetOrdersByUserId(int userId)
        {
            List<Order> orders = new List<Order>();
            string query = @"
                SELECT * FROM Orders 
                WHERE UserID = @UserID 
                ORDER BY OrderDate DESC";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@UserID", userId);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            orders.Add(new Order
                            {
                                OrderID = Convert.ToInt32(reader["OrderID"]),
                                UserID = Convert.ToInt32(reader["UserID"]),
                                OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                                TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                                OrderStatus = reader["OrderStatus"].ToString(),
                                PaymentMethod = reader["PaymentMethod"].ToString(),
                                PaymentStatus = reader["PaymentStatus"].ToString()
                            });
                        }
                    }
                }
            }

            return orders;
        }

        public List<OrderViewModel> GetAllOrdersWithUserDetails()
        {
            var orders = new List<OrderViewModel>();

            string query = @"
                SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalAmount, 
                       o.OrderStatus, o.PaymentMethod,o.PaymentStatus
                FROM Orders o
                INNER JOIN Users u ON o.UserID = u.UserID
                ORDER BY o.OrderDate DESC";

            using (var connection = new SqlConnection(connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        orders.Add(new OrderViewModel
                        {
                            OrderID = Convert.ToInt32(reader["OrderID"]),
                            FullName = reader["FullName"].ToString(),
                            OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                            TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                            OrderStatus = reader["OrderStatus"].ToString(),
                            PaymentMethod = reader["PaymentMethod"].ToString(),
                            PaymentStatus = reader["PaymentStatus"].ToString(),

                        });
                    }
                }
            }

            return orders;
        }
        public Order GetOrder(int orderId, int userId)
        {
            Order order = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("SELECT * FROM Orders WHERE OrderID = @OrderID AND UserID = @UserID", connection);
                command.Parameters.AddWithValue("@OrderID", orderId);
                command.Parameters.AddWithValue("@UserID", userId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    order = new Order
                    {
                        OrderID = Convert.ToInt32(reader["OrderID"]),
                        UserID = Convert.ToInt32(reader["UserID"]),
                        OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                        TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                        OrderStatus = reader["OrderStatus"].ToString(),
                        PaymentMethod = reader["PaymentMethod"].ToString(),
                        PaymentStatus = reader["PaymentStatus"].ToString(),
                        DeliveryAddress = reader["DeliveryAddress"].ToString(),
                        ContactPhone = reader["ContactPhone"].ToString(),
                        Notes = reader["Notes"] != DBNull.Value ? reader["Notes"].ToString() : null
                    };
                }
            }

            return order;
        }

        public List<OrderViewModel> GetOrdersByStatus(string status)
        {
            var orders = new List<OrderViewModel>();

            string query = @"
                SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalAmount, 
                       o.OrderStatus, o.PaymentMethod, o.PaymentStatus
                FROM Orders o
                INNER JOIN Users u ON o.UserID = u.UserID
                WHERE o.OrderStatus = @Status
                ORDER BY o.OrderDate DESC";

            using (var connection = new SqlConnection(connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@Status", status);
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        orders.Add(new OrderViewModel
                        {
                            OrderID = Convert.ToInt32(reader["OrderID"]),
                            FullName = reader["FullName"].ToString(),
                            OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                            TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                            OrderStatus = reader["OrderStatus"].ToString(),
                            PaymentMethod = reader["PaymentMethod"].ToString(),
                            PaymentStatus = reader["PaymentStatus"].ToString()
                        });
                    }
                }
            }

            return orders;
        }

        public List<OrderViewModel> SearchOrders(string searchTerm)
        {
            var orders = new List<OrderViewModel>();

            string query = @"
                SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalAmount, 
                       o.OrderStatus, o.PaymentMethod, o.PaymentStatus
                FROM Orders o
                INNER JOIN Users u ON o.UserID = u.UserID
                WHERE o.OrderID LIKE @SearchTerm OR u.FullName LIKE @SearchTerm
                ORDER BY o.OrderDate DESC";

            using (var connection = new SqlConnection(connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@SearchTerm", $"%{searchTerm}%");
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        orders.Add(new OrderViewModel
                        {
                            OrderID = Convert.ToInt32(reader["OrderID"]),
                            FullName = reader["FullName"].ToString(),
                            OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                            TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                            OrderStatus = reader["OrderStatus"].ToString(),
                            PaymentMethod = reader["PaymentMethod"].ToString(),
                            PaymentStatus = reader["PaymentStatus"].ToString()
                        });
                    }
                }
            }

            return orders;
        }

        public List<OrderViewModel> SearchOrdersByStatus(string status, string searchTerm)
        {
            var orders = new List<OrderViewModel>();

            string query = @"
                SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalAmount, 
                       o.OrderStatus, o.PaymentMethod, o.PaymentStatus
                FROM Orders o
                INNER JOIN Users u ON o.UserID = u.UserID
                WHERE o.OrderStatus = @Status 
                  AND (o.OrderID LIKE @SearchTerm OR u.FullName LIKE @SearchTerm)
                ORDER BY o.OrderDate DESC";

            using (var connection = new SqlConnection(connectionString))
            using (var command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@Status", status);
                command.Parameters.AddWithValue("@SearchTerm", $"%{searchTerm}%");
                connection.Open();
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        orders.Add(new OrderViewModel
                        {
                            OrderID = Convert.ToInt32(reader["OrderID"]),
                            FullName = reader["FullName"].ToString(),
                            OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                            TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                            OrderStatus = reader["OrderStatus"].ToString(),
                            PaymentMethod = reader["PaymentMethod"].ToString(),
                            PaymentStatus = reader["PaymentStatus"].ToString()
                        });
                    }
                }
            }

            return orders;
        }

        public bool UpdateOrderStatus(int orderId, string newStatus)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(@"
                        UPDATE Orders
                        SET OrderStatus = @OrderStatus
                           
                        WHERE OrderID = @OrderID", connection);


                    command.Parameters.AddWithValue("@OrderID", orderId);
                    command.Parameters.AddWithValue("@OrderStatus", newStatus);

                    SqlCommand cmd = new SqlCommand(@"
                        UPDATE OrderStatusUpdates
                        SET OrderStatus = @OrderStatus
                           
                        WHERE OrderID = @OrderID", connection);

                    cmd.Parameters.AddWithValue("@OrderStatus", newStatus);
                    cmd.Parameters.AddWithValue("@OrderID", orderId);


                    if (newStatus == "Processing")
                    {
                        cmd.Parameters.AddWithValue("@Description", "Order processing");

                    }
                    else if (newStatus == "out for delivery")
                    {
                        cmd.Parameters.AddWithValue("@Description", "Order out for delivery");
                    }
                    else if (newStatus == "Delivered")
                    {
                        cmd.Parameters.AddWithValue("@Description", "Order delivered");
                    }
                    else if (newStatus == "Cancelled")
                    {
                        cmd.Parameters.AddWithValue("@Description", "Order cancelled");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Description", "Order status updated");
                    }

                    cmd.Parameters.AddWithValue("@UpdatedDate", DateTime.Now);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    int rowsAffected1 = cmd.ExecuteNonQuery();


                    return rowsAffected > 0;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public List<OrderItemViewModel> GetOrderItemsByOrder(int orderId)
        {
            List<OrderItemViewModel> orderItems = new List<OrderItemViewModel>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(
                    "SELECT oi.OrderItemID, oi.OrderID, oi.ProductItemID, oi.Quantity, oi.Price, oi.Subtotal, " +
                    "fi.Name AS Name, fi.ImageUrl AS ProductItemImage " +
                    "FROM OrderItems oi " +
                    "INNER JOIN Product fi ON oi.ProductItemID = fi.ProductItemID " +
                    "WHERE oi.OrderID = @OrderID", connection);

                command.Parameters.AddWithValue("@OrderID", orderId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    OrderItemViewModel item = new OrderItemViewModel
                    {
                        OrderItemID = Convert.ToInt32(reader["OrderItemID"]),
                        OrderID = Convert.ToInt32(reader["OrderID"]),
                        ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                        ProductName = reader["Name"].ToString(),
                        ProductImage = reader["ProductItemImage"] != DBNull.Value ? reader["ProductItemImage"].ToString() : null,
                        Quantity = Convert.ToInt32(reader["Quantity"]),
                        Price = Convert.ToDecimal(reader["Price"]),
                        Subtotal = Convert.ToDecimal(reader["Subtotal"])
                    };

                    orderItems.Add(item);
                }
            }

            return orderItems;
        }
        public List<OrderStatusUpdate> GetOrderStatusUpdates(int orderId)
        {
            List<OrderStatusUpdate> statusUpdates = new List<OrderStatusUpdate>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(
                    "SELECT * FROM OrderStatusUpdates WHERE OrderID = @OrderID ORDER BY UpdatedDate DESC", connection);

                command.Parameters.AddWithValue("@OrderID", orderId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    OrderStatusUpdate update = new OrderStatusUpdate
                    {
                        StatusUpdateID = Convert.ToInt32(reader["StatusUpdateID"]),
                        OrderID = Convert.ToInt32(reader["OrderID"]),
                        OrderStatus = reader["OrderStatus"].ToString(),
                        Description = reader["Description"] != DBNull.Value ? reader["Description"].ToString() : null,
                        UpdatedDate = Convert.ToDateTime(reader["UpdatedDate"])
                    };

                    statusUpdates.Add(update);
                }
            }

            return statusUpdates;
        }

        public List<OrderDetailViewModel> GetFilteredOrdersByUserId(int userId, string statusFilter, string sortOrder)
        {
            try
            {
                List<OrderDetailViewModel> orders = new List<OrderDetailViewModel>();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"
                    SELECT o.OrderID, o.UserID, o.OrderDate, o.TotalAmount, o.OrderStatus, 
                           o.PaymentMethod, o.PaymentStatus, o.DeliveryAddress, o.ContactPhone, o.Notes
                    FROM Orders o
                    WHERE o.UserID = @UserID";

                    if (!string.IsNullOrEmpty(statusFilter))
                    {
                        query += " AND o.OrderStatus = @Status";
                    }

                    // Add ORDER BY clause based on sortOrder
                    switch (sortOrder)
                    {
                        case "DateAsc":
                            query += " ORDER BY o.OrderDate ASC";
                            break;
                        case "AmountDesc":
                            query += " ORDER BY o.TotalAmount DESC";
                            break;
                        case "AmountAsc":
                            query += " ORDER BY o.TotalAmount ASC";
                            break;
                        case "DateDesc":
                        default:
                            query += " ORDER BY o.OrderDate DESC";
                            break;
                    }

                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@UserID", userId);

                    if (!string.IsNullOrEmpty(statusFilter))
                    {
                        command.Parameters.AddWithValue("@Status", statusFilter);
                    }

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            OrderDetailViewModel order = new OrderDetailViewModel
                            {
                                OrderID = Convert.ToInt32(reader["OrderID"]),
                                UserID = Convert.ToInt32(reader["UserID"]),
                                OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                                TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                                OrderStatus = reader["OrderStatus"].ToString(),
                                PaymentMethod = reader["PaymentMethod"].ToString(),
                                PaymentStatus = reader["PaymentStatus"].ToString(),
                                DeliveryAddress = reader["DeliveryAddress"].ToString(),
                                ContactPhone = reader["ContactPhone"].ToString(),
                                Notes = reader["Notes"] != DBNull.Value ? reader["Notes"].ToString() : string.Empty
                            };

                            orders.Add(order);
                        }
                    }
                }

                return orders;


            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public List<OrderItemViewModel> GetFilterdOrderItemByOrder(int orderId)
        {
            List<OrderItemViewModel> orderItems = new List<OrderItemViewModel>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT oi.OrderItemID, oi.OrderID, oi.ProductItemID, oi.Quantity, oi.Price,
                           f.Name AS ProductItemName, f.ImageUrl AS ProductItemImage
                    FROM OrderItems oi
                    INNER JOIN Product f ON oi.ProductItemID = f.ProductItemID
                    WHERE oi.OrderID = @OrderID";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@OrderID", orderId);

                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        int quantity = Convert.ToInt32(reader["Quantity"]);
                        decimal price = Convert.ToDecimal(reader["Price"]);
                        decimal subtotal = quantity * price;

                        OrderItemViewModel item = new OrderItemViewModel
                        {
                            OrderItemID = Convert.ToInt32(reader["OrderItemID"]),
                            OrderID = Convert.ToInt32(reader["OrderID"]),
                            ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                            ProductName = reader["ProductItemName"].ToString(),
                            ProductImage = reader["ProductItemImage"] != DBNull.Value ? reader["ProductItemImage"].ToString() : string.Empty,
                            Quantity = quantity,
                            Price = price,
                            Subtotal = subtotal
                        };

                        orderItems.Add(item);
                    }
                }
            }

            return orderItems;
        }


        public OrderStatusViewModel GetOrderStatusForMyOrder(int orderId, int userId)
        {
            OrderStatusViewModel orderStatus = null;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT o.OrderID, o.UserID, o.OrderDate, o.TotalAmount, o.OrderStatus, 
                           o.PaymentMethod, o.PaymentStatus, o.DeliveryAddress, o.ContactPhone, o.Notes,
                           (SELECT MAX(UpdatedDate) FROM OrderStatusUpdates WHERE OrderID = o.OrderID) AS LastUpdated
                    FROM Orders o
                    WHERE o.OrderID = @OrderID AND o.UserID = @UserID";

                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@OrderID", orderId);
                command.Parameters.AddWithValue("@UserID", userId);

                connection.Open();

                using (SqlDataReader reader = command.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        orderStatus = new OrderStatusViewModel
                        {
                            OrderID = Convert.ToInt32(reader["OrderID"]),
                            UserID = Convert.ToInt32(reader["UserID"]),
                            OrderDate = Convert.ToDateTime(reader["OrderDate"]),
                            TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                            OrderStatus = reader["OrderStatus"].ToString(),
                            CurrentStatus = reader["OrderStatus"].ToString(),
                            PaymentMethod = reader["PaymentMethod"].ToString(),
                            PaymentStatus = reader["PaymentStatus"].ToString(),
                            DeliveryAddress = reader["DeliveryAddress"].ToString(),
                            ContactPhone = reader["ContactPhone"].ToString(),
                            Notes = reader["Notes"] != DBNull.Value ? reader["Notes"].ToString() : string.Empty,
                            LastUpdated = reader["LastUpdated"] != DBNull.Value ? Convert.ToDateTime(reader["LastUpdated"]) : DateTime.Now
                        };
                    }
                }

                if (orderStatus != null)
                {
                    // Get status updates
                    query = @"
                        SELECT StatusUpdateID, OrderID, OrderStatus, Description, UpdatedDate
                        FROM OrderStatusUpdates
                        WHERE OrderID = @OrderID
                        ORDER BY UpdatedDate DESC";

                    command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@OrderID", orderId);

                    List<OrderStatusUpdate> statusUpdates = new List<OrderStatusUpdate>();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            OrderStatusUpdate update = new OrderStatusUpdate
                            {
                                StatusUpdateID = Convert.ToInt32(reader["StatusUpdateID"]),
                                OrderID = Convert.ToInt32(reader["OrderID"]),
                                OrderStatus = reader["OrderStatus"].ToString(),
                                Description = reader["Description"].ToString(),
                                UpdatedDate = Convert.ToDateTime(reader["UpdatedDate"])
                            };

                            statusUpdates.Add(update);
                        }
                    }

                    orderStatus.StatusUpdates = statusUpdates;


                }
            }

            return orderStatus;
        }
    

    public bool HasUserPurchasedProduct(int userId, int productItemId, int orderId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"
                SELECT COUNT(*) 
                FROM OrderItems oi
                INNER JOIN [Orders] o ON oi.OrderID = o.OrderID
                WHERE o.UserID = @UserID
                AND oi.ProductItemID = @ProductItemID
                AND o.OrderID = @OrderID";

                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@UserID", userId);
                    command.Parameters.AddWithValue("@ProductItemID", productItemId);
                    command.Parameters.AddWithValue("@OrderID", orderId);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();

                    return count > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error checking purchase: " + ex.Message);
                throw;
            }
        }
    }
};


