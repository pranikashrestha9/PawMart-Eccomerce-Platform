using PawMart.Models;
using PawMart.Utility;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;


namespace PawMart.Repository
    {
        public class ProductRepository
        {
            private readonly string connectionString;

            public ProductRepository()
            {
                connectionString = ConfigurationManager.ConnectionStrings["PawMartConnectionString"].ConnectionString;
            }

            // Get all food items
            public List<Product> GetAllProducts()
            {
                List<Product> Products = new List<Product>();
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        SqlCommand command = new SqlCommand("SELECT * FROM Product ORDER BY ProductItemID DESC", connection);
                        connection.Open();
                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                Product Product = new Product
                                {
                                    ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                                    Name = reader["Name"].ToString(),
                                    Description = reader["Description"].ToString(),
                                    Price = Convert.ToDecimal(reader["Price"]),
                                    DiscountPrice = Convert.ToDecimal(reader["DiscountPrice"]),
                                    ImageURL = reader["ImageURL"].ToString(),
                                    CategoryID = Convert.ToInt32(reader["CategoryID"]),
                                    IsAvailable = Convert.ToBoolean(reader["IsAvailable"]),
                                    IsFeatured = Convert.ToBoolean(reader["IsFeatured"]),
                                    CreatedAt = Convert.ToDateTime(reader["CreatedAt"]),
                                    UpdatedAt = Convert.ToDateTime(reader["UpdatedAt"])
                                };
                                Products.Add(Product);
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error retrieving all food items: " + ex.Message);
                }
                return Products;
            }

            // Add a new food item
            public bool AddProduct(Product Product)
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        SqlCommand command = new SqlCommand(
                            "INSERT INTO Product (ProductItemID, Name, Description, Price, DiscountPrice, ImageURL, CategoryID," +
                            " IsAvailable, IsFeatured, CreatedAt, UpdatedAt) " +
                            "VALUES (@ProductItemID, @Name, @Description, @Price, @DiscountPrice, @ImageURL, @CategoryID," +
                            " @IsAvailable, @IsFeatured, @CreatedAt, @UpdatedAt)", connection);

                        command.Parameters.AddWithValue("@ProductItemID", IdGenerator.GenerateProductItemId()); 
                        command.Parameters.AddWithValue("@Name", Product.Name);
                        command.Parameters.AddWithValue("@Description", Product.Description);
                        command.Parameters.AddWithValue("@Price", Product.Price);
                        command.Parameters.AddWithValue("@DiscountPrice", Product.DiscountPrice);
                        command.Parameters.AddWithValue("@ImageURL", Product.ImageURL);
                        command.Parameters.AddWithValue("@CategoryID", Product.CategoryID);
                        command.Parameters.AddWithValue("@IsAvailable", Product.IsAvailable);
                        command.Parameters.AddWithValue("@IsFeatured", Product.IsFeatured);
                        command.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
                        command.Parameters.AddWithValue("@UpdatedAt", DateTime.Now);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error adding product: " + ex.Message);
                    throw;
                }
            }

            // Get a food item by ID
            public Product GetProductById(int ProductId)
            {
                Product Product = null;
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        SqlCommand command = new SqlCommand("SELECT * FROM Product WHERE ProductItemID = @ProductItemID", connection);
                        command.Parameters.AddWithValue("@ProductItemID", ProductId);
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                Product = new Product
                                {
                                    ProductItemID = Convert.ToInt32(reader["ProductItemID"]),
                                    Name = reader["Name"].ToString(),
                                    Description = reader["Description"].ToString(),
                                    Price = Convert.ToDecimal(reader["Price"]),
                                    DiscountPrice = Convert.ToDecimal(reader["DiscountPrice"]),
                                    ImageURL = reader["ImageURL"].ToString(),
                                    CategoryID = Convert.ToInt32(reader["CategoryID"]),
                                    IsAvailable = Convert.ToBoolean(reader["IsAvailable"]),
                                    IsFeatured = Convert.ToBoolean(reader["IsFeatured"]),
                                    CreatedAt = Convert.ToDateTime(reader["CreatedAt"]),
                                    UpdatedAt = Convert.ToDateTime(reader["UpdatedAt"])
                                };
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error retrieving product item with ID {ProductId}: " + ex.Message);
                }
                return Product;
            }

            // Update a food item
            public bool UpdateProduct(Product Product)
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        SqlCommand command = new SqlCommand(
                            "UPDATE Product SET Name = @Name, Description = @Description, Price = @Price," +
                            " DiscountPrice = @DiscountPrice, " +
                            "ImageURL = @ImageURL, CategoryID = @CategoryID, IsAvailable = @IsAvailable, IsFeatured = @IsFeatured, UpdatedAt = @UpdatedAt " +
                            "WHERE ProductItemID = @ProductItemID", connection);

                        command.Parameters.AddWithValue("@Name", Product.Name);
                        command.Parameters.AddWithValue("@Description", Product.Description);
                        command.Parameters.AddWithValue("@Price", Product.Price);
                        command.Parameters.AddWithValue("@DiscountPrice", Product.DiscountPrice);
                        command.Parameters.AddWithValue("@ImageURL", Product.ImageURL);
                        command.Parameters.AddWithValue("@CategoryID", Product.CategoryID);
                        command.Parameters.AddWithValue("@IsAvailable", Product.IsAvailable);
                        command.Parameters.AddWithValue("@IsFeatured", Product.IsFeatured);
                        command.Parameters.AddWithValue("@UpdatedAt", DateTime.Now);
                        command.Parameters.AddWithValue("@ProductID", Product.ProductItemID);

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error updating product item: " + ex.Message);
                    throw;
                }
            }

            // Delete a food item by ID
            public bool DeleteProduct(int ProductItemID)
            {
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        SqlCommand command = new SqlCommand("DELETE FROM Product WHERE ProductItemID = @ProductItemID", connection);
                        command.Parameters.AddWithValue("@ProductItemID", ProductItemID);
                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error deleting product item: " + ex.Message);
                    throw;
                }
            }

            // Check if a food item exists by name
            public bool IsProductExistsByName(string name)
            {
                bool flag = false;
                try
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        SqlCommand command = new SqlCommand("SELECT * FROM Product WHERE Name = @Name", connection);
                        command.Parameters.AddWithValue("@Name", name);
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                flag = true;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error checking if product item exists with name {name}: " + ex.Message);
                }
                return flag;
            }
        }
    }

