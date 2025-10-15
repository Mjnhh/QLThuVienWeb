# 🔧 Khắc phục lỗi kết nối Database

## ❌ Lỗi: "Cannot invoke Connection.createStatement() because conn is null"

### 🔍 Nguyên nhân:
Kết nối database bị null, có thể do:

1. **Database chưa được tạo**
2. **Thông tin kết nối sai**
3. **SQL Server chưa chạy**
4. **Port hoặc tên database sai**

### ✅ Cách khắc phục:

#### 1. Kiểm tra SQL Server
```bash
# Kiểm tra SQL Server có đang chạy không
# Mở SQL Server Management Studio (SSMS)
# Kết nối với: localhost,1433
```

#### 2. Tạo Database
Chạy script SQL trong file `QuanLyThuVien.sql`:
```sql
CREATE DATABASE QuanLyThuVien
GO
USE QuanLyThuVien
GO
-- ... (phần còn lại của script)
```

#### 3. Kiểm tra thông tin kết nối
Trong file `DBConnection.java`:
```java
static String url = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyThuVien;encrypt=false";
static String user = "sa";        // Thay đổi theo user của bạn
static String pass = "sa";        // Thay đổi theo password của bạn
```

#### 4. Các thông tin kết nối phổ biến:

**Option 1: SQL Server Authentication**
```java
static String user = "sa";
static String pass = "your_password";
```

**Option 2: Windows Authentication**
```java
static String url = "jdbc:sqlserver://localhost:1433;databaseName=QuanLyThuVien;integratedSecurity=true;encrypt=false";
// Không cần user/pass
```

**Option 3: User khác**
```java
static String user = "qlu";
static String pass = "c24";
```

#### 5. Test kết nối
Chạy method `main` trong `DBConnection.java` để test:
```java
public static void main(String[] args) {
    System.out.println(DBConnection.getConnection());
}
```

### 🚨 Các lỗi thường gặp:

1. **"Login failed for user 'sa'"**
   - Kiểm tra password của user sa
   - Đảm bảo SQL Server Authentication được enable

2. **"Cannot connect to localhost:1433"**
   - Kiểm tra SQL Server có đang chạy
   - Kiểm tra port 1433 có bị block không

3. **"Database 'QuanLyThuVien' does not exist"**
   - Chạy script SQL để tạo database
   - Kiểm tra tên database có đúng không

4. **"Driver not found"**
   - Kiểm tra dependency mssql-jdbc trong pom.xml
   - Rebuild project

### 📝 Checklist:
- [ ] SQL Server đang chạy
- [ ] Database QuanLyThuVien đã được tạo
- [ ] Các bảng đã được tạo với dữ liệu mẫu
- [ ] Thông tin kết nối đúng (user/pass)
- [ ] Port 1433 accessible
- [ ] JDBC driver đã được add vào project

### 🔄 Sau khi sửa:
1. Restart server (Tomcat/GlassFish)
2. Rebuild project
3. Test lại ứng dụng
