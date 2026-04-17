using PawMart.Models;
using PawMart.Repository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace PawMart.Service
{
    public class ProductReviewService
    {
        private readonly ProductReviewRepository _reviewRepository;
        private readonly OrderRepository _orderRepository;
        private readonly ProductRepository _productRepository;
     

        public ProductReviewService()
        {
            _reviewRepository = new ProductReviewRepository();
            _orderRepository = new OrderRepository();
            //_productRepository = new ProductRepository
        }

        // ✅ Get all reviews
        public List<ProductReview> GetAllReviews()
        {
            try
            {
                return _reviewRepository.GetAllReviews();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving reviews: " + ex.Message);
                throw;
            }
        }

        // ✅ Get reviews by Product ID
        public List<ProductReview> GetReviewsByProductId(int productId)
        {
            try
            {
                if (productId <= 0)
                {
                    throw new ArgumentException("Invalid Product ID");
                }

                return _reviewRepository.GetReviewsByProductId(productId);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error retrieving reviews by product ID: " + ex.Message);
                throw;
            }
        }

        // ✅ Add review
        public ServiceResult AddReview(ProductReview review)
        {
            try
            {
                if (review == null)
                    return new ServiceResult { Success = false, Message = "Invalid review data." };

                bool hasPurchased = _orderRepository.HasUserPurchasedProduct(
                    review.UserID,
                    review.ProductItemID,
                    review.OrderID
                );

                if (!hasPurchased)
                {
                    return new ServiceResult
                    {
                        Success = false,
                        Message = "You cannot review a product you have not purchased."
                    };
                }

                review.CreatedAt = DateTime.Now;

                bool inserted = _reviewRepository.AddReview(review);

                return new ServiceResult
                {
                    Success = inserted,
                    Message = inserted ? "Review submitted successfully." : "Failed to submit review."
                };
            }
            catch (Exception ex)
            {
                // 🔥 HANDLE UNIQUE KEY ERROR HERE
                if (ex.Message.Contains("UQ_User_Product_Order"))
                {
                    return new ServiceResult
                    {
                        Success = false,
                        Message = "You have already submitted a review for this product in this order."
                    };
                }

                return new ServiceResult
                {
                    Success = false,
                    Message = "Something went wrong. Please try again later."
                };
            }
        }
        //public void UpdateProductRating(int productId)
        //{
        //    try
        //    {
        //        var reviews = _reviewRepository.GetReviewsByProductId(productId);

        //        if (reviews == null || reviews.Count == 0)
        //            return;

        //        double avgRating = reviews.Average(r => r.Rating);
        //        int count = reviews.Count;

        //        _productRepository.UpdateProductRating(productId, avgRating, count);
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine("Error updating product rating: " + ex.Message);
        //        throw;
        //    }
        //}
        public List<ProductReview> GetProductReviews(int productId)
        {
            try
            {
                return _reviewRepository.GetReviewsByProductId(productId);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error getting reviews: " + ex.Message);
                throw;
            }
        }
        public List<ProductReviewSummaryViewModel> GetReviewSummary()
        {
            try
            {
                return _reviewRepository.GetReviewSummary();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                throw;
            }
        }

        public List<object> GetLatestReviews()
        {
            return _reviewRepository.GetLatestReviews();
        }
    }
}