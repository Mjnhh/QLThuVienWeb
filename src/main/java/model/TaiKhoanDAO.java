package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class TaiKhoanDAO {

    // Kiểm tra đăng nhập
    public TaiKhoan checkLogin(String tenDangNhap, String matKhau) {
        String sql = "SELECT * FROM TaiKhoan WHERE TenDangNhap = ? AND MatKhau = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, tenDangNhap);
            ps.setString(2, matKhau);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new TaiKhoan(
                        rs.getString("TenDangNhap"),
                        rs.getString("MatKhau"),
                        rs.getString("VaiTro"),
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        rs.getDate("NgayTao")
                    );
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra đăng nhập:");
            e.printStackTrace();
        }
        
        return null;
    }

    // Lấy tài khoản theo tên đăng nhập
    public TaiKhoan getByTenDangNhap(String tenDangNhap) {
        String sql = "SELECT * FROM TaiKhoan WHERE TenDangNhap = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, tenDangNhap);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new TaiKhoan(
                        rs.getString("TenDangNhap"),
                        rs.getString("MatKhau"),
                        rs.getString("VaiTro"),
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        rs.getDate("NgayTao")
                    );
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy tài khoản:");
            e.printStackTrace();
        }
        
        return null;
    }

    // Lấy tất cả tài khoản
    public List<TaiKhoan> getAll() {
        List<TaiKhoan> list = new ArrayList<>();
        String sql = "SELECT * FROM TaiKhoan ORDER BY NgayTao DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                TaiKhoan tk = new TaiKhoan(
                    rs.getString("TenDangNhap"),
                    rs.getString("MatKhau"),
                    rs.getString("VaiTro"),
                    rs.getString("HoTen"),
                    rs.getString("Email"),
                    rs.getDate("NgayTao")
                );
                list.add(tk);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách tài khoản:");
            e.printStackTrace();
        }

        return list;
    }

    // Thêm tài khoản mới
    public boolean insertTaiKhoan(TaiKhoan taiKhoan) {
        String sql = "INSERT INTO TaiKhoan(TenDangNhap, MatKhau, VaiTro, HoTen, Email) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, taiKhoan.getTenDangNhap());
            ps.setString(2, taiKhoan.getMatKhau());
            ps.setString(3, taiKhoan.getVaiTro());
            ps.setString(4, taiKhoan.getHoTen());
            ps.setString(5, taiKhoan.getEmail());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm tài khoản:");
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật tài khoản
    public boolean updateTaiKhoan(TaiKhoan taiKhoan) {
        String sql = "UPDATE TaiKhoan SET MatKhau = ?, VaiTro = ?, HoTen = ?, Email = ? WHERE TenDangNhap = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, taiKhoan.getMatKhau());
            ps.setString(2, taiKhoan.getVaiTro());
            ps.setString(3, taiKhoan.getHoTen());
            ps.setString(4, taiKhoan.getEmail());
            ps.setString(5, taiKhoan.getTenDangNhap());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật tài khoản:");
            e.printStackTrace();
        }

        return false;
    }

    // Xóa tài khoản
    public boolean deleteTaiKhoan(String tenDangNhap) {
        String sql = "DELETE FROM TaiKhoan WHERE TenDangNhap = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tenDangNhap);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa tài khoản:");
            e.printStackTrace();
        }

        return false;
    }
}
