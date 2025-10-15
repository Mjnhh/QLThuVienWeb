<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard Người dùng - Thư viện</title>
    <%@ include file="admin/layout/header.jsp" %>
    <style>
        .user-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .feature-card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }
        .info-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <!-- User Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="trang-chu">
                <i class="bi bi-book"></i> Thư viện
            </a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text text-light me-3">
                    <i class="bi bi-person-circle me-1"></i> 
                    Xin chào, <strong>${sessionScope.hoTen}</strong> 
                    <span class="badge bg-secondary ms-1">${sessionScope.vaiTro}</span>
                </span>
                <a href="login?action=logout" class="btn btn-outline-light btn-sm">
                    <i class="bi bi-box-arrow-right me-1"></i> Đăng xuất
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">

                    <!-- User Info Card -->
                    <div class="user-card">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h2><i class="bi bi-person-circle"></i> Xin chào, ${sessionScope.hoTen}!</h2>
                                <p class="mb-0 fs-5">Vai trò: <span class="badge bg-light text-dark">${sessionScope.vaiTro}</span></p>
                                <p class="mb-0">Chào mừng bạn đến với hệ thống thư viện</p>
                            </div>
                            <div class="col-md-4 text-end">
                                <i class="bi bi-book" style="font-size: 4rem; opacity: 0.3;"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Features for Regular Users -->
                    <div class="row justify-content-center">
                        <div class="col-md-5 mb-4">
                            <div class="card feature-card text-center h-100">
                                <div class="card-body">
                                    <i class="bi bi-book fs-1 text-primary mb-3"></i>
                                    <h5 class="card-title">Xem sách</h5>
                                    <p class="card-text">Xem danh sách sách và tìm kiếm theo tên, tác giả, thể loại</p>
                                    <a href="sach?action=viewonly" class="btn btn-primary">
                                        <i class="bi bi-book"></i> Xem sách
                                    </a>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-5 mb-4">
                            <div class="card feature-card text-center h-100">
                                <div class="card-body">
                                    <i class="bi bi-info-circle fs-1 text-info mb-3"></i>
                                    <h5 class="card-title">Thông tin cá nhân</h5>
                                    <p class="card-text">Xem và cập nhật thông tin cá nhân</p>
                                    <a href="user-info" class="btn btn-info">
                                        <i class="bi bi-person"></i> Thông tin
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Information Cards -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-card">
                                <h5><i class="bi bi-info-circle text-primary"></i> Hướng dẫn sử dụng</h5>
                                <ul class="list-unstyled">
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Tìm kiếm sách theo tên, tác giả</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Xem thông tin chi tiết sách</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Liên hệ thủ thư để mượn sách</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="info-card">
                                <h5><i class="bi bi-telephone text-primary"></i> Liên hệ hỗ trợ</h5>
                                <p><i class="bi bi-envelope me-2"></i>Email: thuthu@thuvien.com</p>
                                <p><i class="bi bi-phone me-2"></i>Điện thoại: 0123 456 789</p>
                                <p><i class="bi bi-clock me-2"></i>Giờ làm việc: 8:00 - 17:00</p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>



    <!-- User Footer -->
    <footer class="bg-light text-center py-3 mt-5">
        <div class="container">
            <p class="mb-0">&copy; 2024 Hệ thống Quản lý Thư viện. Dành cho người dùng.</p>
        </div>
    </footer>


</body>
</html>
