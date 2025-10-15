package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class SachDAO {

    // Lấy toàn bộ danh sách sách
    public List<Sach> getAll() {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM Sach ORDER BY MaSach DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Sach sach = new Sach(
                    rs.getInt("MaSach"),
                    rs.getString("TenSach"),
                    rs.getString("TacGia"),
                    rs.getInt("NamXuatBan"),
                    rs.getString("TheLoai"),
                    rs.getInt("SoLuong"),
                    rs.getString("AnhBia")
                );
                list.add(sach);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách sách:");
            e.printStackTrace();
        }

        return list;
    }

    // Thêm sách mới
    public boolean insertSach(Sach sach) {
        String sql = "INSERT INTO Sach(TenSach, TacGia, NamXuatBan, TheLoai, SoLuong, AnhBia) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, sach.getTenSach());
            ps.setString(2, sach.getTacGia());
            ps.setInt(3, sach.getNamXuatBan());
            ps.setString(4, sach.getTheLoai());
            ps.setInt(5, sach.getSoLuong());
            ps.setString(6, sach.getAnhBia());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        sach.setMaSach(generatedKeys.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm sách:");
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật thông tin sách
    public boolean updateSach(Sach sach) {
        String sql = "UPDATE Sach SET TenSach = ?, TacGia = ?, NamXuatBan = ?, TheLoai = ?, SoLuong = ?, AnhBia = ? WHERE MaSach = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, sach.getTenSach());
            ps.setString(2, sach.getTacGia());
            ps.setInt(3, sach.getNamXuatBan());
            ps.setString(4, sach.getTheLoai());
            ps.setInt(5, sach.getSoLuong());
            ps.setString(6, sach.getAnhBia());
            ps.setInt(7, sach.getMaSach());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật sách:");
            e.printStackTrace();
            return false;
        }
    }

    // Xóa sách theo mã
    public boolean deleteSach(int maSach) {
        String sql = "DELETE FROM Sach WHERE MaSach = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maSach);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa sách:");
            e.printStackTrace();
        }

        return false;
    }

    // Lấy sách theo mã
    public Sach getById(int maSach) {
        String sql = "SELECT * FROM Sach WHERE MaSach = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maSach);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Sach(
                        rs.getInt("MaSach"),
                        rs.getString("TenSach"),
                        rs.getString("TacGia"),
                        rs.getInt("NamXuatBan"),
                        rs.getString("TheLoai"),
                        rs.getInt("SoLuong"),
                        rs.getString("AnhBia")
                    );
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy sách theo mã:");
            e.printStackTrace();
        }
        
        return null;
    }

    // Tìm kiếm sách theo tên
    public List<Sach> searchByTen(String keyword) {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM Sach WHERE TenSach LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sach sach = new Sach(
                        rs.getInt("MaSach"),
                        rs.getString("TenSach"),
                        rs.getString("TacGia"),
                        rs.getInt("NamXuatBan"),
                        rs.getString("TheLoai"),
                        rs.getInt("SoLuong"),
                        rs.getString("AnhBia")
                    );
                    list.add(sach);
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sách theo tên:");
            e.printStackTrace();
        }

        return list;
    }

    // Tìm kiếm sách theo tác giả
    public List<Sach> searchByTacGia(String keyword) {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM Sach WHERE TacGia LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sach sach = new Sach(
                        rs.getInt("MaSach"),
                        rs.getString("TenSach"),
                        rs.getString("TacGia"),
                        rs.getInt("NamXuatBan"),
                        rs.getString("TheLoai"),
                        rs.getInt("SoLuong"),
                        rs.getString("AnhBia")
                    );
                    list.add(sach);
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sách theo tác giả:");
            e.printStackTrace();
        }

        return list;
    }

    // Tìm kiếm sách theo năm xuất bản
    public List<Sach> searchByNamXuatBan(int namXuatBan) {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM Sach WHERE NamXuatBan = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, namXuatBan);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sach sach = new Sach(
                        rs.getInt("MaSach"),
                        rs.getString("TenSach"),
                        rs.getString("TacGia"),
                        rs.getInt("NamXuatBan"),
                        rs.getString("TheLoai"),
                        rs.getInt("SoLuong"),
                        rs.getString("AnhBia")
                    );
                    list.add(sach);
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sách theo năm xuất bản:");
            e.printStackTrace();
        }

        return list;
    }

    // Tìm kiếm sách theo thể loại
    public List<Sach> searchByTheLoai(String keyword) {
        List<Sach> list = new ArrayList<>();
        String sql = "SELECT * FROM Sach WHERE TheLoai LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Sach sach = new Sach(
                        rs.getInt("MaSach"),
                        rs.getString("TenSach"),
                        rs.getString("TacGia"),
                        rs.getInt("NamXuatBan"),
                        rs.getString("TheLoai"),
                        rs.getInt("SoLuong"),
                        rs.getString("AnhBia")
                    );
                    list.add(sach);
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi tìm kiếm sách theo thể loại:");
            e.printStackTrace();
        }

        return list;
    }
}
