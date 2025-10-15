<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết phiếu mượn - Thư viện</title>
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
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0"><i class="bi bi-eye me-2"></i>Chi tiết phiếu mượn #${phieuMuon.maPhieu}</h5>
                        </div>

                        <div class="card-body">
                            <c:if test="${not empty phieuMuon}">
                                <!-- Thông tin phiếu mượn -->
                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <h6>Thông tin phiếu mượn</h6>
                                        <table class="table table-sm">
                                            <tr>
                                                <td><strong>Mã phiếu:</strong></td>
                                                <td>${phieuMuon.maPhieu}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Độc giả:</strong></td>
                                                <td>${phieuMuon.tenDocGia}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Ngày mượn:</strong></td>
                                                <td><fmt:formatDate value="${phieuMuon.ngayMuon}" pattern="dd/MM/yyyy"/></td>
                                            </tr>
                                            <tr>
                                                <td><strong>Ngày trả:</strong></td>
                                                <td>
                                                    <c:if test="${not empty phieuMuon.ngayTra}">
                                                        <fmt:formatDate value="${phieuMuon.ngayTra}" pattern="dd/MM/yyyy"/>
                                                    </c:if>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Trạng thái:</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${phieuMuon.trangThai == 'Đang mượn'}">
                                                            <span class="badge bg-warning">${phieuMuon.trangThai}</span>
                                                        </c:when>
                                                        <c:when test="${phieuMuon.trangThai == 'Đã trả'}">
                                                            <span class="badge bg-success">${phieuMuon.trangThai}</span>
                                                        </c:when>
                                                        <c:when test="${phieuMuon.trangThai == 'Quá hạn'}">
                                                            <span class="badge bg-danger">${phieuMuon.trangThai}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">${phieuMuon.trangThai}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <!-- Danh sách sách mượn -->
                                <h6>Danh sách sách mượn</h6>
                                <div class="table-responsive">
                                    <table class="table table-striped">
                                        <thead class="table-primary">
                                            <tr>
                                                <th>Mã sách</th>
                                                <th>Tên sách</th>
                                                <th>Số lượng</th>
                                                <th>Tình trạng</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${empty chiTietList}">
                                                    <tr>
                                                        <td colspan="4" class="text-center text-muted">
                                                            <i class="bi bi-inbox"></i> Không có sách nào
                                                        </td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="chiTiet" items="${chiTietList}">
                                                        <tr>
                                                            <td>${chiTiet.maSach}</td>
                                                            <td>${chiTiet.tenSach}</td>
                                                            <td>${chiTiet.soLuong}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${chiTiet.tinhTrang == 'Đang mượn'}">
                                                                        <span class="badge bg-warning">${chiTiet.tinhTrang}</span>
                                                                    </c:when>
                                                                    <c:when test="${chiTiet.tinhTrang == 'Đã trả'}">
                                                                        <span class="badge bg-success">${chiTiet.tinhTrang}</span>
                                                                    </c:when>
                                                                    <c:when test="${chiTiet.tinhTrang == 'Quá hạn'}">
                                                                        <span class="badge bg-danger">${chiTiet.tinhTrang}</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary">${chiTiet.tinhTrang}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Form cập nhật -->
                                <c:if test="${phieuMuon.trangThai == 'Đang mượn' || phieuMuon.trangThai == 'Quá hạn'}">
                                    <hr>
                                    <h6>Cập nhật thông tin trả sách</h6>
                                    <form action="phieumuon" method="post" class="row g-3">
                                        <input type="hidden" name="action" value="update" />
                                        <input type="hidden" name="maPhieu" value="${phieuMuon.maPhieu}" />
                                        
                                        <div class="col-md-4">
                                            <label class="form-label">Ngày trả</label>
                                            <input type="date" name="ngayTra" class="form-control">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Trạng thái</label>
                                            <select name="trangThai" class="form-select">
                                                <option value="Đang mượn" ${phieuMuon.trangThai == 'Đang mượn' ? 'selected' : ''}>Đang mượn</option>
                                                <option value="Đã trả">Đã trả</option>
                                                <option value="Quá hạn" ${phieuMuon.trangThai == 'Quá hạn' ? 'selected' : ''}>Quá hạn</option>
                                            </select>
                                        </div>
                                        <div class="col-md-4 d-flex align-items-end">
                                            <button type="submit" class="btn btn-warning">
                                                <i class="bi bi-save"></i> Cập nhật
                                            </button>
                                        </div>
                                    </form>
                                </c:if>
                            </c:if>

                            <div class="mt-4">
                                <a href="phieumuon" class="btn btn-secondary">
                                    <i class="bi bi-arrow-left"></i> Quay lại
                                </a>
                            </div>
                        </div>
                    </div>

                </div>
            </div>      
        </div>
    </div>
    
    <%@ include file="layout/footer.jsp" %>

    <script>
        // Set ngày trả mặc định là hôm nay
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            const ngayTraInput = document.querySelector('input[name="ngayTra"]');
            if (ngayTraInput) {
                ngayTraInput.value = today;
            }
        });
    </script>

</body>
</html>
