<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="PawMart.Checkout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
        :root {
            --primary-color: #ff6b6b;
            --secondary-color: #4ecdc4;
            --text-color: #2d334a;
            --background-color: #f4f4f4;
        }

        .checkout-container {
            max-width: 1200px;
            margin: 40px auto;
            display: flex;
            gap: 30px;
            padding: 0 15px;
        }

        .checkout-details, .order-summary {
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 30px;
        }

        .checkout-details {
            flex: 2;
        }

        .order-summary {
            flex: 1;
            height: fit-content;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-color);
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        .summary-total {
            font-weight: bold;
            font-size: 1.2em;
        }

        .checkout-btn {
            width: 100%;
            padding: 15px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .checkout-btn:hover {
            background-color: #ff5252;
        }

        .payment-methods {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }

        .payment-method {
            flex: 1;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .payment-method.selected {
            border-color: var(--primary-color);
            background-color: #fff5f5;
        }

        @media (max-width: 768px) {
            .checkout-container {
                flex-direction: column;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-container">
        <div class="checkout-details">
            <h2>Delivery Information</h2>
            
            <div class="form-group">
                <label for="txtFullName">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" required="required"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtEmail">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter your email" required="required"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtPhone">Phone Number</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TextMode="Phone" placeholder="Enter your phone number" required="required"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtAddress">Delivery Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Enter your full delivery address" required="required"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Payment Method</label>
                <div class="payment-methods">
                    <div class="payment-method" onclick="selectPaymentMethod('Cash')">
                        <i class="fas fa-money-bill-wave"></i>
                        <p>Cash on Delivery</p>
                    </div>
                    <div class="payment-method" onclick="selectPaymentMethod('Credit')">
                        <i class="fas fa-credit-card"></i>
                        <p>Credit/Debit Card</p>
                    </div>
                    <div class="payment-method" onclick="selectPaymentMethod('Online')">
                        <i class="fas fa-mobile-alt"></i>
                        <p>Online Payment</p>
                    </div>
                </div>
                <asp:HiddenField ID="hdnPaymentMethod" runat="server" />
            </div>

            <div class="form-group">
                <label for="txtNotes">Additional Notes (Optional)</label>
                <asp:TextBox ID="txtNotes" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Any special instructions?"></asp:TextBox>
            </div>
        </div>

        <div class="order-summary">
            <h2>Order Summary</h2>
            
            <asp:Repeater ID="rptOrderItems" runat="server">
                <ItemTemplate>
                    <div class="summary-item">
                        <span><%# Eval("Name") %> x <%# Eval("Quantity") %></span>
                        <span>$<%# Eval("TotalPrice", "{0:0.00}") %></span>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <div class="summary-item summary-total">
                <span>Total</span>
                <asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
            </div>

            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="checkout-btn" OnClick="btnPlaceOrder_Click" />
        </div>
    </div>

    <script>
        function selectPaymentMethod(method) {
            // Remove 'selected' class from all payment methods
            var methods = document.querySelectorAll('.payment-method');
            methods.forEach(function(el) {
                el.classList.remove('selected');
            });

            // Add 'selected' class to clicked method
            event.currentTarget.classList.add('selected');

            // Set hidden field value
            document.getElementById('<%= hdnPaymentMethod.ClientID %>').value = method;
        }
    </script>
</asp:Content>
