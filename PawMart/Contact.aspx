<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="PawMart.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
      /* Contact Page Styles */
        .contact-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('Images/contact-banner.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 0;
            text-align: center;
            margin-bottom: 50px;
            border-radius: 8px;
        }

        .contact-hero h1 {
            font-size: 42px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .contact-hero p {
            font-size: 18px;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .contact-container {
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
            margin-bottom: 60px;
        }

        .contact-info {
            flex: 1;
            min-width: 300px;
        }

        .contact-info h2 {
            color: #FF6B35;
            font-size: 28px;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
        }

        .contact-info h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background-color: #FF6B35;
        }

        .contact-info p {
            margin-bottom: 30px;
            color: #555;
            line-height: 1.7;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 25px;
        }

        .info-icon {
            background-color: #FF6B35;
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .info-content h3 {
            font-size: 18px;
            margin-bottom: 5px;
            color: #333;
        }

        .info-content p {
            color: #666;
            margin-bottom: 0;
        }

        .contact-form {
            flex: 1;
            min-width: 300px;
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .contact-form h2 {
            color: #FF6B35;
            font-size: 28px;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
        }

        .contact-form h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background-color: #FF6B35;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        .form-control:focus {
            border-color: #FF6B35;
            outline: none;
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }

        .btn-submit {
            background-color: #FF6B35;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #e55a2a;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.3);
        }

        .map-section {
            margin-bottom: 60px;
        }

        .map-section h2 {
            color: #FF6B35;
            font-size: 28px;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
        }

        .map-section h2::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 50px;
            height: 3px;
            background-color: #FF6B35;
        }

        .map-container {
            height: 400px;
            background-color: #eee;
            border-radius: 8px;
            overflow: hidden;
        }

        .map-container iframe {
            width: 100%;
            height: 100%;
            border: none;
        }

        .faq-section {
            margin-bottom: 60px;
        }

        .faq-section h2 {
            color: #FF6B35;
            font-size: 28px;
            margin-bottom: 25px;
            position: relative;
            padding-bottom: 15px;
            text-align: center;
        }

        .faq-section h2::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            width: 50px;
            height: 3px;
            background-color: #FF6B35;
            transform: translateX(-50%);
        }

        .faq-item {
            margin-bottom: 15px;
            border: 1px solid #eee;
            border-radius: 8px;
            overflow: hidden;
        }

        .faq-question {
            background-color: #f9f9f9;
            padding: 15px 20px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 500;
            color: #333;
            transition: all 0.3s ease;
        }

        .faq-question:hover {
            background-color: #f0f0f0;
        }

        .faq-question i {
            transition: transform 0.3s ease;
        }

        .faq-question.active i {
            transform: rotate(180deg);
        }

        .faq-answer {
            padding: 0 20px;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }

        .faq-answer.active {
            padding: 15px 20px;
            max-height: 500px;
        }

        .faq-answer p {
            color: #666;
            line-height: 1.7;
            margin: 0;
        }

        /* Responsive styles */
        @media (max-width: 992px) {
            .contact-container {
                flex-direction: column;
            }
        }

        @media (max-width: 768px) {
            .contact-hero {
                padding: 60px 0;
            }
            .contact-hero h1 {
                font-size: 36px;
            }
            .info-icon {
                width: 35px;
                height: 35px;
            }
        }

        @media (max-width: 576px) {
            .contact-hero h1 {
                font-size: 32px;
            }
            .contact-hero p {
                font-size: 16px;
            }
            .contact-form, .contact-info {
                padding: 20px;
            }
            .map-container {
                height: 300px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <!-- Hero Section -->
    <div class="contact-hero">
        <h1>Get In Touch</h1>
        <p>We'd love to hear from you! Contact our team for any questions, feedback, or support.</p>
    </div>

    <!-- Contact Information and Form -->
    <div class="contact-container">
        <div class="contact-info">
            <h2>Contact Information</h2>
            <p>Have questions about our services or need assistance with your order? Reach out to our friendly support team through any of the channels below.</p>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-map-marker-alt"></i>
                </div>
                <div class="info-content">
                    <h3>Our Location</h3>
                    <p>123 Food Street, Kitchen City,<br>Food State, 12345</p>
                </div>
            </div>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-phone"></i>
                </div>
                <div class="info-content">
                    <h3>Phone Number</h3>
                    <p>+1 234 567 890<br>+1 987 654 321</p>
                </div>
            </div>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="info-content">
                    <h3>Email Address</h3>
                    <p>support@PawMart.com<br>info@PawMart.com</p>
                </div>
            </div>
            
            <div class="info-item">
                <div class="info-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="info-content">
                    <h3>Working Hours</h3>
                    <p>Monday - Friday: 9:00 AM - 8:00 PM<br>Saturday - Sunday: 10:00 AM - 6:00 PM</p>
                </div>
            </div>
        </div>
        
        <div class="contact-form">
            <h2>Send us a Message</h2>
            
            <div class="form-group">
                <label for="txtName">Your Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                    ErrorMessage="Name is required" Display="Dynamic" ForeColor="#FF6B35"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtEmail">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email" TextMode="Email"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="Email is required" Display="Dynamic" ForeColor="#FF6B35"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Please enter a valid email address" Display="Dynamic"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" ForeColor="#FF6B35"></asp:RegularExpressionValidator>
            </div>
            
            <div class="form-group">
                <label for="txtSubject">Subject</label>
                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Enter subject"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject" 
                    ErrorMessage="Subject is required" Display="Dynamic" ForeColor="#FF6B35"></asp:RequiredFieldValidator>
            </div>
            
            <div class="form-group">
                <label for="txtMessage">Your Message</label>
                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Write your message here..." TextMode="MultiLine" Rows="5"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" 
                    ErrorMessage="Message is required" Display="Dynamic" ForeColor="#FF6B35"></asp:RequiredFieldValidator>
            </div>
            
            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-submit" />
            <asp:Label ID="lblMessage" runat="server" ForeColor="#FF6B35" Visible="false"></asp:Label>
        </div>
    </div>

    <!-- Map Section -->
    <div class="map-section">
        <h2>Find Us</h2>
        <div class="map-container">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3022.215966570196!2d-73.98784868459448!3d40.75838197932695!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c258fdf71778d1%3A0xb7f503592a9b28c5!2sEmpire%20State%20Building!5e0!3m2!1sen!2sus!4v1649354532214!5m2!1sen!2sus" allowfullscreen="" loading="lazy"></iframe>
        </div>
    </div>

    <!-- FAQ Section -->
    <div class="faq-section">
        <h2>Frequently Asked Questions</h2>
        
        <div class="faq-item">
            <div class="faq-question">
                How long does delivery take?
                <i class="fas fa-chevron-down"></i>
            </div>
            <div class="faq-answer">
                <p>Our standard delivery time is between 30-45 minutes depending on your location and the time of day. During peak hours, delivery might take slightly longer. You can always track your order in real-time through our app.</p>
            </div>
        </div>
        
        <div class="faq-item">
            <div class="faq-question">
                Do you offer corporate catering services?
                <i class="fas fa-chevron-down"></i>
            </div>
            <div class="faq-answer">
                <p>Yes, we offer comprehensive corporate catering services for events, meetings, and office lunches. Please contact our catering department at catering@PawMart.com for custom quotes and menu options.</p>
            </div>
        </div>
        
        <div class="faq-item">
            <div class="faq-question">
                How can I change or cancel my order?
                <i class="fas fa-chevron-down"></i>
            </div>
            <div class="faq-answer">
                <p>Orders can be modified or canceled within 5 minutes of placing them. For any changes after this window, please contact our customer support team immediately at +1 234 567 890, and we'll do our best to accommodate your request.</p>
            </div>
        </div>
        
        <div class="faq-item">
            <div class="faq-question">
                Do you accommodate dietary restrictions?
                <i class="fas fa-chevron-down"></i>
            </div>
            <div class="faq-answer">
                <p>Absolutely! We offer various options for different dietary needs including vegetarian, vegan, gluten-free, and allergen-specific meals. You can filter menu items by dietary preferences on our website or app, or speak with our staff for personalized recommendations.</p>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            // FAQ accordion functionality
            $('.faq-question').click(function () {
                $(this).toggleClass('active');
                $(this).next('.faq-answer').toggleClass('active');
            });
        });
    </script>
</asp:Content>
