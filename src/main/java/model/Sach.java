package model;

public class Sach {
    private int maSach;
    private String tenSach;
    private String tacGia;
    private int namXuatBan;
    private String theLoai;
    private int soLuong;
    private String anhBia;

    public Sach() {
    }

    public Sach(int maSach, String tenSach, String tacGia, int namXuatBan, String theLoai, int soLuong, String anhBia) {
        this.maSach = maSach;
        this.tenSach = tenSach;
        this.tacGia = tacGia;
        this.namXuatBan = namXuatBan;
        this.theLoai = theLoai;
        this.soLuong = soLuong;
        this.anhBia = anhBia;
    }

    public Sach(String tenSach, String tacGia, int namXuatBan, String theLoai, int soLuong, String anhBia) {
        this.tenSach = tenSach;
        this.tacGia = tacGia;
        this.namXuatBan = namXuatBan;
        this.theLoai = theLoai;
        this.soLuong = soLuong;
        this.anhBia = anhBia;
    }

    // Getters & Setters
    public int getMaSach() {
        return maSach;
    }

    public void setMaSach(int maSach) {
        this.maSach = maSach;
    }

    public String getTenSach() {
        return tenSach;
    }

    public void setTenSach(String tenSach) {
        this.tenSach = tenSach;
    }

    public String getTacGia() {
        return tacGia;
    }

    public void setTacGia(String tacGia) {
        this.tacGia = tacGia;
    }

    public int getNamXuatBan() {
        return namXuatBan;
    }

    public void setNamXuatBan(int namXuatBan) {
        this.namXuatBan = namXuatBan;
    }

    public String getTheLoai() {
        return theLoai;
    }

    public void setTheLoai(String theLoai) {
        this.theLoai = theLoai;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getAnhBia() {
        return anhBia;
    }

    public void setAnhBia(String anhBia) {
        this.anhBia = anhBia;
    }

    @Override
    public String toString() {
        return "Sach{" + "maSach=" + maSach + ", tenSach=" + tenSach + ", tacGia=" + tacGia + ", namXuatBan=" + namXuatBan + ", theLoai=" + theLoai + ", soLuong=" + soLuong + ", anhBia=" + anhBia + '}';
    }
}
