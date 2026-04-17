using PawMart.Models;
using PawMart.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PawMart.service
{
    public class UserService
    {
        private readonly UserRepository _userRepository;

        public UserService()
        {
            _userRepository = new UserRepository();
        }

        public List<User> GetAllUsers()
        {
            return _userRepository.GetAllUsers();
        }

        public User GetUserByEmail(string email)
        {
            try
            {
                
                User user = _userRepository.GetUserByEmail(email);
                if(user == null)
                {
                    throw new Exception("User Not found");
                }
                return user;
            }catch(Exception)
            {
                throw;
            }
           
        }

        public User GetUserById(int userId)
        {
            return _userRepository.GetUserById(userId);
        }

        public bool AddUser(User user)
        {
            // You can add validation or business logic here
            return _userRepository.AddUser(user);
        }

        public bool UpdateUser(User user)
        {
            // You can add validation or business logic here
            return _userRepository.UpdateUser(user);
        }

        public bool DeleteUser(int userId)
        {
            // You can add validation or business logic here
            return _userRepository.DeleteUser(userId);
        }
        public bool ChangePassword(int userId, string currentPassword, string newPassword)
        {
          

            ValidatePasswordStrength(newPassword);

            return _userRepository.ChangePassword(userId, currentPassword, newPassword);
        }

        public bool ValidateUser(string email, string password)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(password))
                return false;

            User user = _userRepository.GetUserByEmail(email);

            if (user == null || !user.IsActive)
                return false;

            // In a real application, you would compare hashed passwords
            // For demonstration purposes, we're assuming that the password in the DB is already hashed
            string hashedPassword = Convert.ToBase64String(
                System.Security.Cryptography.SHA256.Create().ComputeHash(
                    System.Text.Encoding.UTF8.GetBytes(password)
                )
            );

            return user.Password == hashedPassword;
        }

        private void ValidatePasswordStrength(string password)
        {
            // Password must be at least 8 characters and include uppercase, lowercase, number, and special character
            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$"))
                throw new ArgumentException("Password must be at least 8 characters and include uppercase, lowercase, number, and special character", nameof(password));
        }
    }
}