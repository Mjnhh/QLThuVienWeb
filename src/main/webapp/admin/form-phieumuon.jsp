<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tạo phiếu mượn - Thư viện</title>
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

                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0"><i class="bi bi-plus-circle me-2"></i>Tạo phiếu mượn mới</h5>
                        </div>

                        <div class="card-body">
                            <form action="phieumuon" method="post">
                                <input type="hidden" name="action" value="add" />
                                
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Chọn độc giả <span class="text-danger">*</span></label>
                                            <select name="maDocGia" class="form-select" required>
                                                <option value="">-- Chọn độc giả --</option>
                                                <c:forEach var="docGia" items="${docGiaList}">
                                                    <option value="${docGia.maDocGia}">${docGia.hoTen} (${docGia.maDocGia})</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Ngày mượn <span class="text-danger">*</span></label>
                                            <input type="date" name="ngayMuon" class="form-control" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Ngày trả dự kiến</label>
                                            <input type="date" name="ngayTra" class="form-control">
                                            <div class="form-text">Để trống nếu chưa trả</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label">Chọn sách mượn <span class="text-danger">*</span></label>
                                    <div class="border rounded p-3" style="max-height: 300px; overflow-y: auto;">
                                        <c:choose>
                                            <c:when test="${empty sachList}">
                                                <p class="text-muted">Không có sách nào</p>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="row">
                                                    <c:forEach var="sach" items="${sachList}">
                                                        <div class="col-md-6 mb-2">
                                                            <div class="form-check">
                                                                <input class="form-check-input" type="checkbox" 
                                                                       name="maSach" value="${sach.maSach}" 
                                                                       id="sach_${sach.maSach}">
                                                                <label class="form-check-label" for="sach_${sach.maSach}">
                                                                    <strong>${sach.tenSach}</strong><br>
                                                                    <small class="text-muted">
                                                                        Tác giả: ${sach.tacGia} | 
                                                                        Số lượng: ${sach.soLuong} | 
                                                                        Thể loại: ${sach.theLoai}
                                                                    </small>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <a href="phieumuon" class="btn btn-secondary">
                                        <i class="bi bi-arrow-left"></i> Quay lại
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-save"></i> Tạo phiếu mượn
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>      
        </div>
    </div>
    
    <%@ include file="layout/footer.jsp" %>

    <script>
        // Set ngày mượn mặc định là hôm nay
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.querySelector('input[name="ngayMuon"]').value = today;
        });
    </script>

</body>
</html>
