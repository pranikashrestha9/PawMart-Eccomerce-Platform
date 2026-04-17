
using System;
using System.Collections.Generic;
using System.Linq;
using PawMart.Models;
using PawMart.Repositories;
using PawMart.service;
using PawMart.Utility;

namespace PawMart.Services
{
    public class CartService
    {
        private readonly CartRepository _cartRepository;
        private readonly ProductService _productService;

        public CartService()
        {
            _cartRepository = new CartRepository();
            _productService = new ProductService();
        }

        public Cart EnsureCartExists(int userID)
        {
            return _cartRepository.CreateCart(userID);
        }

        public void AddToCart(int userID, int ProductItemID, int quantity = 1)
        {
            // Get or create cart for user
            Cart cart = EnsureCartExists(userID);
            Product productItem = _productService.GetProductById(ProductItemID);

            // Create cart item
            CartItem cartItem = new CartItem
            {

                CartID = cart.CartID,
                ProductItemID = productItem.ProductItemID,
                Quantity = quantity,
                AddedAt = DateTime.Now
            };

            // Add item to cart
            _cartRepository.AddItemToCart(cartItem);
        }

        public List<CartItemViewModel> GetCartItemsWithDetails(int userID)
        {
            // Get user's cart
            Cart cart = _cartRepository.GetCartByUserID(userID);

            if (cart == null)
                return new List<CartItemViewModel>();

            // Get cart items
            List<CartItem> cartItems = _cartRepository.GetCartItems(cart.CartID);

            // Populate with food item details
            List<CartItemViewModel> cartItemsWithDetails = new List<CartItemViewModel>();

            foreach (var item in cartItems)
            {
                var foodItem = _productService.GetProductById(item.ProductItemID);

                if (foodItem != null)
                {
                    cartItemsWithDetails.Add(new CartItemViewModel
                    {
                        CartItemID = item.CartItemID,
                        ProductID = item.ProductItemID,
                        Name = foodItem.Name,
                        Price = foodItem.DiscountPrice < foodItem.Price ? foodItem.DiscountPrice : foodItem.Price,
                        Quantity = item.Quantity,
                        ImageURL = foodItem.ImageURL,
                        TotalPrice = (foodItem.DiscountPrice < foodItem.Price ? foodItem.DiscountPrice : foodItem.Price) * item.Quantity
                    });
                }
            }

            return cartItemsWithDetails;
        }

        public decimal CalculateCartTotal(int userID)
        {
            var cartItems = GetCartItemsWithDetails(userID);
            return cartItems.Sum(item => item.TotalPrice);
        }

        public int GetCartId(int userID)
        {
            try
            {
                Cart cart = _cartRepository.GetCartByUserID(userID);
                return cart.CartID;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Cart creation failed: {ex.Message}");
                throw;
            }
        }

        public bool ClearCart(int userID)
        {
            try
            {
                Cart cart = _cartRepository.GetCartByUserID(userID);
                return _cartRepository.ClearCartItems(cart.CartID);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error clearing cart: {ex.Message}");
                throw;
            }
        }



        public List<CartItem> GetCartItemsService(int cartItemID)
        {
            try
            {
                return _cartRepository.GetCartItemsByCartItemID(cartItemID);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error retrieving cart items: {ex.Message}");
                throw;
            }
        }
        public List<CartItem> GetCartItemsByUser(int userID)
        {
            Cart cart = _cartRepository.GetCartByUserID(userID);
            if (cart == null) return new List<CartItem>();

            return _cartRepository.GetCartItems(cart.CartID);
        }
        public void UpdateQuantity(int cartItemId, int quantity)
        {
            try
            {
                _cartRepository.UpdateCartItemQuantity(cartItemId, quantity);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error updating cart item: {ex.Message}");
                throw;
            }
        }

        public void DeleteCartItem(int cartItemId)
        {
            try
            {
                _cartRepository.DeleteCartItem(cartItemId);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error deleteing cart item: {ex.Message}");
                throw;
            }
        }
    }
}