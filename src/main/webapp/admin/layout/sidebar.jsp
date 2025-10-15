<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- sidebar.jsp -->
<div class="sidebar bg-light p-3">
  <h6 class="text-center mb-3"><i class="bi bi-journal-text me-2"></i>Menu Quản lý</h6>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="trang-chu">
        <i class="bi bi-house-door-fill me-2"></i> Trang chủ
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="docgia">
        <i class="bi bi-people me-2"></i> Quản lý Độc giả
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="sach">
        <i class="bi bi-book me-2"></i> Quản lý Sách
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="phieumuon">
        <i class="bi bi-arrow-left-right me-2"></i> Mượn - Trả
      </a>
    </li>
    <c:if test="${sessionScope.vaiTro == 'Admin'}">
        <li class="nav-item">
          <a class="nav-link d-flex align-items-center" href="taikhoan">
            <i class="bi bi-gear me-2"></i> Quản trị hệ thống
          </a>
        </li>
    </c:if>
  </ul>
</div>
