<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="PawMart.ProductDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --accent-color: #ffbe0b;
            --text-color: #2d334a;
            --light-bg: #f8f9fa;
            --card-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .food-details-container {
            padding: 40px 0;
        }
        
        .breadcrumb {
            display: flex;
            margin-bottom: 30px;
            font-size: 14px;
            gap: 8px;
            align-items: center;
        }
        
        .breadcrumb a {
            color: var(--text-color);
            text-decoration: none;
        }
        
        .breadcrumb a:hover {
            color: var(--primary-color);
        }
        
        .breadcrumb-separator {
            color: #999;
        }
        
        .food-details {
            display: flex;
            margin-bottom: 40px;
            gap: 40px;
        }
        
        .food-image-container {
            flex: 1;
            max-width: 500px;
        }
        
        .food-image {
            width: 100%;
            height: auto;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            object-fit: cover;
        }
        
        .food-info {
            flex: 1;
        }
        
        .food-tags {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .food-tag {
            background-color: var(--accent-color);
            color: var(--text-color);
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .food-discount {
            background-color: var(--primary-color);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .food-name {
            font-size: 32px;
            color: var(--text-color);
            margin-bottom: 15px;
        }
        
        .food-description {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.6;
        }
        
        .food-price {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .price-current {
            font-size: 32px;
            font-weight: bold;
            color: var(--primary-color);
        }
        
        .price-original {
            margin-left: 15px;
            color: #999;
            text-decoration: line-through;
            font-size: 20px;
        }
        
        .food-availability {
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .available {
            color: #28a745;
        }
        
        .not-available {
            color: #dc3545;
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 25px;
        }
        
        .quantity-label {
            margin-right: 15px;
            font-weight: bold;
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            overflow: hidden;
        }
        
        .quantity-btn {
            width: 40px;
            height: 40px;
            background-color: var(--light-bg);
            border: none;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .quantity-btn:hover {
            background-color: #e0e0e0;
        }
        
        .quantity-input {
            width: 60px;
            height: 40px;
            border: none;
            border-left: 1px solid #e0e0e0;
            border-right: 1px solid #e0e0e0;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .btn {
            padding: 12px 24px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 16px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            border: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-primary:hover {
            background-color: #e45c5c;
        }
        
        .btn-outline {
            background-color: white;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }
        
        .btn-outline:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .food-meta {
            margin-top: 30px;
        }
        
        .meta-item {
            display: flex;
            margin-bottom: 10px;
        }
        
        .meta-label {
            width: 120px;
            font-weight: bold;
            color: var(--text-color);
        }
        
        .meta-value {
            color: #666;
        }
        
        /* Related foods section */
        .related-foods {
            margin-top: 60px;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            position: relative;
            color: var(--text-color);
        }
        
        .section-title:after {
            content: '';
            display: block;
            width: 60px;
            height: 3px;
            background-color: var(--primary-color);
            margin: 15px auto 0;
        }
        
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
        }
        
        .product-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }
        
        .product-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        
        .product-info {
            padding: 15px;
        }
        
        .product-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 8px;
            color: var(--text-color);
        }
        
        .product-price {
            color: var(--primary-color);
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 12px;
        }
        
        .product-action {
            display: flex;
            justify-content: space-between;
        }
        
        .small-btn {
            padding: 8px 16px;
            font-size: 14px;
        }
        
        /* Responsive Styling */
        @media (max-width: 992px) {
            .food-details {
                flex-direction: column;
                gap: 30px;
            }
            
            .food-image-container {
                max-width: 100%;
            }
            
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
        }
        
        @media (max-width: 576px) {
            .food-details-container {
                padding: 20px 0;
            }
            
            .food-name {
                font-size: 24px;
            }
            
            .food-description {
                font-size: 14px;
            }
            
            .price-current {
                font-size: 24px;
            }
            
            .price-original {
                font-size: 16px;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                gap: 15px;
            }
            
            .product-title {
                font-size: 14px;
            }
            
            .product-price {
                font-size: 14px;
            }
            
            .small-btn {
                padding: 6px 12px;
                font-size: 12px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="container food-details-container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="Default.aspx">Home</a>
            <span class="breadcrumb-separator">/</span>
            <a href="ProductListing.aspx">Menu</a>
            <span class="breadcrumb-separator">/</span>
            <span id="currentProduct" runat="server"></span>
        </div>

        <asp:Panel ID="pnlFoodDetails" runat="server">
            <div class="food-details">
                <!-- Food Image -->
                <div class="food-image-container">
                    <asp:Image ID="imgProduct" runat="server" CssClass="food-image" />
                </div>

                <!-- Food Information -->
                <div class="food-info">
                    <div class="food-tags">
                        <asp:Panel ID="pnlFeaturedTag" runat="server" CssClass="food-tag" Visible="false">
                            Featured
                        </asp:Panel>
                        <asp:Panel ID="pnlDiscountTag" runat="server" CssClass="food-discount" Visible="false">
                            Sale
                        </asp:Panel>
                    </div>

                    <h1 class="food-name" id="productName" runat="server"></h1>
                    <p class="food-description" id="productDescription" runat="server"></p>

                    <div class="food-price">
                        <span class="price-current" id="currentPrice" runat="server"></span>
                        <asp:Panel ID="pnlOriginalPrice" runat="server" CssClass="price-original" Visible="false">
                            <span id="originalPrice" runat="server"></span>
                        </asp:Panel>
                    </div>

                    <div class="food-availability">
                        <asp:Panel ID="pnlAvailable" runat="server" CssClass="available" Visible="false">
                            <i class="fas fa-check-circle"></i> In Stock
                        </asp:Panel>
                        <asp:Panel ID="pnlNotAvailable" runat="server" CssClass="not-available" Visible="false">
                            <i class="fas fa-times-circle"></i> Out of Stock
                        </asp:Panel>
                    </div>

                    <asp:Panel ID="pnlQuantitySelector" runat="server" CssClass="quantity-selector" Visible="false">
                        <span class="quantity-label">Quantity:</span>
                        <div class="quantity-controls">
                            <asp:Button ID="btnDecrease" runat="server" Text="-" CssClass="quantity-btn" OnClick="btnDecrease_Click" />
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="quantity-input" Text="1" TextMode="Number" min="1" max="10"></asp:TextBox>
                            <asp:Button ID="btnIncrease" runat="server" Text="+" CssClass="quantity-btn" OnClick="btnIncrease_Click" />
                        </div>
                    </asp:Panel>

                    <div class="action-buttons">
                        <asp:Button ID="btnAddToCart" runat="server" CssClass="btn btn-primary" Text="Add to Cart" OnClick="btnAddToCart_Click" />
                        <asp:Button ID="btnContinueShopping" runat="server" CssClass="btn btn-outline" Text="Continue Shopping" OnClick="btnContinueShopping_Click" />
                    </div>

                    <div class="food-meta">
                        <div class="meta-item">
                            <span class="meta-label">Category:</span>
                            <span class="meta-value" id="productCategory" runat="server"></span>
                        </div>
                       
                    </div>
                </div>
            </div>
        </asp:Panel>

        <!-- Error Panel -->
        <asp:Panel ID="pnlError" runat="server" Visible="false">
            <div style="text-align: center; padding: 50px 0;">
                <i class="fas fa-exclamation-circle fa-3x" style="color: var(--primary-color); margin-bottom: 20px;"></i>
                <h2>Food item not found</h2>
                <p>We couldn't find the food item you're looking for. It may have been removed or is no longer available.</p>
                <asp:Button ID="btnBackToMenu" runat="server" CssClass="btn btn-primary" Text="Back to Menu" OnClick="btnBackToMenu_Click" />
            </div>
        </asp:Panel>

        <!-- Related Foods Section -->
        <asp:Panel ID="pnlRelatedFoods" runat="server">
            <div class="related-foods">
                <h2 class="section-title">You Might Also Like</h2>
                
                <asp:Repeater ID="rptRelatedFoods" runat="server" OnItemCommand="rptRelatedFoods_ItemCommand">
                    <HeaderTemplate>
                        <div class="product-grid">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="product-card">
                            <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Name") %>' class="product-image" onerror="this.src='<%# ResolveUrl("~/Images/placeholder-food.jpg") %>';" />
                            
                            <div class="product-info">
                                <h3 class="product-title"><%# Eval("Name") %></h3>
                                
                                <div class="product-price">
                                    <%# Convert.ToDecimal(Eval("DiscountPrice")) < Convert.ToDecimal(Eval("Price")) ? 
                                        "$" + Eval("DiscountPrice", "{0:0.00}") : 
                                        "$" + Eval("Price", "{0:0.00}") %>
                                </div>
                                
                                <div class="product-action">
                                    <asp:LinkButton ID="btnViewDetails" runat="server" CssClass="btn btn-primary small-btn" CommandName="ViewDetails" CommandArgument='<%# Eval("ProductItemID") %>'>
                                        View
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="btn btn-outline small-btn" CommandName="AddToCart" CommandArgument='<%# Eval("ProductItemID") %>' Visible='<%# Convert.ToBoolean(Eval("IsAvailable")) %>'>
                                        Add
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        </div>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
