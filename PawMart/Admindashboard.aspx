<%@ Page Title="" Language="C#" MasterPageFile="~/PawMart.Master" AutoEventWireup="true" CodeBehind="Admindashboard.aspx.cs" Inherits="PawMart.Admindashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <style>
        /* Main Layout */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 250px;
            background-color: #343a40;
            color: #fff;
            transition: all 0.3s;
            height: 100%;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            background-color: #212529;
            text-align: center;
        }
            
        .sidebar-header h3 {
            margin: 0;
            font-size: 1.5rem;
        }

        .sidebar-menu {
            padding: 0;
            list-style: none;
            margin: 0;
        }

        .sidebar-menu li {
            position: relative;
            margin: 0;
            padding: 0;
        }

        .sidebar-menu li a {
            padding: 15px 20px;
            display: block;
            color: #fff;
            text-decoration: none;
            font-size: 16px;
            border-left: 3px solid transparent;
            transition: all 0.3s;
        }

        .sidebar-menu li a:hover {
            background-color: #4b545c;
            border-left-color: #007bff;
        }

        .sidebar-menu li a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .sidebar-menu li.active a {
            background-color: #4b545c;
            border-left-color: #007bff;
        }

        /* Submenu Styles */
        .sidebar-menu .submenu {
            list-style: none;
            padding-left: 0;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
            background-color: #2c3136;
        }

        .sidebar-menu .submenu.open {
            max-height: 500px;
        }

        .sidebar-menu .submenu li a {
            padding: 10px 10px 10px 50px;
            font-size: 14px;
        }

        .has-submenu::after {
            content: "\25BC";
            font-size: 12px;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            transition: transform 0.3s;
        }

        .has-submenu.active::after {
            transform: translateY(-50%) rotate(180deg);
        }

        /* Content Area */
        .content {
            margin-left: 250px;
            padding: 20px;
            width: calc(100% - 250px);
            transition: all 0.3s;
        }

        /* Top Navigation */
        .content-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 1px solid #dee2e6;
            margin-bottom: 20px;
        }

        .toggle-sidebar {
            display: none;
            background: none;
            border: none;
            font-size: 24px;
            color: #343a40;
            cursor: pointer;
        }

        /* Mobile Styles */
        @media (max-width: 992px) {
            .sidebar {
                margin-left: -250px;
            }

            .sidebar.active {
                margin-left: 0;
            }

            .content {
                width: 100%;
                margin-left: 0;
            }

            .toggle-sidebar {
                display: block;
            }
            
            .content.sidebar-active {
                margin-left: 250px;
            }
            
            /* Add overlay when sidebar is active on mobile */
            .sidebar-overlay {
                display: none;
                position: fixed;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.4);
                z-index: 999;
                opacity: 0;
                transition: all 0.5s ease;
            }
            
            .sidebar-overlay.active {
                display: block;
                opacity: 1;
            }
        }

        /* Existing Styles from AddUser.aspx (keeping what's relevant) */
        .header-buttons {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .header-buttons .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .header-buttons .btn-back {
            background-color: #6c757d;
            color: #fff;
        }

        .header-buttons .btn-back:hover {
            background-color: #5a6268;
        }

        .header-buttons .btn-add-user {
            background-color: #007bff;
            color: #fff;
        }

        .header-buttons .btn-add-user:hover {
            background-color: #0056b3;
        }

        /* Dashboard Cards */
        .dashboard-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            flex: 1 1 250px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .card-icon {
            margin-bottom: 15px;
            font-size: 28px;
            color: #007bff;
        }

        .card-title {
            font-size: 18px;
            color: #555;
            margin-bottom: 5px;
        }

        .card-value {
            font-size: 28px;
            font-weight: bold;
            color: #333;
        }

        /* You can keep other styles from your original file */
        /* This includes those for modals, forms, tables, etc. */
    </style>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <div class="sidebar-overlay"></div>

    <!-- Admin Dashboard Container -->
    <div class="admin-container">
        <!-- Sidebar -->
        <nav id="sidebar" class="sidebar">
            <div class="sidebar-header">
                <h3>PawMart Admin</h3>
            </div>

            <ul class="sidebar-menu">
                <li class="active">
                    <a href="AdminDashboard.aspx">
                        <i class="fas fa-tachometer-alt"></i>
                        Dashboard
                    </a>
                </li>
                <li class="has-submenu">
                    <a href="#">
                        <i class="fas fa-users"></i>
                        Customer Management
                    </a>
                    <ul class="submenu">
                        <li><a href="AddUser.aspx">Manage Customers</a></li>
                        <li><a href="CustomerReports.aspx">Customer Reports</a></li>
                    </ul>
                </li>
                <li class="has-submenu">
                    <a href="#">
                        <i class="fas fa-store"></i>
                        Vendor Management
                    </a>
                    <ul class="submenu">
                        <li><a href="ManageVendors.aspx">Manage Vendors</a></li>
                        <li><a href="VendorApplications.aspx">Vendor Applications</a></li>
                        <li><a href="VendorReports.aspx">Vendor Reports</a></li>
                    </ul>
                </li>
                <li class="has-submenu">
                    <a href="#">
                        <i class="fas fa-shopping-cart"></i>
                        Order Management
                    </a>
                    <ul class="submenu">
                        <li><a href="AllOrders.aspx">All Orders</a></li>
                        <li><a href="PendingOrders.aspx">Pending Orders</a></li>
                        <li><a href="CompletedOrders.aspx">Completed Orders</a></li>
                        <li><a href="CancelledOrders.aspx">Cancelled Orders</a></li>
                    </ul>
                </li>
                <li class="has-submenu">
                    <a href="#">
                        <i class="fas fa-utensils"></i>
                        Menu Management
                    </a>
                    <ul class="submenu">
                        <li><a href="ManageCategories.aspx">Categories</a></li>
                        <li><a href="ManageItems.aspx">Food Items</a></li>
                        <li><a href="FeaturedItems.aspx">Featured Items</a></li>
                    </ul>
                </li>
                <li class="has-submenu">
                    <a href="#">
                        <i class="fas fa-chart-line"></i>
                        Reports
                    </a>
                    <ul class="submenu">
                        <li><a href="SalesReports.aspx">Sales Reports</a></li>
                        <li><a href="RevenueReports.aspx">Revenue Reports</a></li>
                        <li><a href="CustomerAnalytics.aspx">Customer Analytics</a></li>
                    </ul>
                </li>
                <li>
                    <a href="Settings.aspx">
                        <i class="fas fa-cog"></i>
                        Settings
                    </a>
                </li>
                <li>
                    <a href="Logout.aspx">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </a>
                </li>
            </ul>
        </nav>

        <!-- Page Content -->
        <div class="content">
            <div class="content-header">
                <button type="button" id="sidebarCollapse" class="toggle-sidebar">
                    <i class="fas fa-bars"></i>
                </button>
                <h1>Admin Dashboard</h1>
            </div>

            <!-- This will be replaced with your specific content -->
            <div id="dashboardContent">
                <!-- Dashboard Cards -->
                <div class="dashboard-cards">
                    <div class="card">
                        <div class="card-icon"><i class="fas fa-users"></i></div>
                        <div class="card-title">Total Customers</div>
                        <div class="card-value">1,245</div>
                    </div>
                    <div class="card">
                        <div class="card-icon"><i class="fas fa-store"></i></div>
                        <div class="card-title">Active Vendors</div>
                        <div class="card-value">28</div>
                    </div>
                    <div class="card">
                        <div class="card-icon"><i class="fas fa-shopping-cart"></i></div>
                        <div class="card-title">Today's Orders</div>
                        <div class="card-value">87</div>
                    </div>
                    <div class="card">
                        <div class="card-icon"><i class="fas fa-dollar-sign"></i></div>
                        <div class="card-title">Revenue (Today)</div>
                        <div class="card-value">$3,854</div>
                    </div>
                </div>
                
                <!-- Your other content will go here -->
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Toggle submenu
            const submenuToggles = document.querySelectorAll('.has-submenu');
            submenuToggles.forEach(function(toggle) {
                toggle.addEventListener('click', function(e) {
                    if (e.target.tagName === 'A') {
                        
                        this.classList.toggle('active');
                        const submenu = this.querySelector('.submenu');
                        submenu.classList.toggle('open');
                    }
                });
            });

            // Toggle sidebar on mobile
            const sidebarCollapse = document.getElementById('sidebarCollapse');
            const sidebar = document.getElementById('sidebar');
            const content = document.querySelector('.content');
            const overlay = document.querySelector('.sidebar-overlay');

            sidebarCollapse.addEventListener('click', function() {
                sidebar.classList.toggle('active');
                content.classList.toggle('sidebar-active');
                overlay.classList.toggle('active');
            });

            // Close sidebar when clicking on overlay
            overlay.addEventListener('click', function() {
                sidebar.classList.remove('active');
                content.classList.remove('sidebar-active');
                overlay.classList.remove('active');
            });

            // Add active class to current menu item
            const currentPage = window.location.pathname.split('/').pop();
            const menuLinks = document.querySelectorAll('.sidebar-menu a');
            
            menuLinks.forEach(function(link) {
                const href = link.getAttribute('href');
                if (href === currentPage) {
                    link.parentElement.classList.add('active');
                    
                    // If it's in a submenu, open the parent submenu
                    const parentLi = link.closest('.submenu')?.closest('li');
                    if (parentLi) {
                        parentLi.classList.add('active');
                        parentLi.querySelector('.submenu').classList.add('open');
                    }
                }
            });
        });
    </script>
</asp:Content>
