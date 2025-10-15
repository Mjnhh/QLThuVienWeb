package model;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class PhieuMuonDAO {

    // Lấy toàn bộ danh sách phiếu mượn với tên độc giả
    public List<PhieuMuon> getAll() {
        List<PhieuMuon> list = new ArrayList<>();
        String sql = "SELECT pm.*, dg.HoTen as TenDocGia FROM PhieuMuon pm " +
                    "LEFT JOIN DocGia dg ON pm.MaDocGia = dg.MaDocGia " +
                    "ORDER BY pm.MaPhieu DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                PhieuMuon pm = new PhieuMuon(
                    rs.getInt("MaPhieu"),
                    rs.getInt("MaDocGia"),
                    rs.getDate("NgayMuon"),
                    rs.getDate("NgayTra"),
                    rs.getString("TrangThai")
                );
                pm.setTenDocGia(rs.getString("TenDocGia"));
                list.add(pm);
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy danh sách phiếu mượn:");
            e.printStackTrace();
        }

        return list;
    }

    // Thêm phiếu mượn mới
    public boolean insertPhieuMuon(PhieuMuon phieuMuon) {
        String sql = "INSERT INTO PhieuMuon(MaDocGia, NgayMuon, NgayTra, TrangThai) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, phieuMuon.getMaDocGia());
            ps.setDate(2, phieuMuon.getNgayMuon());
            ps.setDate(3, phieuMuon.getNgayTra());
            ps.setString(4, phieuMuon.getTrangThai());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        phieuMuon.setMaPhieu(generatedKeys.getInt(1));
                    }
                }
                return true;
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm phiếu mượn:");
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật phiếu mượn
    public boolean updatePhieuMuon(PhieuMuon phieuMuon) {
        String sql = "UPDATE PhieuMuon SET NgayTra = ?, TrangThai = ? WHERE MaPhieu = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, phieuMuon.getNgayTra());
            ps.setString(2, phieuMuon.getTrangThai());
            ps.setInt(3, phieuMuon.getMaPhieu());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật phiếu mượn:");
            e.printStackTrace();
            return false;
        }
    }

    // Lấy phiếu mượn theo mã
    public PhieuMuon getById(int maPhieu) {
        String sql = "SELECT pm.*, dg.HoTen as TenDocGia FROM PhieuMuon pm " +
                    "LEFT JOIN DocGia dg ON pm.MaDocGia = dg.MaDocGia " +
                    "WHERE pm.MaPhieu = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, maPhieu);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    PhieuMuon pm = new PhieuMuon(
                        rs.getInt("MaPhieu"),
                        rs.getInt("MaDocGia"),
                        rs.getDate("NgayMuon"),
                        rs.getDate("NgayTra"),
                        rs.getString("TrangThai")
                    );
                    pm.setTenDocGia(rs.getString("TenDocGia"));
                    return pm;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy phiếu mượn theo mã:");
            e.printStackTrace();
        }
        
        return null;
    }

    // Kiểm tra và cập nhật trạng thái quá hạn
    public void checkAndUpdateOverdue() {
        String sql = "UPDATE PhieuMuon SET TrangThai = N'Quá hạn' " +
                    "WHERE TrangThai = N'Đang mượn' AND NgayTra < ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setDate(1, Date.valueOf(LocalDate.now()));
            int updated = ps.executeUpdate();
            
            if (updated > 0) {
                System.out.println("Đã cập nhật " + updated + " phiếu mượn quá hạn");
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi kiểm tra phiếu mượn quá hạn:");
            e.printStackTrace();
        }
    }

    // Lấy thống kê
    public int getTotalPhieuMuon() {
        String sql = "SELECT COUNT(*) FROM PhieuMuon";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getDangMuon() {
        String sql = "SELECT COUNT(*) FROM PhieuMuon WHERE TrangThai = N'Đang mượn'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getQuaHan() {
        String sql = "SELECT COUNT(*) FROM PhieuMuon WHERE TrangThai = N'Quá hạn'";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Xóa phiếu mượn
    public boolean deletePhieuMuon(int maPhieu) {
        String sql = "DELETE FROM PhieuMuon WHERE MaPhieu = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, maPhieu);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa phiếu mượn:");
            e.printStackTrace();
        }

        return false;
    }
}
