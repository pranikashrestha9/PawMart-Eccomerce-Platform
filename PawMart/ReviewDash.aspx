<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ReviewDash.aspx.cs" Inherits="PawMart.ReviewDash" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
    }

    .container {
        padding: 20px;
    }

    h3, h5 {
        color: #333;
    }

    /* CLEAN TABLE */
    .table-modern {
        width: 100%;
        border-collapse: collapse;
        background: transparent;
    }

    .table-modern th {
        text-align: left;
        font-size: 13px;
        color: #777;
        padding: 12px 8px;
        border: none;
        background: transparent;
    }

    .table-modern td {
        padding: 14px 8px;
        border: none; /* ❌ removes all lines */
        font-size: 14px;
        color: #444;
        vertical-align: middle;
    }

    /* SOFT ROW DESIGN */
    .table-modern tbody tr {
        background: #fff;
        transition: 0.2s;
    }

    .table-modern tbody tr:hover {
        background: #f9fafb;
        transform: translateY(-1px);
    }

    /* PRODUCT */
    .product-cell {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .product-img {
        width: 42px;
        height: 42px;
        border-radius: 8px;
        object-fit: cover;
    }

    /* REVIEW TEXT */
    .review-text {
        max-width: 350px;
        font-size: 13px;
        color: #666;
        line-height: 1.4;
    }

    /* REMOVE GRIDVIEW DEFAULT BORDER SPACE */
    table {
        border: none !important;
    }

</style>

<div class="container mt-4">

    <h3 class="mb-3">📊 Product Review Dashboard</h3>

    <!-- SUMMARY TABLE -->
    <div class="card shadow-sm p-3 mb-4">
        <h5 class="mb-3">Product Summary</h5>
<asp:GridView ID="gvReviews" runat="server"
    AutoGenerateColumns="False"
    CssClass="table-modern"
    GridLines="None"
    EmptyDataText="No products found">

            <Columns>

           <asp:TemplateField HeaderText="Product">
    <ItemTemplate>
        <div class="product-cell">
            <img class="product-img" src='<%# Eval("ProductImage") %>' />
            <strong><%# Eval("ProductName") %></strong>
        </div>
    </ItemTemplate>
</asp:TemplateField>

                <asp:BoundField DataField="AverageRating" HeaderText="⭐ Avg Rating" />
                <asp:BoundField DataField="ReviewCount" HeaderText="📝 Reviews" />
                <asp:BoundField DataField="OrderCount" HeaderText="🛒 Orders" />

            </Columns>

        </asp:GridView>
    </div>

    <!-- REVIEWS TABLE -->
    <div class="card shadow-sm p-3">

        <h5 class="mb-3">🗣 Latest Reviews</h5>

       <asp:GridView ID="gvLatestReviews" runat="server"
    AutoGenerateColumns="False"
    CssClass="table-modern"
           GridLines="None"
    EmptyDataText="No reviews found">

            <Columns>

                <asp:TemplateField HeaderText="Product">
                    <ItemTemplate>
                        <%# Eval("ProductName") %>
                    </ItemTemplate>
                </asp:TemplateField>

         <asp:BoundField DataField="Rating" HeaderText="⭐ Rating" />

               <asp:TemplateField HeaderText="Review">
    <ItemTemplate>
        <div class="review-text">
            <%# Eval("ReviewText") %>
        </div>
    </ItemTemplate>
</asp:TemplateField>

                <asp:BoundField DataField="CreatedAt" HeaderText="Date" />

            </Columns>

        </asp:GridView>

    </div>

</div>

</asp:Content>

