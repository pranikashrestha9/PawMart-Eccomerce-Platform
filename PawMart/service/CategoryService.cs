using PawMart.Models;
using PawMart.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace PawMart.service
{
	public class CategoryService
	{
        private readonly CategoryRepository _categoryRepository;

        public CategoryService()
        {
            _categoryRepository = new CategoryRepository();
        }

        // Get all categories
        public List<Category> GetAllCategories()
        {
            try
            {
                return _categoryRepository.GetAllCategories();
            }
            catch (Exception ex)
            {
                // Log the exception (you can use a logging framework like NLog, Serilog, etc.)
                Console.WriteLine("Error retrieving categories: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Add a new category
        public bool AddCategory(Category category)
        {
            try
            {
                var existingCategory = _categoryRepository.GetCategoryByName(category.Name);
                if (existingCategory != null)
                {
                    throw new InvalidOperationException("A category with the same name already exists.");
                }

                return _categoryRepository.AddCategory(category);
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error adding category: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Get a category by name
        public Category GetCategoryByNameService(string name)
        {
            try
            {
                var category = _categoryRepository.GetCategoryByName(name);

             
                if (category == null)
                {
                    throw new KeyNotFoundException($"Category with name '{name}' not found.");
                }
                return category;
            }
            catch (Exception ex)
            {
          
                Console.WriteLine("Error retrieving category by name: " + ex.Message);
                throw; 
            }
        }


        public Category GetCategoryById(int categoryId)
        {
            try
            {
                var category = _categoryRepository.GetCategoryById(categoryId);


                if (category == null)
                {
                    throw new KeyNotFoundException($"Category with name '{categoryId}' not found.");
                }
                return category;
            }
            catch (Exception ex)
            {

                Console.WriteLine("Error retrieving category by name: " + ex.Message);
                throw;
            }
        }

        // Update an existing category
        public bool UpdateCategory(Category category)
        {
            try
            {
                Category existingCategory = _categoryRepository.GetCategoryById(category.CategoryID);
                if (existingCategory == null)
                {
                    throw new Exception($"Category with this {category.CategoryID} doesnot exists");
                }
                bool isCategoryNameExists = _categoryRepository.isCategoryExistsByName(category.Name);
                if (isCategoryNameExists)
                {
                    throw new InvalidOperationException("Category name conflict detected.");
                }
                category.CreatedAt = existingCategory.CreatedAt;    
                return _categoryRepository.UpdateCategory(category);
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error updating category: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }

        // Delete a category by ID
        public bool DeleteCategory(int categoryId)
        {
            try
            {
                var category = _categoryRepository.GetCategoryById(categoryId); // Assuming name is unique
                if (category == null)
                {
                    throw new KeyNotFoundException($"Category with ID '{categoryId}' not found.");
                }
                return _categoryRepository.DeleteCategory(categoryId);
            }
            catch (Exception ex)
            {
                // Log the exception
                Console.WriteLine("Error deleting category: " + ex.Message);
                throw; // Re-throw the exception for the caller to handle
            }
        }
    }
}