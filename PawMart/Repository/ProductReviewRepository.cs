    using PawMart.Models;
    using System;
    using System.Collections.Generic;
    using System.Configuration;
    using System.Data.SqlClient;

    namespace PawMart.Repository
    {
        public class ProductReviewRepository
        {
            private readonly string connectionString;

            public ProductReviewRepository()
            {
                connectionString = ConfigurationManager.ConnectionStrings["PawMartConnectionString"].ConnectionString;
            }

            // ✅ Get all reviews
            public List<ProductReview> GetAllReviews()
            {
                List<ProductReview> reviews = new List<ProductReview>();

                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "SELECT * FROM ProductReview ORDER BY ReviewID DESC";
                        SqlCommand command = new SqlCommand(query, connection);

                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                ProductReview review = new ProductReview
                                {
                                    ReviewID = Convert.ToInt32(reader["ReviewID"]),
                                    ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                                    UserID = Convert.ToInt32(reader["UserID"]),
                                    OrderID = Convert.ToInt32(reader["OrderID"]),
                                    Rating = Convert.ToInt32(reader["Rating"]),
                                    ReviewText = reader["ReviewText"].ToString(),
                                    CreatedAt = Convert.ToDateTime(reader["CreatedAt"])
                                };

                                reviews.Add(review);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error retrieving reviews: " + ex.Message);
                }

                return reviews;
            }

            // ✅ Add new review
            public bool AddReview(ProductReview review)
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = @"INSERT INTO ProductReview 
                                        (UserID, ProductItemID, OrderID, Rating, ReviewText, CreatedAt)
                                         VALUES 
                                        (@UserID, @ProductItemID, @OrderID, @Rating, @ReviewText, @CreatedAt)";

                        SqlCommand command = new SqlCommand(query, connection);

                        command.Parameters.AddWithValue("@UserID", review.UserID);
                        command.Parameters.AddWithValue("@ProductItemID", review.ProductItemID);
                        command.Parameters.AddWithValue("@OrderID", review.OrderID);
                        command.Parameters.AddWithValue("@Rating", review.Rating);
                        command.Parameters.AddWithValue("@ReviewText", review.ReviewText ?? (object)DBNull.Value);
                        command.Parameters.AddWithValue("@CreatedAt", DateTime.Now);

                        connection.Open();
                        int rows = command.ExecuteNonQuery();

                        return rows > 0;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error adding review: " + ex.Message);
                    throw;
                }
            }

            // ✅ Get reviews by Product ID
            public List<ProductReview> GetReviewsByProductId(int productId)
            {
                List<ProductReview> reviews = new List<ProductReview>();

                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string query = "SELECT * FROM ProductReview WHERE ProductItemID = @ProductItemID ORDER BY CreatedAt DESC";

                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@ProductItemID", productId);

                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                ProductReview review = new ProductReview
                                {
                                    ReviewID = Convert.ToInt32(reader["ReviewID"]),
                                    ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                                    UserID = Convert.ToInt32(reader["UserID"]),
                                    OrderID = Convert.ToInt32(reader["OrderID"]),
                                    Rating = Convert.ToInt32(reader["Rating"]),
                                    ReviewText = reader["ReviewText"].ToString(),
                                    CreatedAt = Convert.ToDateTime(reader["CreatedAt"])
                                };

                                reviews.Add(review);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error retrieving product reviews: " + ex.Message);
                }

                return reviews;
            }
            public bool UpdateProductRating(int productId, double avgRating, int ratingCount)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"
                UPDATE Product
                SET AverageRating = @avg,
                    RatingCount = @count
                WHERE ProductItemID = @id";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@avg", avgRating);
                    cmd.Parameters.AddWithValue("@count", ratingCount);
                    cmd.Parameters.AddWithValue("@id", productId);

                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        public List<ProductReviewSummaryViewModel> GetReviewSummary()
        {
            List<ProductReviewSummaryViewModel> list = new List<ProductReviewSummaryViewModel>();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = @"
            SELECT 
                p.ProductItemID,
                p.Name AS ProductName,
                p.ImageURL AS ProductImage,
                ISNULL(AVG(CAST(r.Rating AS FLOAT)), 0) AS AverageRating,
                COUNT(r.ReviewID) AS ReviewCount,
                COUNT(DISTINCT oi.OrderID) AS OrderCount
            FROM Product p
            LEFT JOIN ProductReview r ON p.ProductItemID = r.ProductItemID
            LEFT JOIN OrderItems oi ON oi.ProductItemID = p.ProductItemID
            GROUP BY 
                p.ProductItemID, p.Name, p.ImageUrl";

                    SqlCommand command = new SqlCommand(query, connection);

                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            list.Add(new ProductReviewSummaryViewModel
                            {
                                ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                                ProductName = reader["ProductName"].ToString(),
                                ProductImage = reader["ProductImage"] != DBNull.Value
    ? reader["ProductImage"].ToString()
    : "~/Images/belt.jpeg",
                                AverageRating = Convert.ToDouble(reader["AverageRating"]),
                                ReviewCount = Convert.ToInt32(reader["ReviewCount"]),
                                OrderCount = Convert.ToInt32(reader["OrderCount"])
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // ⚠️ DO NOT silently ignore in debug
                throw new Exception("GetReviewSummary failed: " + ex.Message);
            }

            return list;
        }

        public List<dynamic> GetLatestReviews()
        {
            List<dynamic> list = new List<dynamic>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
        SELECT TOP 20
            p.Name AS ProductName,
            r.Rating,
            r.ReviewText,
            r.CreatedAt
        FROM ProductReview r
        INNER JOIN Product p ON p.ProductItemID = r.ProductItemID
        ORDER BY r.CreatedAt DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    list.Add(new
                    {
                        ProductName = reader["ProductName"].ToString(),
                        Rating = reader["Rating"],
                        ReviewText = reader["ReviewText"].ToString(),
                        CreatedAt = Convert.ToDateTime(reader["CreatedAt"])
                    });
                }
            }

            return list;
        }
    }
    }