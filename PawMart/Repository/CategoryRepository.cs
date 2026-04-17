using PawMart.Models;
using PawMart.Utility;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using System.Web;

namespace PawMart.Repository
{
    public class CategoryRepository
    {
        private readonly string connectionString;
        public CategoryRepository()
        {

            connectionString = ConfigurationManager.ConnectionStrings["PawMartConnectionString"].ConnectionString;

        }


        public List<Category> GetAllCategories()
        {
            List<Category> categories = new List<Category>();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Category ORDER BY CategoryID DESC", connection);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Category category = new Category
                            {
                                CategoryID = Convert.ToInt32(reader["CategoryID"]),
                                Name = reader["Name"].ToString(),
                                Description = reader["Description"].ToString(),
                                CreatedAt = Convert.ToDateTime(reader["CreatedAt"])
                            };
                            categories.Add(category);


                        }



                    }

                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving all categories: " + ex.Message);
            }

            return categories;
        }

        public bool AddCategory(Category category)
        {

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("INSERT INTO Category(CategoryID,Name, Description, CreatedAt) VALUES(@CategoryId,@Name, @Description, @CreatedAt)", connection);
                    command.Parameters.AddWithValue("@CategoryId", IdGenerator.GenerateCategoryId());
                    command.Parameters.AddWithValue("@Name", category.Name);
                    command.Parameters.AddWithValue("@Description", category.Description);
                    command.Parameters.AddWithValue("@CreatedAt", DateTime.Now);
                    connection.Open();
                   int rowAffected = command.ExecuteNonQuery();
                    return rowAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error adding category: " + ex.Message);
                throw;
            }
        }

        public Category GetCategoryByName(string name)
        {
            Category category = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Category WHERE Name= @Name");
                    command.Parameters.AddWithValue("@Name", name);
                    connection.Open(); 


                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {

                            category = new Category
                            {
                                CategoryID = Convert.ToInt32(reader["CategoryID"]),
                                Name = Convert.ToString(reader["Name"]),
                                Description = Convert.ToString(reader["Description"]),
                                CreatedAt = Convert.ToDateTime(reader["CreatedAt"])
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retriving category data with {name}", ex.Message);
            }
            return category;
        }

        public bool isCategoryExistsByName(string name)
        {
          var flag = false;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Category WHERE Name= @Name",connection);
                    command.Parameters.AddWithValue("@Name", name);
                    connection.Open();


                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {

                            return flag=true;
                        }
                      
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retriving category data with {name}", ex.Message);
            }
            return flag;
        }

        public Category GetCategoryById(int categoryId)
        {
            Category category = null;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Category WHERE CategoryID= @CategoryId",connection);
                    command.Parameters.AddWithValue("@CategoryId", categoryId);
                    connection.Open();


                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {

                            category = new Category
                            {
                                CategoryID = Convert.ToInt32(reader["CategoryID"]),
                                Name = Convert.ToString(reader["Name"]),                                                                                       
                                Description = Convert.ToString(reader["Description"]),
                                CreatedAt = Convert.ToDateTime(reader["CreatedAt"])
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retriving category data with {categoryId}", ex.Message);
            }
            return category;
        }

        public bool UpdateCategory(Category category)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("UPDATE Category SET Name = @Name, Description = @Description WHERE CategoryID = @CategoryID", connection);
                    command.Parameters.AddWithValue("@Name", category.Name);
                    command.Parameters.AddWithValue("@Description", category.Description);
                    command.Parameters.AddWithValue("@CategoryID", category.CategoryID);
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error updating category: " + ex.Message);
                throw;
            }
        }

        public bool DeleteCategory(int categoryId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("DELETE FROM Category WHERE CategoryID = @CategoryID", connection);
                    command.Parameters.AddWithValue("@CategoryID", categoryId);
                    connection.Open();
                    int rowAffected = command.ExecuteNonQuery();
                    return rowAffected > 0;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error deleting category: " + ex.Message);
                throw;
            }
        }

    }



}


