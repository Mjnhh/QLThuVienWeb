<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Trang Quản trị Thư viện</title>   
     <%@ include file="layout/header.jsp" %>
</head>
<body>
    <%@ include file="layout/nav.jsp" %>
<div class="container-fluid">
  <div class="row">
    <div class="col-md-2">
      <%@ include file="layout/sidebar.jsp" %>
    </div>
    <div class="col-md-10 mt-3">
      <h2><i class="bi bi-speedometer2 me-2"></i>Bảng điều khiển</h2>
      <hr>
      <p>Chào mừng bạn đến với hệ thống quản lý thư viện!</p>

      <div class="row text-center g-3">
        <div class="col-md-3">
          <div class="card border-primary shadow-sm">
            <div class="card-body">
              <i class="bi bi-book fs-2 text-primary"></i>
              <h5 class="mt-2">Tổng số sách</h5>
              <p class="fs-4 fw-bold text-primary">${totalSach}</p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card border-success shadow-sm">
            <div class="card-body">
              <i class="bi bi-people fs-2 text-success"></i>
              <h5 class="mt-2">Độc giả</h5>
              <p class="fs-4 fw-bold text-success">${totalDocGia}</p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card border-warning shadow-sm">
            <div class="card-body">
              <i class="bi bi-arrow-left-right fs-2 text-warning"></i>
              <h5 class="mt-2">Sách đang mượn</h5>
              <p class="fs-4 fw-bold text-warning">${dangMuon}</p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card border-danger shadow-sm">
            <div class="card-body">
              <i class="bi bi-exclamation-triangle fs-2 text-danger"></i>
              <h5 class="mt-2">Trễ hạn</h5>
              <p class="fs-4 fw-bold text-danger">${quaHan}</p>
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
