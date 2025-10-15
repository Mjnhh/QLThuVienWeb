package model;

import java.sql.Date;

public class PhieuMuon {
    private int maPhieu;
    private int maDocGia;
    private Date ngayMuon;
    private Date ngayTra;
    private String trangThai;
    private String tenDocGia; // Thêm để hiển thị tên độc giả

    public PhieuMuon() {
    }

    public PhieuMuon(int maPhieu, int maDocGia, Date ngayMuon, Date ngayTra, String trangThai) {
        this.maPhieu = maPhieu;
        this.maDocGia = maDocGia;
        this.ngayMuon = ngayMuon;
        this.ngayTra = ngayTra;
        this.trangThai = trangThai;
    }

    public PhieuMuon(int maDocGia, Date ngayMuon, Date ngayTra, String trangThai) {
        this.maDocGia = maDocGia;
        this.ngayMuon = ngayMuon;
        this.ngayTra = ngayTra;
        this.trangThai = trangThai;
    }

    // Getters & Setters
    public int getMaPhieu() {
        return maPhieu;
    }

    public void setMaPhieu(int maPhieu) {
        this.maPhieu = maPhieu;
    }

    public int getMaDocGia() {
        return maDocGia;
    }

    public void setMaDocGia(int maDocGia) {
        this.maDocGia = maDocGia;
    }

    public Date getNgayMuon() {
        return ngayMuon;
    }

    public void setNgayMuon(Date ngayMuon) {
        this.ngayMuon = ngayMuon;
    }

    public Date getNgayTra() {
        return ngayTra;
    }

    public void setNgayTra(Date ngayTra) {
        this.ngayTra = ngayTra;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getTenDocGia() {
        return tenDocGia;
    }

    public void setTenDocGia(String tenDocGia) {
        this.tenDocGia = tenDocGia;
    }

    @Override
    public String toString() {
        return "PhieuMuon{" + "maPhieu=" + maPhieu + ", maDocGia=" + maDocGia + ", ngayMuon=" + ngayMuon + ", ngayTra=" + ngayTra + ", trangThai=" + trangThai + '}';
    }
}
