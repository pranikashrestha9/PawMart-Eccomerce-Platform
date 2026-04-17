<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="PawMart.AboutUs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* About Us Page Styles */
        .about-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('Images/about-banner.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 0;
            text-align: center;
            margin-bottom: 50px;
            border-radius: 8px;
        }

        .about-hero h1 {
            font-size: 42px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .about-hero p {
            font-size: 18px;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .about-section {
            margin-bottom: 60px;
        }

        .about-section h2 {
            color: #FF6B35;
            font-size: 32px;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 15px;
        }

        .about-section h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 60px;
            height: 3px;
            background-color: #FF6B35;
        }

        .about-section p {
            font-size: 16px;
            line-height: 1.7;
            color: #555;
            margin-bottom: 15px;
        }

        .about-features {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            margin-top: 30px;
        }

        .feature-box {
            flex: 0 0 calc(25% - 20px);
            background-color: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .feature-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .feature-box i {
            font-size: 40px;
            color: #FF6B35;
            margin-bottom: 15px;
        }

        .feature-box h3 {
            font-size: 18px;
            margin-bottom: 12px;
            color: #333;
        }

        .feature-box p {
            font-size: 14px;
            color: #666;
        }

        .team-section {
            background-color: #f8f8f8;
            padding: 50px 0;
            border-radius: 8px;
        }

        .team-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .team-header h2 {
            color: #FF6B35;
            font-size: 32px;
            position: relative;
            display: inline-block;
            padding-bottom: 15px;
        }

        .team-header h2::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            width: 60px;
            height: 3px;
            background-color: #FF6B35;
            transform: translateX(-50%);
        }

        .team-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
        }

        .team-member {
            flex: 0 0 calc(25% - 30px);
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

/*        .member-image {
            height: 250px;
            overflow: hidden;
        }

        .member-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.5s ease;
        }

        .team-member:hover .member-image img {
            transform: scale(1.1);
        }*/

        .member-image {
            height: 250px;
            overflow: hidden;
        }

        .member-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.5s ease;
        }

        .team-member:hover .member-image img {
            transform: scale(1.03); /* reduced zoom */
        }

        .member-info {
            padding: 20px;
            text-align: center;
        }

        .member-info h3 {
            font-size: 18px;
            margin-bottom: 5px;
            color: #333;
        }

        .member-info p {
            color: #FF6B35;
            font-size: 14px;
            margin-bottom: 15px;
        }

        .member-social {
            display: flex;
            justify-content: center;
        }

        .member-social a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background-color: #f0f0f0;
            color: #555;
            margin: 0 5px;
            transition: all 0.3s ease;
        }

        .member-social a:hover {
            background-color: #FF6B35;
            color: white;
            transform: translateY(-3px);
        }

        .testimonials {
            margin: 60px 0;
            text-align: center;
        }

        .testimonials h2 {
            color: #FF6B35;
            font-size: 32px;
            margin-bottom: 40px;
            position: relative;
            display: inline-block;
            padding-bottom: 15px;
        }

        .testimonials h2::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            width: 60px;
            height: 3px;
            background-color: #FF6B35;
            transform: translateX(-50%);
        }

        .testimonial-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
        }

        .testimonial-card {
            flex: 0 0 calc(33.33% - 30px);
            background-color: #fff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);
            position: relative;
            transition: all 0.3s ease;
        }

        .testimonial-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }

        .testimonial-card i.quote {
            font-size: 30px;
            color: #FF6B35;
            opacity: 0.2;
            position: absolute;
            top: 20px;
            left: 20px;
        }

        .testimonial-text {
            font-style: italic;
            color: #555;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .testimonial-author {
            display: flex;
            align-items: center;
        }

        .author-image {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 15px;
        }

        .author-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .author-info h4 {
            color: #333;
            margin-bottom: 5px;
        }

        .author-info p {
            color: #777;
            font-size: 14px;
        }

        .rating {
            color: #FFD700;
            margin-top: 5px;
        }

        /* Responsive styles */
        @media (max-width: 992px) {
            .feature-box {
                flex: 0 0 calc(50% - 20px);
            }
            .team-member, .testimonial-card {
                flex: 0 0 calc(50% - 30px);
            }
        }

        @media (max-width: 768px) {
            .about-hero {
                padding: 60px 0;
            }
            .about-hero h1 {
                font-size: 36px;
            }
            .about-section h2, .team-header h2, .testimonials h2 {
                font-size: 28px;
            }
            .team-member {
                flex: 0 0 calc(50% - 20px);
            }
        }

        @media (max-width: 576px) {
            .feature-box, .team-member, .testimonial-card {
                flex: 0 0 100%;
            }
            .about-hero h1 {
                font-size: 32px;
            }
            .about-hero p {
                font-size: 16px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

     <!-- Hero Section -->
    <div class="about-hero">
        <h1>Our Story</h1>
        <p>Connecting food lovers with the best local cuisine since 2020</p>
    </div>

    <!-- About Section -->
    <div class="about-section">
        <h2>About PawMart</h2>
        <p>PawMart was born out of a simple yet powerful vision: to make delicious, quality food accessible to everyone with just a few clicks. Founded in 2020, we've quickly grown from a small startup to a trusted name in online food ordering across the country.</p>
        
        <p>Our platform connects hungry customers with a diverse range of local restaurants, offering a seamless ordering experience and reliable delivery service. We believe that good food brings people together, and we're passionate about being the bridge that makes those connections happen.</p>
        
        <p>What sets us apart is our commitment to quality, convenience, and customer satisfaction. We carefully select our restaurant partners, ensure timely deliveries, and constantly improve our platform based on user feedback. Whether you're craving comfort food, exploring international cuisines, or looking for healthy options, PawMart has something for everyone.</p>

        <!-- Features -->
        <div class="about-features">
            <div class="feature-box">
                <i class="fas fa-utensils"></i>
                <h3>Quality Selection</h3>
                <p>Carefully vetted restaurants that meet our high standards for quality and service</p>
            </div>
            
            <div class="feature-box">
                <i class="fas fa-shipping-fast"></i>
                <h3>Quick Delivery</h3>
                <p>Efficient delivery system that ensures your food arrives hot and fresh</p>
            </div>
            
            <div class="feature-box">
                <i class="fas fa-mobile-alt"></i>
                <h3>Easy Ordering</h3>
                <p>User-friendly platform designed for a seamless ordering experience</p>
            </div>
            
            <div class="feature-box">
                <i class="fas fa-heart"></i>
                <h3>Customer Focus</h3>
                <p>Dedicated support team ready to assist you with any questions or concerns</p>
            </div>
        </div>
    </div>

    <!-- Team Section -->
    <div class="team-section">
        <div class="team-header">
            <h2>Meet Our Team</h2>
            <p>The passionate people behind PawMart</p>
        </div>
        
        <div class="team-grid">
            <div class="team-member">
                <div class="member-image">
                    <img src="/Images/john.jpg" alt="John Smith">
                </div>
                <div class="member-info">
                    <h3>John Smith</h3>
                    <p>Founder & CEO</p>
                    <div class="member-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-image">
                    <img src="/Images/sarah.jpg" alt="Sarah Johnson">
                </div>
                <div class="member-info">
                    <h3>Sarah Johnson</h3>
                    <p>Head of Operations</p>
                    <div class="member-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-image">
                    <img src="/Images/michael.jpg" alt="Michael Chen">
                </div>
                <div class="member-info">
                    <h3>Michael Chen</h3>
                    <p>Chief Technology Officer</p>
                    <div class="member-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                    </div>
                </div>
            </div>
            
            <div class="team-member">
                <div class="member-image">
                    <img src="/Images/emma.jpg" alt="Emma Rodriguez">
                </div>
                <div class="member-info">
                    <h3>Emma Rodriguez</h3>
                    <p>Customer Success Manager</p>
                    <div class="member-social">
                        <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Testimonials -->
    <div class="testimonials">
        <h2>What Our Customers Say</h2>
        
        <div class="testimonial-grid">
            <div class="testimonial-card">
                <i class="fas fa-quote-left quote"></i>
                <p class="testimonial-text">"PawMart has completely changed how I order food. The app is so easy to use, and my orders always arrive on time. I love the variety of restaurants available!"</p>
                <div class="testimonial-author">
                    <div class="author-image">
                        <img src="/Images/david.jpg" alt="David Miller">
                    </div>
                    <div class="author-info">
                        <h4>David Miller</h4>
                        <p>Regular Customer</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="testimonial-card">
                <i class="fas fa-quote-left quote"></i>
                <p class="testimonial-text">"As a busy professional, I rely on PawMart for both lunch at the office and dinner at home. Their customer service is exceptional - they quickly resolved an issue I had with an order!"</p>
                <div class="testimonial-author">
                    <div class="author-image">
                        <img src="/Images/jennifer.jpg" alt="Jennifer Lee">
                    </div>
                    <div class="author-info">
                        <h4>Jennifer Lee</h4>
                        <p>Loyal Customer</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star-half-alt"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="testimonial-card">
                <i class="fas fa-quote-left quote"></i>
                <p class="testimonial-text">"I appreciate the wide selection of healthy food options on PawMart. As someone with dietary restrictions, it's been a game-changer to easily find restaurants that cater to my needs."</p>
                <div class="testimonial-author">
                    <div class="author-image">
                        <img src="/Images/robert.jpg" alt="Robert Taylor">
                    </div>
                    <div class="author-info">
                        <h4>Robert Taylor</h4>
                        <p>Weekly Customer</p>
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
