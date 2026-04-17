using PawMart.Models;
using PawMart.Utility;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PawMart.Repository
{
    public class UserRepository
    {
        private readonly string connectionString;

        public UserRepository()
        {
            connectionString = ConfigurationManager
                .ConnectionStrings["PawMartConnectionString"].ConnectionString;
        }

        public List<User> GetAllUsers()
        {
            List<User> users = new List<User>();

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Users ORDER BY UserID DESC", connection);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            User user = new User
                            {
                                UserID = Convert.ToInt32(reader["UserID"]),
                                FullName = reader["FullName"].ToString(),
                                Email = reader["Email"].ToString(),
                                Password = reader["Password"].ToString(),
                                Phone = reader["Phone"].ToString(),
                                Address = reader["Address"].ToString(),
                                RegistrationDate = Convert.ToDateTime(reader["RegistrationDate"]),
                                UserType = reader["UserType"].ToString(),
                                IsActive = Convert.ToBoolean(reader["IsActive"])
                            };
                            users.Add(user);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error retrieving all users: " + ex.Message);
            }

            return users;
        }

        public User GetUserById(int userId)
        {
            User user = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Users WHERE UserID = @UserID", connection);
                    command.Parameters.AddWithValue("@UserID", userId);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            user = new User
                            {
                                UserID = Convert.ToInt32(reader["UserID"]),
                                FullName = reader["FullName"].ToString(),
                                Email = reader["Email"].ToString(),
                                Password = reader["Password"].ToString(),
                                Phone = reader["Phone"].ToString(),
                                Address = reader["Address"].ToString(),
                                RegistrationDate = Convert.ToDateTime(reader["RegistrationDate"]),
                                UserType = reader["UserType"].ToString(),
                                IsActive = Convert.ToBoolean(reader["IsActive"])
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine($"Error retrieving user with ID {userId}: " + ex.Message);
            }

            return user;
        }

        public User GetUserByEmail(string email)
        {
            User user = null;

            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Users WHERE Email = @Email", connection);
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            user = new User
                            {
                                UserID = Convert.ToInt32(reader["UserID"]),
                                FullName = reader["FullName"].ToString(),
                                Email = reader["Email"].ToString(),
                                Password = reader["Password"].ToString(),
                                Phone = reader["Phone"].ToString(),
                                Address = reader["Address"].ToString(),
                                RegistrationDate = Convert.ToDateTime(reader["RegistrationDate"]),
                                UserType = reader["UserType"].ToString(),
                                IsActive = Convert.ToBoolean(reader["IsActive"])
                            };
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine($"Error retrieving user with ID {email}: " + ex.Message);
            }

            return user;
        }

        public bool AddUser(User user)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(
                        "INSERT INTO Users (UserID,FullName, Email, Password, Phone, Address, RegistrationDate, UserType, IsActive) " +
                        "VALUES (@UserID,@FullName, @Email, @Password, @Phone, @Address, @RegistrationDate, @UserType, @IsActive)", connection);

                    command.Parameters.AddWithValue("@UserID", IdGenerator.GenerateUserId());
                    command.Parameters.AddWithValue("@FullName", user.FullName);
                    command.Parameters.AddWithValue("@Email", user.Email);
                    command.Parameters.AddWithValue("@Password", HashPassword(user.Password));
                    command.Parameters.AddWithValue("@Phone", user.Phone);
                    command.Parameters.AddWithValue("@Address", user.Address);
                    command.Parameters.AddWithValue("@RegistrationDate", DateTime.Now);
                    command.Parameters.AddWithValue("@UserType", user.UserType);
                    command.Parameters.AddWithValue("@IsActive", user.IsActive);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error adding a new user: " + ex.Message);
                throw;
            }
        }

        public bool UpdateUser(User user)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand(
                        "UPDATE Users SET FullName = @FullName, Email = @Email, Phone = @Phone, " +
                        "Address = @Address, UserType = @UserType, IsActive = @IsActive " +
                        "WHERE UserID = @UserID", connection);

                   

                    command.Parameters.AddWithValue("@UserID", user.UserID);
                    command.Parameters.AddWithValue("@FullName", user.FullName);
                    command.Parameters.AddWithValue("@Email", user.Email);
                    command.Parameters.AddWithValue("@Phone", user.Phone);
                    command.Parameters.AddWithValue("@Address", user.Address); // Fixed typo here
                    command.Parameters.AddWithValue("@UserType", user.UserType);
                    command.Parameters.AddWithValue("@IsActive", user.IsActive);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine($"Error updating user with ID {user.UserID}: " + ex.Message);
                throw;
            }
        }

        public bool DeleteUser(int userId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("DELETE FROM Users WHERE UserID = @UserID", connection);
                    command.Parameters.AddWithValue("@UserID", userId);

                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();

                    return rowsAffected > 0;
                }
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine($"Error deleting user with ID {userId}: " + ex.Message);
                throw;
            }
        }

        public bool ChangePassword(int userId, string currentPassword, string newPassword)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "UPDATE Users SET Password = @NewPassword WHERE UserID = @UserID AND Password = @CurrentPassword"; 
                using (SqlCommand command = new SqlCommand( query, connection))
                {
                    
                    command.Parameters.AddWithValue("@UserID", userId);
                    command.Parameters.AddWithValue("@CurrentPassword", HashPassword(currentPassword)); // Assume there's a hashing method
                    command.Parameters.AddWithValue("@NewPassword", HashPassword(newPassword));

                    connection.Open();
                    int result = command.ExecuteNonQuery();

                    return result > 0;
                }
            }
        }
        private string HashPassword(string password)
        {
            // In a real application, use a secure hashing algorithm like BCrypt
            // This is a placeholder for demonstration purposes
            return Convert.ToBase64String(
                System.Security.Cryptography.SHA256.Create().ComputeHash(
                    System.Text.Encoding.UTF8.GetBytes(password)
                )
            );
        }
    }
}