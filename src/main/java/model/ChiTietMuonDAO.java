package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBConnection;

public class ChiTietMuonDAO {

    // Lấy chi tiết mượn theo mã phiếu
    public List<ChiTietMuon> getByMaPhieu(int maPhieu) {
        List<ChiTietMuon> list = new ArrayList<>();
        String sql = "SELECT ctm.*, s.TenSach FROM ChiTietMuon ctm " +
                    "LEFT JOIN Sach s ON ctm.MaSach = s.MaSach " +
                    "WHERE ctm.MaPhieu = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maPhieu);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ChiTietMuon ctm = new ChiTietMuon(
                        rs.getInt("MaPhieu"),
                        rs.getInt("MaSach"),
                        rs.getInt("SoLuong"),
                        rs.getString("TinhTrang")
                    );
                    ctm.setTenSach(rs.getString("TenSach"));
                    list.add(ctm);
                }
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi lấy chi tiết mượn:");
            e.printStackTrace();
        }

        return list;
    }

    // Thêm chi tiết mượn
    public boolean insertChiTietMuon(ChiTietMuon chiTietMuon) {
        String sql = "INSERT INTO ChiTietMuon(MaPhieu, MaSach, SoLuong, TinhTrang) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, chiTietMuon.getMaPhieu());
            ps.setInt(2, chiTietMuon.getMaSach());
            ps.setInt(3, chiTietMuon.getSoLuong());
            ps.setString(4, chiTietMuon.getTinhTrang());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi thêm chi tiết mượn:");
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật chi tiết mượn
    public boolean updateChiTietMuon(ChiTietMuon chiTietMuon) {
        String sql = "UPDATE ChiTietMuon SET TinhTrang = ? WHERE MaPhieu = ? AND MaSach = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, chiTietMuon.getTinhTrang());
            ps.setInt(2, chiTietMuon.getMaPhieu());
            ps.setInt(3, chiTietMuon.getMaSach());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật chi tiết mượn:");
            e.printStackTrace();
        }

        return false;
    }

    // Xóa chi tiết mượn
    public boolean deleteChiTietMuon(int maPhieu, int maSach) {
        String sql = "DELETE FROM ChiTietMuon WHERE MaPhieu = ? AND MaSach = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maPhieu);
            ps.setInt(2, maSach);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa chi tiết mượn:");
            e.printStackTrace();
        }

        return false;
    }

    // Xóa tất cả chi tiết mượn của một phiếu
    public boolean deleteAllByMaPhieu(int maPhieu) {
        String sql = "DELETE FROM ChiTietMuon WHERE MaPhieu = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maPhieu);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa chi tiết mượn:");
            e.printStackTrace();
        }

        return false;
    }
}
