# Hệ thống Quản lý Thư viện - Java Web

## 📋 Mô tả
Hệ thống quản lý thư viện được xây dựng theo mô hình MVC + DAO với các chức năng:
- Quản lý Độc giả (CRUD + Tìm kiếm)
- Quản lý Sách (CRUD + Upload ảnh bìa)
- Quản lý Mượn/Trả sách
- Dashboard thống kê

## 🏗️ Cấu trúc Project

### Model Layer
- `DocGia.java` - Entity độc giả
- `DocGiaDAO.java` - Data Access Object cho độc giả
- `DBConnection.java` - Kết nối SQL Server

### View Layer
- `dashboard.jsp` - Trang chủ với thống kê
- `list-docgia.jsp` - Quản lý độc giả
- `list-sach.jsp` - Quản lý sách
- Layout components: `header.jsp`, `sidebar.jsp`, `footer.jsp`

### Controller Layer
- `DocGiaServlet.java` - Xử lý CRUD độc giả
- `SachServlet.java` - Xử lý CRUD sách
- `HomeServlet.java` - Trang chủ

## 🚀 Cài đặt và Chạy

### 1. Tạo Database
Chạy script SQL trong file `QuanLyThuVien.sql`:
```sql
-- Tạo database và các bảng
-- Thêm dữ liệu mẫu
```

### 2. Cấu hình kết nối
Cập nhật thông tin trong `DBConnection.java`:
```java
static String url = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyThuVien;encrypt=false";
static String user = "sa";
static String pass = "sa";
```

### 3. Build và Deploy
```bash
mvn clean package
```

### 4. Deploy WAR file
Deploy file `WebQLThuVien-1.0-SNAPSHOT.war` vào Servlet Container.

## 📊 Chức năng đã hoàn thành

### ✅ Quản lý Độc giả
- **Thêm độc giả**: Form modal với validation
- **Sửa độc giả**: Modal edit với data binding
- **Xóa độc giả**: Confirmation dialog
- **Tìm kiếm nâng cao**: Theo họ tên, SĐT, Email
- **Hiển thị**: Bảng responsive với JSTL

### ✅ Quản lý Sách
- **Thêm sách**: Form modal với dropdown thể loại
- **Sửa sách**: Modal edit với data binding
- **Xóa sách**: Confirmation dialog
- **Tìm kiếm nâng cao**: Theo tên, tác giả, năm xuất bản
- **Hiển thị ảnh bìa**: Thumbnail với placeholder
- **Badge số lượng**: Hiển thị trạng thái sách

### ✅ Quản lý Mượn/Trả
- **Tạo phiếu mượn**: Chọn độc giả + nhiều sách (checkbox)
- **Xem chi tiết**: Danh sách sách mượn trong phiếu
- **Trả sách**: Cập nhật ngày trả và trạng thái
- **Kiểm tra quá hạn**: Tự động cập nhật trạng thái
- **Quản lý trạng thái**: Đang mượn, Đã trả, Quá hạn

### ✅ Dashboard thống kê
- **Thống kê thật**: Từ database
- **Tổng số sách**: Đếm từ bảng Sach
- **Tổng độc giả**: Đếm từ bảng DocGia
- **Sách đang mượn**: Đếm phiếu mượn chưa trả
- **Sách quá hạn**: Tự động cập nhật

### ✅ Hệ thống phân quyền
- **Admin**: Toàn quyền truy cập tất cả chức năng
- **Thủ thư**: Quản lý độc giả, sách, mượn/trả (không quản lý tài khoản)
- **Người dùng**: Dashboard riêng với chức năng hạn chế (tìm kiếm, xem sách)

## 🎯 URL Mapping

### Độc giả
- `GET /docgia` → Hiển thị danh sách
- `POST /docgia?action=add` → Thêm độc giả
- `POST /docgia?action=update` → Cập nhật độc giả
- `GET /docgia?action=delete&maDocGia=X` → Xóa độc giả
- `POST /docgia?action=search` → Tìm kiếm

### Sách
- `GET /sach` → Hiển thị danh sách sách
- `POST /sach?action=add` → Thêm sách
- `POST /sach?action=update` → Cập nhật sách
- `GET /sach?action=delete&maSach=X` → Xóa sách
- `POST /sach?action=search` → Tìm kiếm sách

### Mượn/Trả
- `GET /phieumuon` → Hiển thị danh sách phiếu mượn
- `GET /phieumuon?action=form` → Form tạo phiếu mượn
- `POST /phieumuon?action=add` → Tạo phiếu mượn
- `GET /phieumuon?action=edit&maPhieu=X` → Xem chi tiết phiếu
- `POST /phieumuon?action=update` → Cập nhật phiếu mượn
- `GET /phieumuon?action=tra&maPhieu=X` → Trả sách
- `GET /phieumuon?action=delete&maPhieu=X` → Xóa phiếu mượn

### Dashboard
- `GET /trang-chu` → Trang chủ với thống kê

### Quản lý Tài khoản
- `GET /taikhoan` → Hiển thị danh sách tài khoản
- `POST /taikhoan?action=add` → Thêm tài khoản
- `POST /taikhoan?action=update` → Cập nhật tài khoản
- `GET /taikhoan?action=delete&tenDangNhap=X` → Xóa tài khoản

### Trang chính
- `GET /` → Trang chính với menu điều hướng

## 🛠️ Công nghệ sử dụng
- **Backend**: Java Servlet + JDBC
- **Frontend**: JSP + JSTL + Bootstrap 5
- **Database**: SQL Server
- **Build Tool**: Maven
- **Architecture**: MVC + DAO Pattern

## 📝 Ghi chú
- Sử dụng JSTL để hiển thị dữ liệu
- Bootstrap 5 cho giao diện responsive
- UTF-8 encoding cho tiếng Việt
- Error handling và validation cơ bản
