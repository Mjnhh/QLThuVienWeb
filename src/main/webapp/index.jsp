<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hệ thống Quản lý Thư viện</title>
    <%@ include file="admin/layout/header.jsp" %>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .hero-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 100px 0;
            position: relative;
            overflow: hidden;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            animation: float 20s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(1deg); }
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .feature-card {
            transition: all 0.4s ease;
            border: none;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            border-radius: 20px;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        
        .feature-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        
        .feature-card .card-body {
            padding: 2rem;
        }
        
        .feature-card i {
            font-size: 3rem;
            margin-bottom: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .nav-pills .nav-link {
            border-radius: 25px;
            margin: 0 5px;
            padding: 12px 25px;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .nav-pills .nav-link.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .nav-pills .nav-link:hover:not(.active) {
            background: rgba(102, 126, 234, 0.1);
            transform: translateY(-2px);
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }
        
        .navbar-brand {
            font-weight: 700;
            color: #667eea !important;
        }
        
        .navbar-nav .nav-link {
            color: #495057 !important;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover {
            color: #667eea !important;
            transform: translateY(-2px);
        }
        
        .btn-hero {
            background: rgba(255, 255, 255, 0.2);
            border: 2px solid white;
            color: white;
            padding: 15px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        
        .btn-hero:hover {
            background: white;
            color: #667eea;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }
        
        .section-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .section-card .card-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0 !important;
            padding: 1.5rem;
        }
        
        .section-card .card-body {
            padding: 2rem;
        }
        
        footer {
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(20px);
            color: white;
            padding: 2rem 0;
            margin-top: 4rem;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-book"></i> Thư viện Online
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="trang-chu">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="docgia">Quản lý Độc giả</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="sach">Quản lý Sách</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="phieumuon">Mượn/Trả</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container text-center hero-content">
            <h1 class="display-3 fw-bold mb-4">
                <i class="bi bi-book-half"></i> Hệ thống Quản lý Thư viện
            </h1>
            <p class="lead mb-5 fs-4">
                Quản lý độc giả, sách và hoạt động mượn trả một cách hiệu quả và hiện đại
            </p>
            <a href="login" class="btn btn-hero btn-lg me-3">
                <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
            </a>
            <a href="trang-chu" class="btn btn-hero btn-lg">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container my-5">
        <!-- Navigation Tabs -->
        <ul class="nav nav-pills justify-content-center mb-5" id="mainTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="overview-tab" data-bs-toggle="pill" data-bs-target="#overview" type="button" role="tab">
                    <i class="bi bi-house-door"></i> Tổng quan
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="docgia-tab" data-bs-toggle="pill" data-bs-target="#docgia" type="button" role="tab">
                    <i class="bi bi-people"></i> Quản lý Độc giả
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="sach-tab" data-bs-toggle="pill" data-bs-target="#sach" type="button" role="tab">
                    <i class="bi bi-book"></i> Quản lý Sách
                </button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="muontra-tab" data-bs-toggle="pill" data-bs-target="#muontra" type="button" role="tab">
                    <i class="bi bi-arrow-left-right"></i> Mượn/Trả
                </button>
            </li>
        </ul>

        <!-- Tab Content -->
        <div class="tab-content" id="mainTabsContent">
            <!-- Overview Tab -->
            <div class="tab-pane fade show active" id="overview" role="tabpanel">
                <div class="row g-4">
                    <div class="col-md-3">
                        <div class="card feature-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-people fs-1 text-primary mb-3"></i>
                                <h5 class="card-title">Quản lý Độc giả</h5>
                                <p class="card-text">Thêm, sửa, xóa và tìm kiếm thông tin độc giả</p>
                                <a href="docgia" class="btn btn-primary">Quản lý</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card feature-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-book fs-1 text-success mb-3"></i>
                                <h5 class="card-title">Quản lý Sách</h5>
                                <p class="card-text">Quản lý thông tin sách và ảnh bìa</p>
                                <a href="sach" class="btn btn-success">Quản lý</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card feature-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-arrow-left-right fs-1 text-warning mb-3"></i>
                                <h5 class="card-title">Mượn/Trả</h5>
                                <p class="card-text">Quản lý phiếu mượn và trả sách</p>
                                <a href="phieumuon" class="btn btn-warning">Quản lý</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card feature-card text-center h-100">
                            <div class="card-body">
                                <i class="bi bi-graph-up fs-1 text-info mb-3"></i>
                                <h5 class="card-title">Thống kê</h5>
                                <p class="card-text">Xem báo cáo và thống kê hệ thống</p>
                                <a href="trang-chu" class="btn btn-info">Xem thống kê</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- DocGia Tab -->
            <div class="tab-pane fade" id="docgia" role="tabpanel">
                <div class="section-card">
                    <div class="card-header">
                        <h5><i class="bi bi-people"></i> Quản lý Độc giả</h5>
                    </div>
                    <div class="card-body">
                        <p class="fs-5 mb-4">Quản lý thông tin độc giả bao gồm:</p>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Thêm độc giả mới</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Sửa thông tin độc giả</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Xóa độc giả</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Tìm kiếm theo họ tên, SĐT, Email</li>
                        </ul>
                        <a href="docgia" class="btn btn-primary btn-lg">
                            <i class="bi bi-arrow-right"></i> Vào quản lý độc giả
                        </a>
                    </div>
                </div>
            </div>

            <!-- Sach Tab -->
            <div class="tab-pane fade" id="sach" role="tabpanel">
                <div class="section-card">
                    <div class="card-header">
                        <h5><i class="bi bi-book"></i> Quản lý Sách</h5>
                    </div>
                    <div class="card-body">
                        <p class="fs-5 mb-4">Quản lý thông tin sách bao gồm:</p>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Thêm sách mới với ảnh bìa</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Sửa thông tin sách</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Xóa sách</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Tìm kiếm theo tên, tác giả, năm xuất bản</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Hiển thị ảnh bìa thumbnail</li>
                        </ul>
                        <a href="sach" class="btn btn-success btn-lg">
                            <i class="bi bi-arrow-right"></i> Vào quản lý sách
                        </a>
                    </div>
                </div>
            </div>

            <!-- MuonTra Tab -->
            <div class="tab-pane fade" id="muontra" role="tabpanel">
                <div class="section-card">
                    <div class="card-header">
                        <h5><i class="bi bi-arrow-left-right"></i> Quản lý Mượn/Trả</h5>
                    </div>
                    <div class="card-body">
                        <p class="fs-5 mb-4">Quản lý hoạt động mượn trả bao gồm:</p>
                        <ul class="list-unstyled">
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Tạo phiếu mượn (chọn độc giả + nhiều sách)</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Xem chi tiết phiếu mượn</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Trả sách và cập nhật trạng thái</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Kiểm tra hạn trả tự động</li>
                            <li class="mb-2"><i class="bi bi-check-circle text-success me-2"></i>Quản lý trạng thái: Đang mượn, Đã trả, Quá hạn</li>
                        </ul>
                        <a href="phieumuon" class="btn btn-warning btn-lg">
                            <i class="bi bi-arrow-right"></i> Vào quản lý mượn/trả
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="container text-center">
            <div class="row">
                <div class="col-md-6">
                    <h5><i class="bi bi-book"></i> Hệ thống Quản lý Thư viện</h5>
                    <p class="mb-0">Được phát triển với Java Servlet + JSP + Bootstrap</p>
                </div>
                <div class="col-md-6">
                    <h6>Liên hệ</h6>
                    <p class="mb-0">
                        <i class="bi bi-envelope me-2"></i>admin@thuvien.com<br>
                        <i class="bi bi-telephone me-2"></i>0123 456 789
                    </p>
                </div>
            </div>
            <hr class="my-3" style="border-color: rgba(255,255,255,0.2);">
            <p class="mb-0">&copy; 2025 Hệ thống Quản lý Thư viện. Tất cả quyền được bảo lưu.</p>
        </div>
    </footer>

    <%@ include file="admin/layout/footer.jsp" %>

    <script>
        // Auto redirect to dashboard after 3 seconds on overview tab
        document.addEventListener('DOMContentLoaded', function() {
            const overviewTab = document.getElementById('overview-tab');
            overviewTab.addEventListener('shown.bs.tab', function() {
                setTimeout(function() {
                    if (confirm('Bạn có muốn chuyển đến Dashboard để xem thống kê?')) {
                        window.location.href = 'trang-chu';
                    }
                }, 2000);
            });
        });
    </script>

</body>
</html>
