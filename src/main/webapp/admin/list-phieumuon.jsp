<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Mượn/Trả - Thư viện</title>
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

                    <!-- Bảng danh sách phiếu mượn -->
                    <div class="card shadow-sm">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="bi bi-arrow-left-right"></i> Quản lý Mượn/Trả</h5>
                            <a href="phieumuon?action=form" class="btn btn-success btn-sm">
                                <i class="bi bi-plus-circle"></i> Tạo phiếu mượn
                            </a>
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
                                <table class="table table-striped align-middle" id="tablePhieuMuon">
                                    <thead class="table-primary">
                                        <tr>
                                            <th>Mã phiếu</th>
                                            <th>Độc giả</th>
                                            <th>Ngày mượn</th>
                                            <th>Ngày trả</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty phieuMuonList}">
                                                <tr>
                                                    <td colspan="6" class="text-center text-muted">
                                                        <i class="bi bi-inbox"></i> Không có dữ liệu
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="phieuMuon" items="${phieuMuonList}">
                                                    <tr>
                                                        <td>${phieuMuon.maPhieu}</td>
                                                        <td>${phieuMuon.tenDocGia}</td>
                                                        <td>
                                                            <fmt:formatDate value="${phieuMuon.ngayMuon}" pattern="dd/MM/yyyy"/>
                                                        </td>
                                                        <td>
                                                            <c:if test="${not empty phieuMuon.ngayTra}">
                                                                <fmt:formatDate value="${phieuMuon.ngayTra}" pattern="dd/MM/yyyy"/>
                                                            </c:if>
                                                        </td>
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
                                                        <td>
                                                            <a href="phieumuon?action=edit&maPhieu=${phieuMuon.maPhieu}" 
                                                               class="btn btn-info btn-sm">
                                                                <i class="bi bi-eye"></i> Chi tiết
                                                            </a>
                                                            <c:if test="${phieuMuon.trangThai == 'Đang mượn'}">
                                                                <a href="phieumuon?action=tra&maPhieu=${phieuMuon.maPhieu}" 
                                                                   class="btn btn-success btn-sm"
                                                                   onclick="return confirm('Xác nhận trả sách?')">
                                                                    <i class="bi bi-check-circle"></i> Trả sách
                                                                </a>
                                                            </c:if>
                                                            <a href="phieumuon?action=delete&maPhieu=${phieuMuon.maPhieu}" 
                                                               class="btn btn-danger btn-sm"
                                                               onclick="return confirm('Bạn có chắc chắn muốn xóa phiếu mượn này?')">
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

                </div>
            </div>      
        </div>
    </div>
    
    <%@ include file="layout/footer.jsp" %>

</body>
</html>
