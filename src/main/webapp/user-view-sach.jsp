<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách sách - Thư viện</title>
    <%@ include file="admin/layout/header.jsp" %>
    <style>
        .book-card {
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 15px;
            margin-bottom: 1.5rem;
        }
        .book-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }
        .book-cover {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 10px;
        }
        .book-info {
            padding: 1rem;
        }
        .search-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
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
        <!-- Search Section -->
        <div class="search-section">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2><i class="bi bi-book"></i> Danh sách sách trong thư viện</h2>
                    <p class="mb-0">Tìm kiếm và xem thông tin sách có sẵn</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="trang-chu" class="btn btn-light">
                        <i class="bi bi-arrow-left"></i> Về trang chủ
                    </a>
                </div>
            </div>
        </div>

        <!-- Search Form -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <form class="row g-3" action="sach" method="get">
                            <input type="hidden" name="action" value="viewonly" />
                            <div class="col-md-3">
                                <select name="searchType" class="form-select">
                                    <option value="ten" ${searchType == 'ten' ? 'selected' : ''}>Tìm theo tên sách</option>
                                    <option value="tacgia" ${searchType == 'tacgia' ? 'selected' : ''}>Tìm theo tác giả</option>
                                    <option value="theloai" ${searchType == 'theloai' ? 'selected' : ''}>Tìm theo thể loại</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="keyword" value="${searchKeyword}" class="form-control" placeholder="Nhập từ khóa tìm kiếm...">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="bi bi-search"></i> Tìm kiếm
                                </button>
                                <a href="sach?action=viewonly" class="btn btn-secondary">
                                    <i class="bi bi-arrow-clockwise"></i> Làm mới
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Books Grid -->
        <div class="row">
            <c:forEach var="sach" items="${sachList}">
                <div class="col-md-4 col-lg-3">
                    <div class="card book-card h-100">
                        <div class="text-center p-3">
                            <c:choose>
                                <c:when test="${not empty sach.anhBia}">
                                    <img src="${sach.anhBia}" alt="Ảnh bìa" class="book-cover">
                                </c:when>
                                <c:otherwise>
                                    <div class="book-cover d-flex align-items-center justify-content-center bg-light">
                                        <i class="bi bi-book fs-1 text-muted"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="book-info">
                            <h6 class="card-title text-truncate" title="${sach.tenSach}">${sach.tenSach}</h6>
                            <p class="card-text">
                                <small class="text-muted">
                                    <i class="bi bi-person"></i> ${sach.tacGia}<br>
                                    <i class="bi bi-calendar"></i> ${sach.namXuatBan}<br>
                                    <i class="bi bi-tag"></i> ${sach.theLoai}
                                </small>
                            </p>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="badge bg-success">
                                    <i class="bi bi-box"></i> ${sach.soLuong} cuốn
                                </span>
                                <small class="text-muted">ID: ${sach.maSach}</small>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- No Results Message -->
        <c:if test="${empty sachList}">
            <div class="text-center py-5">
                <i class="bi bi-book fs-1 text-muted"></i>
                <h4 class="text-muted mt-3">Không tìm thấy sách nào</h4>
                <p class="text-muted">Thử thay đổi từ khóa tìm kiếm hoặc liên hệ thủ thư để được hỗ trợ.</p>
                <a href="sach?action=viewonly" class="btn btn-primary">
                    <i class="bi bi-arrow-clockwise"></i> Xem tất cả sách
                </a>
            </div>
        </c:if>

        <!-- Contact Info -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="alert alert-info text-center">
                    <h5><i class="bi bi-info-circle"></i> Thông tin liên hệ</h5>
                    <p class="mb-0">
                        Để mượn sách, vui lòng liên hệ thủ thư tại quầy thư viện hoặc gọi: 
                        <strong>0123 456 789</strong>
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

</body>
</html>
