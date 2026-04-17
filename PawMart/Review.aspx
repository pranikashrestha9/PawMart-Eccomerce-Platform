<%@ Page Title="Product Review" Language="C#" MasterPageFile="~/PawMart.Master"
AutoEventWireup="true" CodeBehind="Review.aspx.cs" Inherits="PawMart.Review" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
.review-box {
    max-width: 600px;
    margin: 30px auto;
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    border: 1px solid #e8e8e8;
}

.star-rating {
    direction: rtl;
    font-size: 30px;
    display: flex;
    justify-content: flex-end;
    gap: 5px;
}

.star-rating input {
    display: none;
}

.star-rating label {
    cursor: pointer;
    color: #ccc;
    transition: 0.2s;
}
.star-rating input:checked + label {
    color: gold;
}

.star-rating input:checked ~ label,
.star-rating label:hover,
.star-rating label:hover ~ label {
    color: gold;
}

textarea {
    width: 100%;
    min-height: 120px;
    padding: 10px;
    border-radius: 8px;
    border: 1px solid #ddd;
    margin-top: 15px;
}

.btn-submit {
    margin-top: 15px;
    padding: 10px 18px;
    background: #1a56db;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
}
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="review-box">
    
    <h3>Give Your Review</h3>

    <!-- Hidden IDs -->
    <asp:HiddenField ID="hfProductID" runat="server" />
    <asp:HiddenField ID="hfOrderID" runat="server" />

    <!-- STAR RATING -->
    <div class="star-rating">
        <asp:RadioButton ID="star5" runat="server" GroupName="rating"
    ClientIDMode="Static" />
<label for="star5">★</label>

<asp:RadioButton ID="star4" runat="server" GroupName="rating"
    ClientIDMode="Static" />
<label for="star4">★</label>

<asp:RadioButton ID="star3" runat="server" GroupName="rating"
    ClientIDMode="Static" />
<label for="star3">★</label>

<asp:RadioButton ID="star2" runat="server" GroupName="rating"
    ClientIDMode="Static" />
<label for="star2">★</label>

<asp:RadioButton ID="star1" runat="server" GroupName="rating"
    ClientIDMode="Static" />
<label for="star1">★</label>
    </div>

    <!-- REVIEW TEXT -->
    <asp:TextBox ID="txtReview" runat="server" TextMode="MultiLine"
        placeholder="Write your review here..."></asp:TextBox>

    <!-- SUBMIT -->
    <asp:Button ID="btnSubmit" runat="server"
        Text="Submit Review"
        CssClass="btn-submit"
        OnClick="btnSubmit_Click" />

    <br /><br />
    <asp:Label ID="lblMessage" runat="server" ForeColor="Green" />

</div>

</asp:Content>