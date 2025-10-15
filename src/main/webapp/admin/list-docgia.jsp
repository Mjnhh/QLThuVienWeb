<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Trang Quản trị Thư viện</title>
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

                        <!-- Bảng danh sách độc giả -->
                        <div class="card shadow-sm">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <h5 class="mb-0"><i class="bi bi-people"></i> Quản lý độc giả</h5>
                                <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAddReader">
                                    <i class="bi bi-plus-circle"></i> Thêm độc giả
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

                                <!-- Form tìm kiếm nâng cao -->
                                <form class="row g-3 mb-3" action="docgia" method="post">
                                    <input type="hidden" name="action" value="search" />
                                    <div class="col-md-3">
                                        <select name="searchType" class="form-select">
                                            <option value="ten" ${searchType == 'ten' ? 'selected' : ''}>Tìm theo họ tên</option>
                                            <option value="sdt" ${searchType == 'sdt' ? 'selected' : ''}>Tìm theo SĐT</option>
                                            <option value="email" ${searchType == 'email' ? 'selected' : ''}>Tìm theo Email</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="text" name="keyword" value="${searchKeyword}" class="form-control" placeholder="Nhập từ khóa tìm kiếm...">
                                    </div>
                                    <div class="col-md-3">
                                        <button type="submit" class="btn btn-primary me-2">
                                            <i class="bi bi-search"></i> Tìm kiếm
                                        </button>
                                        <a href="docgia" class="btn btn-secondary">
                                            <i class="bi bi-arrow-clockwise"></i> Làm mới
                                        </a>
                                    </div>
                                </form>

                                <!-- Bảng danh sách độc giả -->
                                <div class="table-responsive">
                                    <table class="table table-striped align-middle" id="tableDocGia">
                                        <thead class="table-primary">
                                            <tr>
                                                <th>Mã độc giả</th>
                                                <th>Họ tên</th>
                                                <th>Ngày sinh</th>
                                                <th>Địa chỉ</th>
                                                <th>Số điện thoại</th>
                                                <th>Email</th>
                                                <th>Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty docGiaList}">
                                                    <tr>
                                                        <td colspan="7" class="text-center text-muted">
                                                            <i class="bi bi-inbox"></i> Không có dữ liệu
                                                        </td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="docGia" items="${docGiaList}">
                                                        <tr>
                                                            <td>${docGia.maDocGia}</td>
                                                            <td>${docGia.hoTen}</td>
                                                            <td>
                                                                <c:if test="${not empty docGia.ngaySinh}">
                                                                    <fmt:formatDate value="${docGia.ngaySinh}" pattern="dd/MM/yyyy"/>
                                                                </c:if>
                                                            </td>
                                                            <td>${docGia.diaChi}</td>
                                                            <td>${docGia.soDienThoai}</td>
                                                            <td>${docGia.email}</td>
                                                            <td>
                                                                <button class="btn btn-warning btn-sm btnEdit" 
                                                                        data-bs-toggle="modal" 
                                                                        data-bs-target="#modalEditReader"
                                                                        data-ma="${docGia.maDocGia}"
                                                                        data-ten="${docGia.hoTen}"
                                                                        data-ngaysinh="<fmt:formatDate value='${docGia.ngaySinh}' pattern='yyyy-MM-dd'/>"
                                                                        data-diachi="${docGia.diaChi}"
                                                                        data-sdt="${docGia.soDienThoai}"
                                                                        data-email="${docGia.email}">
                                                                    <i class="bi bi-pencil-square"></i>
                                                                </button>
                                                                <a href="docgia?action=delete&maDocGia=${docGia.maDocGia}" 
                                                                   class="btn btn-danger btn-sm"
                                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa độc giả này?')">
                                                                    <i class="bi bi-trash"></i>
                                                                </a>
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

                        <!-- Modal: Thêm độc giả -->
                        <div class="modal fade" id="modalAddReader" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <form action="docgia" method="post">
                                        <input name="action" value="add" type="hidden" />
                                        <div class="modal-header bg-primary text-white">
                                            <h5 class="modal-title"><i class="bi bi-person-plus me-2"></i>Thêm độc giả</h5>
                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label class="form-label">Họ tên</label>
                                                <input type="text" class="form-control" name="HoTen" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Ngày sinh</label>
                                                <input type="date" class="form-control" name="NgaySinh">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ</label>
                                                <input type="text" class="form-control" name="DiaChi">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" name="SoDienThoai">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Email</label>
                                                <input type="email" class="form-control" name="Email">
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                            <button type="submit" class="btn btn-primary">Lưu</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Modal: Sửa độc giả -->
                        <div class="modal fade" id="modalEditReader" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <form action="docgia" method="post">
                                        <input type="hidden" name="action" value="update" />
                                        <div class="modal-header bg-warning text-dark">
                                            <h5 class="modal-title"><i class="bi bi-pencil-square me-2"></i>Sửa thông tin độc giả</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label class="form-label">Mã độc giả</label>
                                                <input type="text" class="form-control" id="editMaDocGia" name="maDocGia" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Họ tên</label>
                                                <input type="text" class="form-control" id="editHoTen" name="HoTen" required>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Ngày sinh</label>
                                                <input type="date" class="form-control" id="editNgaySinh" name="NgaySinh">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ</label>
                                                <input type="text" class="form-control" id="editDiaChi" name="DiaChi">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" id="editSoDienThoai" name="SoDienThoai">
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Email</label>
                                                <input type="email" class="form-control" id="editEmail" name="Email">
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
                        const ma = this.getAttribute('data-ma');
                        const ten = this.getAttribute('data-ten');
                        const ngaysinh = this.getAttribute('data-ngaysinh');
                        const diachi = this.getAttribute('data-diachi');
                        const sdt = this.getAttribute('data-sdt');
                        const email = this.getAttribute('data-email');
                        
                        document.getElementById('editMaDocGia').value = ma;
                        document.getElementById('editHoTen').value = ten || '';
                        document.getElementById('editNgaySinh').value = ngaysinh || '';
                        document.getElementById('editDiaChi').value = diachi || '';
                        document.getElementById('editSoDienThoai').value = sdt || '';
                        document.getElementById('editEmail').value = email || '';
                    });
                });
            });
        </script>

    </body>
</html>
