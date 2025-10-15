package model;

public class ChiTietMuon {
    private int maPhieu;
    private int maSach;
    private int soLuong;
    private String tinhTrang;
    private String tenSach; // Thêm để hiển thị tên sách

    public ChiTietMuon() {
    }

    public ChiTietMuon(int maPhieu, int maSach, int soLuong, String tinhTrang) {
        this.maPhieu = maPhieu;
        this.maSach = maSach;
        this.soLuong = soLuong;
        this.tinhTrang = tinhTrang;
    }

    // Getters & Setters
    public int getMaPhieu() {
        return maPhieu;
    }

    public void setMaPhieu(int maPhieu) {
        this.maPhieu = maPhieu;
    }

    public int getMaSach() {
        return maSach;
    }

    public void setMaSach(int maSach) {
        this.maSach = maSach;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getTinhTrang() {
        return tinhTrang;
    }

    public void setTinhTrang(String tinhTrang) {
        this.tinhTrang = tinhTrang;
    }

    public String getTenSach() {
        return tenSach;
    }

    public void setTenSach(String tenSach) {
        this.tenSach = tenSach;
    }

    @Override
    public String toString() {
        return "ChiTietMuon{" + "maPhieu=" + maPhieu + ", maSach=" + maSach + ", soLuong=" + soLuong + ", tinhTrang=" + tinhTrang + '}';
    }
}
