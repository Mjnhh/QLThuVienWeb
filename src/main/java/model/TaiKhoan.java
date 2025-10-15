package model;

import java.sql.Date;

public class TaiKhoan {
    private String tenDangNhap;
    private String matKhau;
    private String vaiTro;
    private String hoTen;
    private String email;
    private Date ngayTao;

    public TaiKhoan() {
    }

    public TaiKhoan(String tenDangNhap, String matKhau, String vaiTro, String hoTen, String email) {
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.vaiTro = vaiTro;
        this.hoTen = hoTen;
        this.email = email;
    }

    public TaiKhoan(String tenDangNhap, String matKhau, String vaiTro, String hoTen, String email, Date ngayTao) {
        this.tenDangNhap = tenDangNhap;
        this.matKhau = matKhau;
        this.vaiTro = vaiTro;
        this.hoTen = hoTen;
        this.email = email;
        this.ngayTao = ngayTao;
    }

    // Getters & Setters
    public String getTenDangNhap() {
        return tenDangNhap;
    }

    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(String vaiTro) {
        this.vaiTro = vaiTro;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(Date ngayTao) {
        this.ngayTao = ngayTao;
    }

    @Override
    public String toString() {
        return "TaiKhoan{" + "tenDangNhap=" + tenDangNhap + ", matKhau=" + matKhau + ", vaiTro=" + vaiTro + ", hoTen=" + hoTen + ", email=" + email + ", ngayTao=" + ngayTao + '}';
    }
}
