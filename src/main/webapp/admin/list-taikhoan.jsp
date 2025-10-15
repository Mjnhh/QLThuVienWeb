<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Tài khoản - Thư viện</title>
    <%@ include file="layout/header.jsp" %>
</head>
<body>
    <%@ include file="layout/nav.jsp" %>

    <div class="container-fluid">
        <div class="row">
            <div class="col-2">
                <%@ include file="layout/sidebar.jsp" %>
            </div>

            <div class="col-10 mt-3">
                <div class="container mt-4">

                    <!-- Bảng danh sách tài khoản -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="bi bi-people-fill"></i> Quản lý Tài khoản</h5>
                            <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAddAccount">
                                <i class="bi bi-plus-circle"></i> Thêm tài khoản
                            </button>
                        </div>

                        <div class="card-body">
                            <!-- Hiển thị thông báo -->
                            <c:if test="${not empty message}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${message}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${error}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <!-- Bảng danh sách -->
                            <div class="table-responsive">
                                <table class="table table-striped align-middle" id="tableTaiKhoan">
                                    <thead class="table-primary">
                                        <tr>
                                            <th>Tên đăng nhập</th>
                                            <th>Họ tên</th>
                                            <th>Email</th>
                                            <th>Vai trò</th>
                                            <th>Ngày tạo</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty taiKhoanList}">
                                                <tr>
                                                    <td colspan="6" class="text-center text-muted">
                                                        <i class="bi bi-inbox"></i> Không có dữ liệu
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="taiKhoan" items="${taiKhoanList}">
                                                    <tr>
                                                        <td>
                                                            <strong>${taiKhoan.tenDangNhap}</strong>
                                                        </td>
                                                        <td>${taiKhoan.hoTen}</td>
                                                        <td>${taiKhoan.email}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${taiKhoan.vaiTro == 'Admin'}">
                                                                    <span class="badge bg-danger">${taiKhoan.vaiTro}</span>
                                                                </c:when>
                                                                <c:when test="${taiKhoan.vaiTro == 'Thủ thư'}">
                                                                    <span class="badge bg-warning">${taiKhoan.vaiTro}</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-info">${taiKhoan.vaiTro}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:if test="${not empty taiKhoan.ngayTao}">
                                                                <fmt:formatDate value="${taiKhoan.ngayTao}" pattern="dd/MM/yyyy"/>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-warning btn-sm btnEdit" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#modalEditAccount"
                                                                    data-tendangnhap="${taiKhoan.tenDangNhap}"
                                                                    data-hoten="${taiKhoan.hoTen}"
                                                                    data-email="${taiKhoan.email}"
                                                                    data-vaitro="${taiKhoan.vaiTro}">
                                                                <i class="bi bi-pencil-square"></i>
                                                            </button>
                                                            <c:if test="${taiKhoan.tenDangNhap != sessionScope.tenDangNhap}">
                                                                <a href="taikhoan?action=delete&tenDangNhap=${taiKhoan.tenDangNhap}" 
                                                                   class="btn btn-danger btn-sm"
                                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa tài khoản này?')">
                                                                    <i class="bi bi-trash"></i>
                                                                </a>
                                                            </c:if>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Modal: Thêm tài khoản -->
                    <div class="modal fade" id="modalAddAccount" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <form action="taikhoan" method="post">
                                    <input type="hidden" name="action" value="add" />
                                    <div class="modal-header bg-primary text-white">
                                        <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i>Thêm tài khoản mới</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                                            <input type="text" name="tenDangNhap" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                            <input type="password" name="matKhau" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Họ tên <span class="text-danger">*</span></label>
                                            <input type="text" name="hoTen" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="email" name="email" class="form-control">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Vai trò <span class="text-danger">*</span></label>
                                            <select name="vaiTro" class="form-select" required>
                                                <option value="">Chọn vai trò</option>
                                                <option value="Admin">Admin</option>
                                                <option value="Thủ thư">Thủ thư</option>
                                                <option value="Người dùng">Người dùng</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal: Sửa tài khoản -->
                    <div class="modal fade" id="modalEditAccount" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <form action="taikhoan" method="post">
                                    <input type="hidden" name="action" value="update" />
                                    <div class="modal-header bg-warning text-dark">
                                        <h5 class="modal-title"><i class="bi bi-pencil-square me-2"></i>Sửa thông tin tài khoản</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Tên đăng nhập</label>
                                            <input type="text" class="form-control" id="editTenDangNhap" name="tenDangNhap" readonly>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu mới</label>
                                            <input type="password" class="form-control" id="editMatKhau" name="matKhau" placeholder="Để trống nếu không đổi">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Họ tên <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="editHoTen" name="hoTen" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="email" class="form-control" id="editEmail" name="email">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Vai trò <span class="text-danger">*</span></label>
                                            <select id="editVaiTro" name="vaiTro" class="form-select" required>
                                                <option value="">Chọn vai trò</option>
                                                <option value="Admin">Admin</option>
                                                <option value="Thủ thư">Thủ thư</option>
                                                <option value="Người dùng">Người dùng</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                        <button type="submit" class="btn btn-warning text-white">Cập nhật</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                </div>
            </div>      
        </div>
    </div>
    
    <%@ include file="layout/footer.jsp" %>

    <script>
        // Xử lý modal edit
        document.addEventListener('DOMContentLoaded', function() {
            const editButtons = document.querySelectorAll('.btnEdit');
            editButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const tenDangNhap = this.getAttribute('data-tendangnhap');
                    const hoTen = this.getAttribute('data-hoten');
                    const email = this.getAttribute('data-email');
                    const vaiTro = this.getAttribute('data-vaitro');
                    
                    document.getElementById('editTenDangNhap').value = tenDangNhap;
                    document.getElementById('editHoTen').value = hoTen || '';
                    document.getElementById('editEmail').value = email || '';
                    document.getElementById('editVaiTro').value = vaiTro || '';
                    document.getElementById('editMatKhau').value = '';
                });
            });
        });
    </script>

</body>
</html>
