<%@ Page Title="Home" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PawMart.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <style>
        :root {
            --brand: #E8531A;
            --brand-dark: #C4420E;
            --brand-hover: #FF6B35;
            --text-primary: #111827;
            --text-secondary: #6B7280;
            --text-muted: #9CA3AF;
            --bg-page: #F9FAFB;
            --bg-white: #FFFFFF;
            --bg-subtle: #F3F4F6;
            --border: #E5E7EB;
            --border-strong: #D1D5DB;
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 24px;
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            --shadow-md: 0 4px 12px rgba(0,0,0,0.08), 0 2px 4px rgba(0,0,0,0.04);
            --shadow-lg: 0 12px 32px rgba(0,0,0,0.10), 0 4px 8px rgba(0,0,0,0.06);
        }

        *, *::before, *::after {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            color: var(--text-primary);
            background: var(--bg-page);
            -webkit-font-smoothing: antialiased;
        }

        /* ── Error Message ── */
        .error-message {
            display: block;
            padding: 12px 16px;
            margin: 12px 0;
            background: #FEF2F2;
            border: 1px solid #FECACA;
            border-radius: var(--radius-sm);
            font-size: 0.875rem;
            font-weight: 500;
            color: #DC2626;
        }

        /* ─────────────────────────────────────────
           HERO SECTION
        ───────────────────────────────────────── */
        .hero-section {
            position: relative;
            background-image: url('/images/hero1.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 120px 20px;
            color: white;
            overflow: hidden;
        }

        .hero-section::before {
            content: "";
            position: absolute;
            inset: 0;
            background: rgba(0, 0, 0, 0.55);
            z-index: 1;
        }

        .hero-section::after {
            content: '';
            position: absolute;
            top: -20%;
            left: 50%;
            transform: translateX(-50%);
            width: 800px;
            height: 500px;
            background: radial-gradient(ellipse, rgba(232,83,26,0.18) 0%, transparent 65%);
            pointer-events: none;
        }

        .hero-section .container {
            position: relative;
            z-index: 2;
            max-width: 900px;
        }

        .hero-title {
            font-size: clamp(1.8rem, 4vw, 3.2rem);
        }

        .hero-title em {
            font-style: normal;
            color: var(--brand-hover);
        }

        .hero-subtitle {
            font-size: clamp(0.95rem, 2vw, 1.1rem);
            max-width: 600px;
            margin: 0 auto 30px;
        }

        .hero-button {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--brand);
            color: #FFFFFF;
            padding: 14px 28px;
            font-size: 1rem;
            font-weight: 600;
            border-radius: var(--radius-md);
            border: none;
            cursor: pointer;
            text-decoration: none;
            letter-spacing: 0.01em;
            transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.2s ease;
            box-shadow: 0 0 0 0 rgba(232,83,26,0.4);
        }

        .hero-button::after {
            content: '→';
            font-size: 1rem;
            transition: transform 0.2s ease;
        }

        .hero-button:hover {
            background: var(--brand-dark);
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(232,83,26,0.35);
            color: #FFFFFF;
            text-decoration: none;
        }

        .hero-button:hover::after {
            transform: translateX(4px);
        }

        /* ─────────────────────────────────────────
           FEATURES SECTION
        ───────────────────────────────────────── */
        .features-section {
            padding: 96px 0;
            background: var(--bg-white);
        }

        .section-title {
            text-align: center;
            font-size: clamp(1.6rem, 3vw, 2.1rem);
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.025em;
            margin-bottom: 12px;
        }

        .section-title::before {
            content: '';
            display: block;
            width: 36px;
            height: 3px;
            background: var(--brand);
            border-radius: 2px;
            margin: 0 auto 16px;
        }

        .features-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 24px;
            margin-top: 56px;
        }

        .feature-box {
            background: var(--bg-white);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 36px 28px;
            text-align: left;
            transition: border-color 0.2s ease, box-shadow 0.2s ease, transform 0.2s ease;
            position: relative;
            overflow: hidden;
        }

        .feature-box::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--brand), transparent);
            opacity: 0;
            transition: opacity 0.2s ease;
        }

        .feature-box:hover {
            border-color: var(--brand);
            box-shadow: var(--shadow-md);
            transform: translateY(-4px);
        }

        .feature-box:hover::before {
            opacity: 1;
        }

        .feature-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 52px;
            height: 52px;
            background: #FFF3EE;
            border-radius: var(--radius-sm);
            font-size: 1.5rem;
            color: var(--brand);
            margin-bottom: 20px;
        }

        .feature-title {
            font-size: 1.05rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 10px;
            letter-spacing: -0.01em;
        }

        .feature-description {
            font-size: 0.9rem;
            color: var(--text-secondary);
            line-height: 1.7;
        }

        /* ─────────────────────────────────────────
           CATEGORIES SECTION
        ───────────────────────────────────────── */
        .categories-section {
            padding: 96px 0;
            background: var(--bg-page);
        }

        .categories-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-top: 56px;
        }

        .category-card {
            background: var(--bg-white);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: box-shadow 0.25s ease, transform 0.25s ease, border-color 0.25s ease;
            display: flex;
            flex-direction: column;
        }

        .category-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg);
            border-color: var(--border-strong);
        }

        .category-image {
            width: 100%;
            height: 210px;
            object-fit: cover;
            display: block;
            background: var(--bg-subtle);
            transition: transform 0.5s ease;
        }

        .category-card:hover .category-image {
            transform: scale(1.06);
        }

        .category-overlay {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
            background: var(--bg-white);
        }

        .category-name {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-primary);
            letter-spacing: -0.01em;
            margin: 0 0 16px 0;
        }

        .category-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            background: var(--brand);
            color: #FFFFFF;
            padding: 10px 16px;
            border-radius: var(--radius-sm);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 600;
            transition: background 0.2s ease, transform 0.15s ease;
            margin-top: auto;
        }

        .category-button:hover {
            background: var(--brand-dark);
            color: #FFFFFF;
            text-decoration: none;
            transform: translateY(-1px);
        }

        /* ─────────────────────────────────────────
           PRODUCTS SECTION
        ───────────────────────────────────────── */
        .products-section {
            padding: 96px 0;
            background: var(--bg-white);
        }

        .products-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 24px;
            margin-top: 56px;
        }

        .product-card {
            background: var(--bg-white);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: box-shadow 0.25s ease, transform 0.25s ease, border-color 0.25s ease;
            display: flex;
            flex-direction: column;
        }

        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg);
            border-color: var(--border-strong);
        }

        .product-image-container {
            position: relative;
            height: 210px;
            overflow: hidden;
            background: var(--bg-subtle);
        }

        .product-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: transform 0.5s ease;
        }

        .product-card:hover .product-image {
            transform: scale(1.06);
        }

        .product-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .product-category {
            font-size: 0.72rem;
            font-weight: 600;
            color: var(--brand);
            text-transform: uppercase;
            letter-spacing: 0.07em;
            margin-bottom: 6px;
        }

        .product-name {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
            line-height: 1.4;
            letter-spacing: -0.01em;
        }

        .product-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 16px;
            letter-spacing: -0.02em;
        }

        .product-buttons {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 8px;
            margin-top: auto;
        }

        .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            padding: 10px 16px;
            border-radius: var(--radius-sm);
            text-decoration: none;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: background 0.2s ease, color 0.2s ease, transform 0.15s ease;
            white-space: nowrap;
        }

        .button:hover {
            text-decoration: none;
        }

        .button-primary {
            background: var(--brand);
            color: #FFFFFF;
        }

        .button-primary:hover {
            background: var(--brand-dark);
            color: #FFFFFF;
            transform: translateY(-1px);
        }

        .button-secondary {
            background: var(--bg-subtle);
            color: var(--text-secondary);
            border: 1px solid var(--border);
        }

        .button-secondary:hover {
            background: var(--border);
            color: var(--text-primary);
        }

        /* ─────────────────────────────────────────
           TESTIMONIALS SECTION
        ───────────────────────────────────────── */
        .testimonials-section {
            padding: 96px 0;
            background: #0F0A06;
            position: relative;
            overflow: hidden;
        }

        .testimonials-section::after {
            content: '';
            position: absolute;
            bottom: -10%;
            right: -5%;
            width: 600px;
            height: 400px;
            background: radial-gradient(ellipse, rgba(232,83,26,0.12) 0%, transparent 65%);
            pointer-events: none;
        }

        .testimonials-section .section-title {
            color: #FFFFFF;
        }

        .testimonials-section .section-title::before {
            margin: 0 auto 16px;
        }

        .testimonials-container {
            max-width: 700px;
            margin: 56px auto 0;
            position: relative;
            z-index: 2;
        }

        .testimonial {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: var(--radius-xl);
            padding: 48px 44px;
            text-align: center;
            backdrop-filter: blur(8px);
        }

        .testimonial-text {
            font-size: 1.1rem;
            font-style: italic;
            color: rgba(255,255,255,0.82);
            line-height: 1.8;
            margin-bottom: 28px;
            position: relative;
        }

        .testimonial-text::before {
            content: '\201C';
            font-size: 5rem;
            line-height: 0;
            vertical-align: -0.55em;
            color: var(--brand);
            opacity: 0.5;
            font-family: Georgia, serif;
            margin-right: 6px;
        }

        .testimonial-author {
            font-weight: 700;
            font-size: 1rem;
            color: #FFFFFF;
            margin-bottom: 4px;
        }

        .testimonial-role {
            font-size: 0.82rem;
            color: rgba(255,255,255,0.4);
            letter-spacing: 0.04em;
        }

        /* ─────────────────────────────────────────
           APP SECTION
        ───────────────────────────────────────── */
        .app-section {
            padding: 96px 0;
            background: var(--bg-page);
        }

        .app-container {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 60px;
            max-width: 960px;
            width: 100%;              /* ← ensure it never exceeds parent */
            margin: 0 auto;
            background: var(--bg-white);
            border: 1px solid var(--border);
            border-radius: var(--radius-xl);
            padding: 56px;
            box-shadow: var(--shadow-md);
            overflow: hidden;
        }

        .app-info {
            flex: 1;
            min-width: 0;         
            text-align: left;
            word-break: break-word;
            overflow-wrap: break-word;
        }


        .app-title {
            font-size: clamp(1.1rem, 4vw, 1.9rem);
            font-weight: 700;
            color: var(--text-primary);
            letter-spacing: -0.025em;
            margin-bottom: 14px;
            word-break: break-word;
        }

        .app-description {
            color: var(--text-secondary);
            font-size: clamp(0.8rem, 3vw, 0.95rem);
            line-height: 1.75;
            margin-bottom: 28px;
            word-break: break-word;
        }

        .app-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .app-button {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            background: var(--text-primary);
            color: #FFFFFF;
            padding: 12px 20px;
            border-radius: var(--radius-md);
            text-decoration: none;
            transition: background 0.2s ease, transform 0.15s ease;
            border: 1px solid transparent;
        }

        .app-button:hover {
            background: #1F2937;
            transform: translateY(-2px);
            color: #FFFFFF;
            text-decoration: none;
        }

        .app-button i {
            font-size: 1.75rem;
        }

        .app-button-text {
            display: flex;
            flex-direction: column;
            line-height: 1.2;
        }

        .app-button-small {
            font-size: 0.68rem;
            color: rgba(255,255,255,0.65);
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }

        .app-button-big {
            font-size: 1rem;
            font-weight: 600;
            color: #FFFFFF;
        }

        .app-image {
            flex-shrink: 0;
        }

        .app-image img {
            max-width: 220px;
            width: 100%;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            display: block;
        }

        /* ─────────────────────────────────────────
           CONTAINER UTILITY
        ───────────────────────────────────────── */
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px;
        }

        /* ─────────────────────────────────────────
           RESPONSIVE
        ───────────────────────────────────────── */
        /* ── Responsive ── */
        @media (max-width: 992px) {
            .app-container {
                flex-direction: column;
                padding: 32px 20px;
                gap: 32px;
                overflow: hidden;
                width: 100%;
            }

            .app-info {
                text-align: center;
                width: 100%;
                min-width: 0;
            }

            .app-buttons {
                justify-content: center;
                flex-direction: column;
                align-items: center;
            }

            .app-button {
                width: 100%;
                max-width: 240px;
                justify-content: center;
            }

            .app-image {
                width: 100%;
                display: flex;
                justify-content: center;
            }

            .app-image img {
                max-width: 160px;
                width: 100%;
            }
        }

        @media (max-width: 576px) {
            .app-container {
                padding: 24px 16px;   /* ← tighter on very small screens */
                border-radius: var(--radius-lg);
            }
        }


        @media (max-width: 768px) {
            .hero-section {
                min-height: 80vh;
                padding: 100px 16px;
            }

            .features-section,
            .categories-section,
            .products-section,
            .testimonials-section,
            .app-section {
                padding: 72px 0;
            }

            .testimonial {
                padding: 36px 28px;
            }

            .features-container,
            .products-container {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 576px) {
            .features-container,
            .products-container,
            .categories-container {
                grid-template-columns: 1fr;
            }

            .hero-button {
                padding: 12px 24px;
                font-size: 0.95rem;
            }

            .app-container {
                padding: 28px 16px;
            }

            .testimonial {
                padding: 28px 20px;
            }
        }

        @media (max-width: 480px) {
            .hero-section {
                min-height: 70vh;
                padding: 80px 12px;
            }

            .hero-button {
                width: 100%;
                max-width: 260px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <h1 class="hero-title">Everything your pet deserves, delivered fast.</h1>
            <p class="hero-subtitle">Premium food, toys, grooming &amp; accessories for dogs, cats and more. Shop trusted brands, delivered to your door.</p>
            <asp:Button ID="btnOrderNow" runat="server" CssClass="hero-button" Text="Order Now" />
        </div>
    </section>
    <div class="container" style="margin-top: 20px; margin-bottom: 20px;">
        <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false" ForeColor="Red"></asp:Label>
    </div>

    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <h2 class="section-title">Why Choose Us</h2>
            <div class="features-container">
                <div class="feature-box">
                    <i class="fas fa-truck feature-icon"></i>
                    <h3 class="feature-title">Fast Delivery</h3>
                    <p class="feature-description">Get your pet supplies delivered same-day or next-day, right to your doorstep.</p>
                </div>
                <div class="feature-box">
                    <i class="fas fa-paw feature-icon"></i>
                    <h3 class="feature-title">Premium Brands</h3>
                    <p class="feature-description">We stock only vet-approved, trusted brands your pets will love.</p>
                </div>
                <div class="feature-box">
                    <i class="fas fa-mobile-alt feature-icon"></i>
                    <h3 class="feature-title">Easy To Order</h3>
                    <p class="feature-description">Browse, pick, checkout — done in minutes. Reorder your favorites with one tap.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Categories Section -->
    <section class="categories-section">
        <div class="container">
            <h2 class="section-title">Explore Categories</h2>
            <asp:Label ID="lblCategoryError" runat="server" CssClass="error-message" Visible="false" ForeColor="Red"></asp:Label>
            <div class="categories-container">
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <div class="category-card">
                            <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("Name") %>' class="category-image" />
                            <div class="category-overlay">
                                <h3 class="category-name"><%# Eval("Name") %></h3>
                                <a href='ProductListing.aspx?category=<%# Eval("CategoryID") %>' class="category-button">View All</a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- Featured Products Section -->
    <section class="products-section">
        <div class="container">
            <h2 class="section-title">Featured Products</h2>
            <asp:Label ID="lblProductError" runat="server" CssClass="error-message" Visible="false" ForeColor="Red"></asp:Label>
            <div class="products-container">
                <asp:Repeater ID="rptFeaturedProducts" runat="server" OnItemCommand="rptFeaturedProducts_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <div class="product-image-container">
                                <img src='<%#ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Name") %>' class="product-image" />
                            </div>
                            <div class="product-info">
                                <div class="product-category"><%# Eval("Name") %></div>
                                <h3 class="product-name"><%# Eval("Name") %></h3>
                                <div class="product-price">$<%# Eval("Price", "{0:0.00}") %></div>
                                <div class="product-buttons">
                                    <asp:LinkButton ID="btnAddToCart" runat="server" CssClass="button button-primary"
                                        CommandName="AddToCart" CommandArgument='<%# Eval("ProductID") %>'>
                                        <i class="fas fa-shopping-cart"></i> Add to Cart
                                    </asp:LinkButton>
                                    <a href='ProductDetails.aspx?id=<%# Eval("ProductID") %>' class="button button-secondary">
                                        <i class="fas fa-info-circle"></i> Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials-section">
        <div class="container">
            <h2 class="section-title">What Our Customers Say</h2>
            <div class="testimonials-container">
                <div class="testimonial">
                    <p class="testimonial-text">"PawMart is my go-to for everything my dog needs. Incredible quality, lightning-fast delivery — my pup has never been happier!"</p>
                    <div class="testimonial-author">John Smith</div>
                    <div class="testimonial-role">Regular Customer</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Download App Section -->
    <section class="app-section">
        <div class="container">
            <div class="app-container">
                <div class="app-info">
                    <h2 class="app-title">Download Our Mobile App</h2>
                    <p class="app-description">Get the full PawMart experience on your mobile device. Order pet products, track your delivery in real-time, and receive exclusive app-only offers.</p>
                    <div class="app-buttons">
                        <a href="#" class="app-button">
                            <i class="fab fa-google-play"></i>
                            <div class="app-button-text">
                                <span class="app-button-small">GET IT ON</span>
                                <span class="app-button-big">Google Play</span>
                            </div>
                        </a>
                        <a href="#" class="app-button">
                            <i class="fab fa-apple"></i>
                            <div class="app-button-text">
                                <span class="app-button-small">DOWNLOAD ON</span>
                                <span class="app-button-big">App Store</span>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="app-image">
                    <img src="/Images/mobile.png" alt="PawMart Mobile App" />
                </div>
            </div>
        </div>
    </section>
</asp:Content>