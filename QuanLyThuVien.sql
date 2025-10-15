
CREATE DATABASE QuanLyThuVien
GO
USE QuanLyThuVien
GO

-- Bảng Độc giả
CREATE TABLE DocGia (
    MaDocGia INT IDENTITY(1,1) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    NgaySinh DATE,
    DiaChi NVARCHAR(200),
    SoDienThoai VARCHAR(15),
    Email VARCHAR(100)
);

-- Bảng Sách
CREATE TABLE Sach (
    MaSach INT IDENTITY(1,1) PRIMARY KEY,
    TenSach NVARCHAR(200) NOT NULL,
    TacGia NVARCHAR(100),
    NamXuatBan INT,
    TheLoai NVARCHAR(100),
    SoLuong INT DEFAULT 1,
    AnhBia NVARCHAR(250) NULL -- có thể để trống
);

-- Bảng Phiếu mượn
CREATE TABLE PhieuMuon (
    MaPhieu INT IDENTITY(1,1) PRIMARY KEY,
    MaDocGia INT NOT NULL,
    NgayMuon DATE DEFAULT GETDATE(),
    NgayTra DATE NULL,
    TrangThai NVARCHAR(50), -- "Đang mượn", "Đã trả", "Quá hạn"
    FOREIGN KEY (MaDocGia) REFERENCES DocGia(MaDocGia)
);

-- Bảng Chi tiết mượn
CREATE TABLE ChiTietMuon (
    MaPhieu INT NOT NULL,
    MaSach INT NOT NULL,
    SoLuong INT DEFAULT 1,
    TinhTrang NVARCHAR(50), -- "Đã trả", "Mất sách", ...
    PRIMARY KEY (MaPhieu, MaSach),
    FOREIGN KEY (MaPhieu) REFERENCES PhieuMuon(MaPhieu),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- Tạo bảng TaiKhoan
CREATE TABLE TaiKhoan (
    TenDangNhap NVARCHAR(50) PRIMARY KEY,
    MatKhau NVARCHAR(255),
    VaiTro NVARCHAR(50),
    HoTen NVARCHAR(100),
    Email NVARCHAR(100),
    NgayTao DATETIME DEFAULT GETDATE()
);

----------------------------------------------------------
-- Thêm dữ liệu mẫu
----------------------------------------------------------
-- Độc giả
INSERT INTO DocGia(HoTen, NgaySinh, DiaChi, SoDienThoai, Email)
VALUES (N'Nguyễn Văn A', '2000-05-10', N'Hà Nội', '0912345678', 'vana@gmail.com');

INSERT INTO DocGia(HoTen, NgaySinh, DiaChi, SoDienThoai, Email)
VALUES (N'Trần Thị B', '2001-08-20', N'Hồ Chí Minh', '0987654321', 'thib@gmail.com');

INSERT INTO DocGia(HoTen, NgaySinh, DiaChi, SoDienThoai, Email)
VALUES (N'Lê Văn C', '1999-03-15', N'Đà Nẵng', '0905123456', 'levanc@gmail.com');

-- Sách
INSERT INTO Sach(TenSach, TacGia, NamXuatBan, TheLoai, SoLuong)
VALUES (N'Lập trình Java cơ bản', N'Nguyễn Văn Cường', 2022, N'Công nghệ thông tin', 5);

INSERT INTO Sach(TenSach, TacGia, NamXuatBan, TheLoai, SoLuong)
VALUES (N'Cơ sở dữ liệu SQL', N'Phạm Thị Hoa', 2021, N'Công nghệ thông tin', 3);

INSERT INTO Sach(TenSach, TacGia, NamXuatBan, TheLoai, SoLuong)
VALUES (N'Giải tích 1', N'Ngô Bảo Châu', 2020, N'Toán học', 2);

INSERT INTO Sach(TenSach, TacGia, NamXuatBan, TheLoai, SoLuong)
VALUES (N'Lịch sử Việt Nam', N'Trần Quốc Tuấn', 2018, N'Lịch sử', 4);

-- Phiếu mượn
INSERT INTO PhieuMuon(MaDocGia, NgayMuon, NgayTra, TrangThai)
VALUES (1, '2025-08-18', '2025-08-25', N'Đang mượn');

INSERT INTO PhieuMuon(MaDocGia, NgayMuon, NgayTra, TrangThai)
VALUES (2, '2025-08-10', '2025-08-17', N'Đã trả');

INSERT INTO PhieuMuon(MaDocGia, NgayMuon, NgayTra, TrangThai)
VALUES (3, '2025-08-05', '2025-08-12', N'Quá hạn');

-- Chi tiết mượn
INSERT INTO ChiTietMuon(MaPhieu, MaSach, SoLuong, TinhTrang)
VALUES (1, 1, 1, N'Đang mượn');

INSERT INTO ChiTietMuon(MaPhieu, MaSach, SoLuong, TinhTrang)
VALUES (1, 2, 1, N'Đang mượn');

INSERT INTO ChiTietMuon(MaPhieu, MaSach, SoLuong, TinhTrang)
VALUES (2, 3, 1, N'Đã trả');

INSERT INTO ChiTietMuon(MaPhieu, MaSach, SoLuong, TinhTrang)
VALUES (3, 4, 1, N'Quá hạn');

-- Tài khoản
INSERT INTO TaiKhoan(TenDangNhap, MatKhau, VaiTro, HoTen, Email)
VALUES ('admin', 'admin123', N'Admin', N'Quản trị viên', 'admin@thuvien.com');

INSERT INTO TaiKhoan(TenDangNhap, MatKhau, VaiTro, HoTen, Email)
VALUES ('thuthu', 'thuthu123', N'Thủ thư', N'Nguyễn Nhật Minh', 'thuthu@thuvien.com');

INSERT INTO TaiKhoan(TenDangNhap, MatKhau, VaiTro, HoTen, Email)
VALUES ('user', 'user123', N'Người dùng', N'Nguyễn Nhật Minh', 'user@thuvien.com');

