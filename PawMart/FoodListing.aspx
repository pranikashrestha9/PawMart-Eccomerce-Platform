<%@ Page Title="" Language="C#" MasterPageFile="~/FoodyMan.Master" AutoEventWireup="true" CodeBehind="FoodListing.aspx.cs" Inherits="FoodyMan.FoodListing" %>
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
        
        .search-container {
            max-width: 600px;
            margin: 30px auto;
            position: relative;
        }
        
        .search-box {
            width: 100%;
            padding: 15px 20px;
            border-radius: 30px;
            border: 1px solid #e0e0e0;
            box-shadow: var(--card-shadow);
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .search-box:focus {
            outline: none;
            box-shadow: 0 0 0 2px var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .search-btn {
            position: absolute;
            right: 5px;
            top: 5px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .search-btn:hover {
            background-color: var(--text-color);
        }
        
        .filters {

            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 30px;
            justify-content: center;
        }
          .filters a {
              text-decoration: none;
              color: var(--text-color);
              font-size: 16px;
              padding: 10px 20px;
              border-radius: 20px;
              background-color: white;
              border: 1px solid #e0e0e0;
              transition: all 0.3s ease;
          }
        
        .filter-btn {
            text-decoration:none;
            background-color: white;
            border: 1px solid #e0e0e0;
            border-radius: 20px;
            padding: 8px 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .filter-btn:hover, .filter-btn.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 20px;
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
        
        /* Grid Layout Style */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 50px;
        }
        
        .product-card {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }
        
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        
        .product-tag {
            position: absolute;
            top: 15px;
            left: 15px;
            background-color: var(--accent-color);
            color: var(--text-color);
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .product-discount {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: var(--primary-color);
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .product-info {
            padding: 20px;
        }
        
        .product-title {
            font-size: 18px;
            margin: 0 0 10px 0;
            color: var(--text-color);
        }
        
        .product-description {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        
        .product-price {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .price-current {
            color: var(--primary-color);
        }
        
        .price-original {
            color: #999;
            text-decoration: line-through;
            font-size: 14px;
            margin-left: 8px;
        }
        
        .btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: 600;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            border: 1px solid var(--primary-color);
        }
        
        .btn-primary:hover {
            background-color: white;
            color: var(--primary-color);
        }
        
        .btn-outline {
            background-color: white;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
            margin-left: 10px;
        }
        
        .btn-outline:hover {
            background-color: var(--primary-color);
            color: white;
        }
        
        .empty-results {
            text-align: center;
            padding: 40px 0;
        }
        
        .pager {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin: 40px 0;
        }
        
        .page-link {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: white;
            color: var(--text-color);
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: var(--card-shadow);
        }
        
        .page-link:hover, .page-link.active {
            background-color: var(--primary-color);
            color: white;
        }
        
        
        .products-list {
            display: none;
        }
        /*  responsive adjustments */
        @media (max-width: 768px) {
            .products-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
        }
        
        @media (max-width: 576px) {
            .products-grid {
                display: none;
            }
            
            .products-list {
                display: block;
            }
            
            .list-product-card {
                display: flex;
                background-color: white;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: var(--card-shadow);
                margin-bottom: 15px;
            }
            
            .list-product-image {
                width: 120px;
                height: 120px;
                object-fit: cover;
            }
            
            .list-product-info {
                padding: 10px 15px;
                flex: 1;
            }
            
            .list-product-title {
                font-size: 16px;
                margin: 0 0 5px 0;
                color: var(--text-color);
            }
            
            .list-product-description {
                color: #666;
                font-size: 13px;
                margin-bottom: 5px;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
            
            .list-product-price {
                font-weight: bold;
                font-size: 16px;
                margin-bottom: 10px;
            }
            
            .list-product-actions {
                display: flex;
                justify-content: space-between;
            }
            
            .list-btn {
                padding: 6px 12px;
                font-size: 13px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="container">
        <h1 class="section-title">Our Menu</h1>

        <!-- Search Bar -->
        <div class="search-container">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search for your favorite foods..."></asp:TextBox>
            <asp:Button ID="btnSearch" runat="server" CssClass="search-btn" OnClick="btnSearch_Click" Text="🔍" />
        </div>

        <!-- Filter Buttons -->
        <div class="filters">
            <asp:LinkButton ID="btnAllCategories" runat="server" CssClass="filter-btn active" OnClick="btnCategory_Click" CommandArgument="0">All</asp:LinkButton>
            <asp:Repeater ID="rptCategories" runat="server" OnItemCommand="rptCategories_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton ID="btnCategory" runat="server" CssClass="filter-btn" CommandName="FilterByCategory" CommandArgument='<%# Eval("CategoryID") %>'>
                        <%# Eval("Name") %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Featured Products Section -->
        <asp:Panel ID="pnlFeatured" runat="server">
            <h2 class="section-title">Featured Items</h2>

            <!-- Featured Products Grid (Desktop/Tablet) -->
            <asp:Repeater ID="rptFeaturedProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                <HeaderTemplate>
                    <div class="products-grid">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="product-card">
                        <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Name") %>' class="product-image" onerror="this.src='<%# ResolveUrl("~/Images/placeholder-food.jpg") %>';" />
                        
                        <%# Eval("IsFeatured").ToString().ToLower() == "true" ? "<span class='product-tag'>Featured</span>" : "" %>
                        
                        <%# Convert.ToDecimal(Eval("DiscountPrice")) < Convert.ToDecimal(Eval("Price")) ? 
                            "<span class='product-discount'>Sale</span>" : "" %>
                        
                        <div class="product-info">
                            <h3 class="product-title"><%# Eval("Name") %></h3>
                            <p class="product-description"><%# Eval("Description") %></p>
                            
                            <div class="product-price">
                                <%# Convert.ToDecimal(Eval("DiscountPrice")) < Convert.ToDecimal(Eval("Price")) ? 
                                    "<span class='price-current'>$" + Eval("DiscountPrice", "{0:0.00}") + "</span>" +
                                    "<span class='price-original'>$" + Eval("Price", "{0:0.00}") + "</span>" :
                                    "<span class='price-current'>$" + Eval("Price", "{0:0.00}") + "</span>" %>
                            </div>
                            
                            <asp:LinkButton ID="btnViewDetails" runat="server" CssClass="btn btn-primary" CommandName="ViewDetails" CommandArgument='<%# Eval("FoodItemID") %>'>
                                View Details
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="btn btn-outline" CommandName="AddToCart" CommandArgument='<%# Eval("FoodItemID") %>' Visible='<%# Convert.ToBoolean(Eval("IsAvailable")) %>'>
                                Add to Cart
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
                <FooterTemplate>
                    </div>
                </FooterTemplate>
            </asp:Repeater>

            <!-- Featured Products List (Mobile) -->
            <asp:Repeater ID="rptFeaturedProductsMobile" runat="server" OnItemCommand="rptProducts_ItemCommand">
                <HeaderTemplate>
                    <div class="products-list">
                </HeaderTemplate>
                <ItemTemplate>
                    <div class="list-product-card">
                        <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Name") %>' class="list-product-image" onerror="this.src='<%# ResolveUrl("~/Images/placeholder-food.jpg") %>';" />
                        
                        <div class="list-product-info">
                            <h3 class="list-product-title"><%# Eval("Name") %></h3>
                            <p class="list-product-description"><%# Eval("Description") %></p>
                            
                            <div class="list-product-price">
                                <%# Convert.ToDecimal(Eval("DiscountPrice")) < Convert.ToDecimal(Eval("Price")) ? 
                                    "$" + Eval("DiscountPrice", "{0:0.00}") + " <span style='text-decoration:line-through;color:#999;font-size:13px;'>$" + Eval("Price", "{0:0.00}") + "</span>" :
                                    "$" + Eval("Price", "{0:0.00}") %>
                            </div>
                            
                            <div class="list-product-actions">
                                <asp:LinkButton ID="btnViewDetailsMobile" runat="server" CssClass="btn btn-primary list-btn" CommandName="ViewDetails" CommandArgument='<%# Eval("FoodItemID") %>'>
                                    View
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnAddToCartMobile" runat="server" CssClass="btn btn-outline list-btn" CommandName="AddToCart" CommandArgument='<%# Eval("FoodItemID") %>' Visible='<%# Convert.ToBoolean(Eval("IsAvailable")) %>'>
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
        </asp:Panel>

        <!-- All Products Section -->
        <h2 class="section-title">All Menu Items</h2>

        <!-- Products Grid (Desktop/Tablet) -->
        <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
            <HeaderTemplate>
                <div class="products-grid">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="product-card">
                    <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Name") %>' 
                        class="product-image" onerror="this.src='<%# ResolveUrl("~/Images/placeholder-food.jpg") %>';" />
                    
                    <%# Eval("IsFeatured").ToString().ToLower() == "true" ? "<span class='product-tag'>Featured</span>" : "" %>
                    
                    <%# Convert.ToDecimal(Eval("DiscountPrice")) < Convert.ToDecimal(Eval("Price")) ? 
                        "<span class='product-discount'>Sale</span>" : "" %>
                    
                    <div class="product-info">
                        <h3 class="product-title"><%# Eval("Name") %></h3>
                        <p class="product-description"><%# Eval("Description") %></p>
                        
                        <div class="product-price">
                            <%# Convert.ToDecimal(Eval("DiscountPrice")) < Convert.ToDecimal(Eval("Price")) ? 
                                "<span class='price-current'>$" + Eval("DiscountPrice", "{0:0.00}") + "</span>" +
                                "<span class='price-original'>$" + Eval("Price", "{0:0.00}") + "</span>" :
                                "<span class='price-current'>$" + Eval("Price", "{0:0.00}") + "</span>" %>
                        </div>
                        
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary" CommandName="ViewDetails" CommandArgument='<%# Eval("FoodItemID") %>'>
                            View Details
                        </asp:LinkButton>
                        
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-outline" CommandName="AddToCart"
                            CommandArgument='<%# Eval("FoodItemID") %>' Visible='<%# Convert.ToBoolean(Eval("IsAvailable")) %>'>
                            Add to Cart
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
            </FooterTemplate>
        </asp:Repeater>

        <!-- Products List (Mobile) -->
        <asp:Repeater ID="rptProductsMobile" runat="server" OnItemCommand="rptProducts_ItemCommand">
            <HeaderTemplate>
                <div class="products-list">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="list-product-card">
                    <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Name") %>' class="list-product-image" onerror="this.src='<%# ResolveUrl("~/Images/placeholder-food.jpg") %>';" />
                    
                    <div class="list-product-info">
                        <h3 class="list-product-title"><%# Eval("Name") %></h3>
                        <p class="list-product-description"><%# Eval("Description") %></p>
                        
                        <div class="list-product-price">
                            <%# Convert.ToDecimal(Eval("DiscountPrice")) < Convert.ToDecimal(Eval("Price")) ? 
                                "$" + Eval("DiscountPrice", "{0:0.00}") + " <span style='text-decoration:line-through;color:#999;font-size:13px;'>$" + Eval("Price", "{0:0.00}") + "</span>" :
                                "$" + Eval("Price", "{0:0.00}") %>
                        </div>
                        
                        <div class="list-product-actions">
                            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-primary list-btn" CommandName="ViewDetails" CommandArgument='<%# Eval("FoodItemID") %>'>
                                View
                            </asp:LinkButton>
                            
                            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-outline list-btn" CommandName="AddToCart" CommandArgument='<%# Eval("FoodItemID") %>' Visible='<%# Convert.ToBoolean(Eval("IsAvailable")) %>'>
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

        <!-- Empty Results Message -->
        <asp:Panel ID="pnlNoResults" runat="server" CssClass="empty-results" Visible="false">
            <i class="fas fa-search fa-3x" style="color: var(--primary-color); margin-bottom: 20px;"></i>
            <h2>No foods found</h2>
            <p>We couldn't find any foods matching your search. Try different keywords or browse our categories.</p>
            <asp:LinkButton ID="btnClearSearch" runat="server" CssClass="btn btn-primary" OnClick="btnClearSearch_Click">
                Clear Search
            </asp:LinkButton>
        </asp:Panel>

        <!-- Pagination -->
        <asp:Panel ID="pnlPagination" runat="server" CssClass="pager">
            <asp:LinkButton ID="btnFirstPage" runat="server" CssClass="page-link" OnClick="btnPagination_Click" CommandArgument="first">
                &laquo;
            </asp:LinkButton>
            
            <asp:LinkButton ID="btnPrevPage" runat="server" CssClass="page-link" OnClick="btnPagination_Click" CommandArgument="prev">
                &lsaquo;
            </asp:LinkButton>
            
            <asp:Repeater ID="rptPageNumbers" runat="server" OnItemCommand="rptPageNumbers_ItemCommand">
                <ItemTemplate>
                    <asp:LinkButton ID="btnPageNumber" runat="server" CssClass='<%# Convert.ToInt32(Eval("PageNumber")) == Convert.ToInt32(ViewState["CurrentPage"]) ? "page-link active" : "page-link" %>'
                        CommandName="GoToPage" CommandArgument='<%# Eval("PageNumber") %>'>
                        <%# Eval("PageNumber") %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
            
            <asp:LinkButton ID="btnNextPage" runat="server" CssClass="page-link" OnClick="btnPagination_Click" CommandArgument="next">
                &rsaquo;
            </asp:LinkButton>
            
            <asp:LinkButton ID="btnLastPage" runat="server" CssClass="page-link" OnClick="btnPagination_Click" CommandArgument="last">
                &raquo;
            </asp:LinkButton>
        </asp:Panel>
    </div>
</asp:Content>
