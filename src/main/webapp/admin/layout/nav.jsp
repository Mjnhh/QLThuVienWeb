<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold d-flex align-items-center" href="trang-chu">
      <i class="bi bi-book-half me-2"></i> Quản lý Thư viện
    </a>
    <div class="d-flex align-items-center">
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