<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Admindash.aspx.cs" Inherits="PawMart.Admindash" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="content-header">
        <h2>Dashboard</h2>
    </div>

    <div class="dashboard-cards">
        <div class="card">
            <i class="fas fa-users card-icon"></i>
            <div class="card-title">Total Customers</div>
            <div class="card-value">5</div>
        </div>
        <div class="card">
            <i class="fas fa-store card-icon"></i>
            <div class="card-title">Total Product Items</div>
            <div class="card-value">8</div>
        </div>
        <div class="card">
            <i class="fas fa-shopping-cart card-icon"></i>
            <div class="card-title">Total Orders</div>
            <div class="card-value">20</div>
        </div>
    </div>
</asp:Content>
