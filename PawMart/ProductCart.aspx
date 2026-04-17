<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="ProductCart.aspx.cs" Inherits="PawMart.ProductCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --text-color: #2d334a;
        }

        .cart-container {
            max-width: 800px;
            margin: 40px auto;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 30px;
        }

        .cart-item {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e0e0e0;
        }

        .cart-item-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }

        .cart-item-details {
            flex-grow: 1;
        }

        .cart-item-quantity {
            display: flex;
            align-items: center;
            margin-top: 10px;
        }

        .quantity-btn {
           
            background-color: var(--primary-color);
            color: white;
            border: none;
            width: 40px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
            text-align: center;
            -webkit-text-decoration: none;
            text-decoration: none;
        }

        .btn-outline {
                    text-align: center;
text-decoration: none;
              display: inline-block;
    width: auto;
    padding: 10px 20px;
           
           
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1em;
            cursor: pointer;
            margin-top: 20px;
        }

        .cart-total {
            text-align: right;
            margin-top: 20px;
            font-size: 1.2em;
            font-weight: bold;
            color: var(--text-color);
        }

        .checkout-btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            cursor: pointer;
            margin-top: 20px;
        }

        .empty-cart {
            text-align: center;
            padding: 50px;
            color: #888;
        }
  .btn {
    display: inline-block;
    padding: 10px 20px;
    border-radius: 8px;
    text-decoration: none;
    cursor: pointer;
    font-size: 1em;
    transition: 0.3s ease;
    border: none;
}

/* Primary button */
.btn-primary {
    background-color: var(--primary-color);
    color: white;
}

.btn-primary:hover {
    background-color: #e45c5c;
}

/* Outline button */
.btn-primary-outline {
    background-color: transparent;
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
}

.btn-primary-outline:hover {
    background-color: var(--primary-color);
    color: white;
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cart-container">
        <h1 class="section-title">Your Shopping Cart</h1>

        <asp:Panel ID="pnlEmptyCart" runat="server" CssClass="empty-cart" Visible="false">
            <i class="fas fa-shopping-cart fa-3x" style="color: #ccc; margin-bottom: 20px;"></i>
            <h2>Your cart is empty</h2>
            <p>Looks like you haven't added any items to your cart yet.</p>
            <asp:LinkButton ID="btnContinueShopping" runat="server"
                CssClass="btn btn-primary" OnClick="btnContinueShopping_Click">
                Continue Shopping
            </asp:LinkButton>
        </asp:Panel>

        <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
            <HeaderTemplate>
                <div class="cart-items">
            </HeaderTemplate>
            <ItemTemplate>
                <div class="cart-item">
                    <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>'
                        alt='<%# Eval("Name") %>'
                        class="cart-item-image"
                        onerror="this.src='/Images/placeholder-food.jpg';" />

                    <div class="cart-item-details">
                        <h3><%# Eval("Name") %></h3>
                        <p>Price: $<%# Eval("Price", "{0:0.00}") %></p>

                        <div class="cart-item-quantity">
                            <asp:LinkButton ID="btnDecreaseQty" runat="server"
                                CssClass="quantity-btn"
                                CommandName="DecreaseQuantity"
                                CommandArgument='<%# Eval("CartItemID") %>'>-</asp:LinkButton>

                            <span style="margin: 0 15px;">
                                <%# Eval("Quantity") %>
                            </span>

                            <asp:LinkButton ID="btnIncreaseQty" runat="server"
                                CssClass="quantity-btn"
                                CommandName="IncreaseQuantity"
                                CommandArgument='<%# Eval("CartItemID") %>'>  +</asp:LinkButton>
                        </div>

                        <p>Total: $<%# Eval("TotalPrice", "{0:0.00}") %></p>

                        <asp:LinkButton ID="btnRemoveItem" runat="server"
                            CssClass="btn btn-outline"
                            CommandName="RemoveItem"
                            CommandArgument='<%# Eval("CartItemID") %>'>
                            Remove
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                </div>
                <div class="cart-total">
                    Total: $<asp:Literal ID="litCartTotal" runat="server"></asp:Literal>
                </div>
                <asp:Button ID="btnCheckout" runat="server"
                    Text="Proceed to Checkout"
                    CssClass="checkout-btn"
                    OnClick="btnCheckout_Click" />
            </FooterTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
