

using PawMart.Models;
using PawMart.Repository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace PawMart.service
{
    public class ProductService
    {
        private readonly ProductRepository _productItemRepository;

        public ProductService()
        {
            _productItemRepository = new ProductRepository();
        }

        // Get all food items
        public List<Product> GetAllFoodItems()
        {
            try
            {
                return _productItemRepository.GetAllProducts();
            }
            catch (Exception ex)
            {
                // Log the exception (you can use a logging framework like NLog, Serilog, etc.)
                Console.WriteLine("Error retrieving product items: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Add a new food item
        public bool AddProductItem(Product productItem)
        {
            try
            {
                // Check if a food item with the same name already exists
                if (_productItemRepository.IsProductExistsByName(productItem.Name))
                {
                    throw new InvalidOperationException("A product item with the same name already exists.");
                }

                return _productItemRepository.AddProduct(productItem);
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error adding product item: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Get a food item by ID
        public Product GetProductById(int productItemId)
        {
            try
            {
                var productItem = _productItemRepository.GetProductById(productItemId);

                if (productItem == null)
                {
                    throw new KeyNotFoundException($"Product item with ID '{productItemId}' not found.");
                }
                return productItem;
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error retrieving product item by ID: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        public Product GetProductByCategoryId(int categoryId)
        {
            try
            {
                var productItem = _productItemRepository.GetProductById(categoryId);

                if (productItem == null)
                {
                    throw new KeyNotFoundException($"Product item with ID '{categoryId}' not found.");
                }
                return productItem;
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error retrieving product item by ID: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Update an existing food item
        public bool UpdateProduct(Product productItem)
        {
            try
            {
                // Check if the food item exists
                var existingProduct = _productItemRepository.GetProductById(productItem.ProductItemID);
                if (existingProduct == null)
                {
                    throw new KeyNotFoundException($"Product item with ID '{productItem.ProductItemID}' not found.");
                }

                // Check if the updated name conflicts with another food item
                if (_productItemRepository.IsProductExistsByName(productItem.Name) && existingProduct.Name != productItem.Name)
                {
                    throw new InvalidOperationException("A product item with the same name already exists.");
                }

                // Update the food item
                return _productItemRepository.UpdateProduct(productItem);
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error updating product item: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Delete a food item by ID
        public bool DeleteProduct(int productItemId)
        {
            try
            {
                // Check if the food item exists
                var productItem = _productItemRepository.GetProductById(productItemId);
                if (productItem == null)
                {
                    throw new KeyNotFoundException($"Product item with ID '{productItemId}' not found.");
                }

                // Delete the food item
                return _productItemRepository.DeleteProduct(productItemId);
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error deleting product item: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Check if a food item exists by name
        public bool IsProductExistsByName(string name)
        {
            try
            {
                return _productItemRepository.IsProductExistsByName(name);
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error checking if product item exists by name: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

            public List<Product> GetProductsByCategoryId(int categoryId)
        {
            try
            {
                return _productItemRepository.GetAllProducts()
                    .Where(p => p.CategoryID == categoryId)
                    .ToList();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving products by category: " + ex.Message);
                throw;
            }
        }
    }
    }
