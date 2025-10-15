<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Sách - Thư viện</title>
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

                    <!-- Bảng danh sách sách -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="bi bi-book"></i> Quản lý sách</h5>
                            <button class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#modalAddBook">
                                <i class="bi bi-plus-circle"></i> Thêm sách
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
                            <form class="row g-3 mb-3" action="sach" method="post">
                                <input type="hidden" name="action" value="search" />
                                <div class="col-md-3">
                                    <select name="searchType" class="form-select">
                                        <option value="ten" ${searchType == 'ten' ? 'selected' : ''}>Tìm theo tên sách</option>
                                        <option value="tacgia" ${searchType == 'tacgia' ? 'selected' : ''}>Tìm theo tác giả</option>
                                        <option value="nam" ${searchType == 'nam' ? 'selected' : ''}>Tìm theo năm xuất bản</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" name="keyword" value="${searchKeyword}" class="form-control" placeholder="Nhập từ khóa tìm kiếm...">
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary me-2">
                                        <i class="bi bi-search"></i> Tìm kiếm
                                    </button>
                                    <a href="sach" class="btn btn-secondary">
                                        <i class="bi bi-arrow-clockwise"></i> Làm mới
                                    </a>
                                </div>
                            </form>

                            <!-- Bảng danh sách -->
                            <div class="table-responsive">
                                <table class="table table-striped align-middle" id="tableSach">
                                    <thead class="table-primary">
                                        <tr>
                                            <th>Mã sách</th>
                                            <th>Ảnh bìa</th>
                                            <th>Tên sách</th>
                                            <th>Tác giả</th>
                                            <th>Năm XB</th>
                                            <th>Thể loại</th>
                                            <th>Số lượng</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty sachList}">
                                                <tr>
                                                    <td colspan="8" class="text-center text-muted">
                                                        <i class="bi bi-inbox"></i> Không có dữ liệu
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="sach" items="${sachList}">
                                                    <tr>
                                                        <td>${sach.maSach}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty sach.anhBia}">
                                                                    <img src="${sach.anhBia}" alt="Ảnh bìa" class="img-thumbnail" style="width: 50px; height: 70px; object-fit: cover;">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="bg-light d-flex align-items-center justify-content-center" style="width: 50px; height: 70px;">
                                                                        <i class="bi bi-book text-muted"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${sach.tenSach}</td>
                                                        <td>${sach.tacGia}</td>
                                                        <td>${sach.namXuatBan}</td>
                                                        <td>${sach.theLoai}</td>
                                                        <td>
                                                            <span class="badge bg-${sach.soLuong > 0 ? 'success' : 'danger'}">
                                                                ${sach.soLuong}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-warning btn-sm btnEdit" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#modalEditBook"
                                                                    data-ma="${sach.maSach}"
                                                                    data-ten="${sach.tenSach}"
                                                                    data-tacgia="${sach.tacGia}"
                                                                    data-nam="${sach.namXuatBan}"
                                                                    data-theloai="${sach.theLoai}"
                                                                    data-soluong="${sach.soLuong}"
                                                                    data-anhbia="${sach.anhBia}">
                                                                <i class="bi bi-pencil-square"></i>
                                                            </button>
                                                            <a href="sach?action=delete&maSach=${sach.maSach}" 
                                                               class="btn btn-danger btn-sm"
                                                               onclick="return confirm('Bạn có chắc chắn muốn xóa sách này?')">
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

                    <!-- Modal: Thêm sách -->
                    <div class="modal fade" id="modalAddBook" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <form action="sach" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="add" />
                                    <div class="modal-header bg-primary text-white">
                                        <h5 class="modal-title"><i class="bi bi-plus-circle me-2"></i>Thêm sách mới</h5>
                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Tên sách <span class="text-danger">*</span></label>
                                            <input type="text" name="TenSach" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Tác giả</label>
                                            <input type="text" name="TacGia" class="form-control">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Năm xuất bản</label>
                                            <input type="number" name="NamXuatBan" class="form-control" min="1900" max="2030">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Thể loại</label>
                                            <select name="TheLoai" class="form-select">
                                                <option value="">Chọn thể loại</option>
                                                <option value="Công nghệ thông tin">Công nghệ thông tin</option>
                                                <option value="Toán học">Toán học</option>
                                                <option value="Lịch sử">Lịch sử</option>
                                                <option value="Văn học">Văn học</option>
                                                <option value="Khoa học">Khoa học</option>
                                                <option value="Kinh tế">Kinh tế</option>
                                                <option value="Khác">Khác</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Số lượng</label>
                                            <input type="number" name="SoLuong" class="form-control" min="1" value="1">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Ảnh bìa sách</label>
                                            <input type="file" name="anhBia" class="form-control" accept="image/*" onchange="previewImage(this)">
                                            <div class="form-text">Chọn file ảnh bìa sách (JPG, PNG, GIF)</div>
                                            <div id="imagePreview" class="mt-2" style="display: none;">
                                                <img id="previewImg" src="" alt="Preview" class="img-thumbnail" style="max-width: 200px; max-height: 200px;">
                                            </div>
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

                    <!-- Modal: Sửa sách -->
                    <div class="modal fade" id="modalEditBook" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <form action="sach" method="post" enctype="multipart/form-data">
                                    <input type="hidden" name="action" value="update" />
                                    <div class="modal-header bg-warning text-dark">
                                        <h5 class="modal-title"><i class="bi bi-pencil-square me-2"></i>Sửa thông tin sách</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label class="form-label">Mã sách</label>
                                            <input type="text" class="form-control" id="editMaSach" name="maSach" readonly>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Tên sách <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="editTenSach" name="TenSach" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Tác giả</label>
                                            <input type="text" class="form-control" id="editTacGia" name="TacGia">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Năm xuất bản</label>
                                            <input type="number" class="form-control" id="editNamXuatBan" name="NamXuatBan" min="1900" max="2030">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Thể loại</label>
                                            <select id="editTheLoai" name="TheLoai" class="form-select">
                                                <option value="">Chọn thể loại</option>
                                                <option value="Công nghệ thông tin">Công nghệ thông tin</option>
                                                <option value="Toán học">Toán học</option>
                                                <option value="Lịch sử">Lịch sử</option>
                                                <option value="Văn học">Văn học</option>
                                                <option value="Khoa học">Khoa học</option>
                                                <option value="Kinh tế">Kinh tế</option>
                                                <option value="Khác">Khác</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Số lượng</label>
                                            <input type="number" class="form-control" id="editSoLuong" name="SoLuong" min="1">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Ảnh bìa sách</label>
                                            <input type="file" class="form-control" id="editAnhBia" name="anhBia" accept="image/*" onchange="previewEditImage(this)">
                                            <div class="form-text">Chọn file ảnh bìa sách mới (để trống nếu không thay đổi)</div>
                                            <div id="editImagePreview" class="mt-2" style="display: none;">
                                                <img id="editPreviewImg" src="" alt="Preview" class="img-thumbnail" style="max-width: 200px; max-height: 200px;">
                                            </div>
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
        // Preview ảnh khi chọn file
        function previewImage(input) {
            const preview = document.getElementById('imagePreview');
            const previewImg = document.getElementById('previewImg');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
            }
        }
        
        function previewEditImage(input) {
            const preview = document.getElementById('editImagePreview');
            const previewImg = document.getElementById('editPreviewImg');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
            }
        }

        // Xử lý modal edit
        document.addEventListener('DOMContentLoaded', function() {
            const editButtons = document.querySelectorAll('.btnEdit');
            editButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const ma = this.getAttribute('data-ma');
                    const ten = this.getAttribute('data-ten');
                    const tacgia = this.getAttribute('data-tacgia');
                    const nam = this.getAttribute('data-nam');
                    const theloai = this.getAttribute('data-theloai');
                    const soluong = this.getAttribute('data-soluong');
                    const anhbia = this.getAttribute('data-anhbia');
                    
                    document.getElementById('editMaSach').value = ma;
                    document.getElementById('editTenSach').value = ten || '';
                    document.getElementById('editTacGia').value = tacgia || '';
                    document.getElementById('editNamXuatBan').value = nam || '';
                    document.getElementById('editTheLoai').value = theloai || '';
                    document.getElementById('editSoLuong').value = soluong || '';
                    
                    // Reset file input
                    document.getElementById('editAnhBia').value = '';
                    document.getElementById('editImagePreview').style.display = 'none';
                });
            });
        });
    </script>

</body>
</html>