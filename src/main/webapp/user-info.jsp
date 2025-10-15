<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin cá nhân - Thư viện</title>
    <%@ include file="admin/layout/header.jsp" %>
    <style>
        .info-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .detail-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .info-item {
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }
        .info-item:last-child {
            border-bottom: none;
        }
        .info-label {
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }
        .info-value {
            color: #666;
            font-size: 1.1rem;
        }
        .badge-role {
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
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
        <!-- Header -->
        <div class="info-card">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2><i class="bi bi-person-circle"></i> Thông tin cá nhân</h2>
                    <p class="mb-0">Xem và quản lý thông tin tài khoản của bạn</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="trang-chu" class="btn btn-light">
                        <i class="bi bi-arrow-left"></i> Về trang chủ
                    </a>
                </div>
            </div>
        </div>

        <!-- User Details -->
        <div class="row">
            <div class="col-md-8">
                <div class="detail-card">
                    <h4 class="mb-4"><i class="bi bi-person-lines-fill"></i> Chi tiết tài khoản</h4>
                    
                    <c:if test="${not empty taiKhoan}">
                        <div class="info-item">
                            <div class="info-label">Tên đăng nhập</div>
                            <div class="info-value">
                                <i class="bi bi-person-badge me-2"></i>
                                ${taiKhoan.tenDangNhap}
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Họ và tên</div>
                            <div class="info-value">
                                <i class="bi bi-person me-2"></i>
                                ${taiKhoan.hoTen}
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Vai trò</div>
                            <div class="info-value">
                                <span class="badge bg-primary badge-role">
                                    <i class="bi bi-shield-check me-1"></i>
                                    ${taiKhoan.vaiTro}
                                </span>
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Email</div>
                            <div class="info-value">
                                <i class="bi bi-envelope me-2"></i>
                                ${taiKhoan.email}
                            </div>
                        </div>
                        
                        <div class="info-item">
                            <div class="info-label">Ngày tạo tài khoản</div>
                            <div class="info-value">
                                <i class="bi bi-calendar-plus me-2"></i>
                                <fmt:formatDate value="${taiKhoan.ngayTao}" pattern="dd/MM/yyyy HH:mm"/>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${empty taiKhoan}">
                        <div class="alert alert-warning">
                            <i class="bi bi-exclamation-triangle"></i>
                            Không thể tải thông tin tài khoản. Vui lòng thử lại sau.
                        </div>
                    </c:if>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="detail-card">
                    <h5 class="mb-3"><i class="bi bi-info-circle"></i> Thông tin hệ thống</h5>
                    
                    <div class="info-item">
                        <div class="info-label">Trạng thái</div>
                        <div class="info-value">
                            <span class="badge bg-success">
                                <i class="bi bi-check-circle me-1"></i>
                                Hoạt động
                            </span>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Quyền truy cập</div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${sessionScope.vaiTro == 'Admin'}">
                                    <span class="badge bg-danger">Toàn quyền</span>
                                </c:when>
                                <c:when test="${sessionScope.vaiTro == 'Thủ thư'}">
                                    <span class="badge bg-warning">Quản lý</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-info">Xem sách</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="info-item">
                        <div class="info-label">Phiên đăng nhập</div>
                        <div class="info-value">
                            <i class="bi bi-clock me-2"></i>
                            <script>
                                document.write(new Date().toLocaleString('vi-VN'));
                            </script>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="detail-card mt-3">
                    <h5 class="mb-3"><i class="bi bi-lightning"></i> Thao tác nhanh</h5>
                    
                    <div class="d-grid gap-2">
                        <a href="trang-chu" class="btn btn-outline-primary">
                            <i class="bi bi-house"></i> Về trang chủ
                        </a>
                        <a href="sach?action=viewonly" class="btn btn-outline-success">
                            <i class="bi bi-book"></i> Xem sách
                        </a>
                        <button class="btn btn-outline-warning" onclick="changePassword()">
                            <i class="bi bi-key"></i> Đổi mật khẩu
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contact Info -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="alert alert-info text-center">
                    <h5><i class="bi bi-headset"></i> Hỗ trợ khách hàng</h5>
                    <p class="mb-0">
                        Cần hỗ trợ? Liên hệ: <strong>0123 456 789</strong> hoặc email: 
                        <strong>support@thuvien.com</strong>
                    </p>
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

    <%@ include file="admin/layout/footer.jsp" %>

    <script>
        function changePassword() {
            alert('Chức năng đổi mật khẩu sẽ được cập nhật trong phiên bản tiếp theo.');
        }
    </script>

</body>
</html>
