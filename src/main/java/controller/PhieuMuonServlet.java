package controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.PhieuMuon;
import model.PhieuMuonDAO;
import model.ChiTietMuon;
import model.ChiTietMuonDAO;
import model.DocGia;
import model.DocGiaDAO;
import model.Sach;
import model.SachDAO;

@WebServlet(name = "PhieuMuonServlet", urlPatterns = {"/phieumuon"})
public class PhieuMuonServlet extends HttpServlet {

    private PhieuMuonDAO phieuMuonDAO = new PhieuMuonDAO();
    private ChiTietMuonDAO chiTietMuonDAO = new ChiTietMuonDAO();
    private DocGiaDAO docGiaDAO = new DocGiaDAO();
    private SachDAO sachDAO = new SachDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "list":
                listPhieuMuon(request, response);
                break;
            case "form":
                showForm(request, response);
                break;
            case "add":
                addPhieuMuon(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updatePhieuMuon(request, response);
                break;
            case "delete":
                deletePhieuMuon(request, response);
                break;
            case "tra":
                traSach(request, response);
                break;
            default:
                listPhieuMuon(request, response);
                break;
        }
    }
    
    private void listPhieuMuon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra và cập nhật trạng thái quá hạn
        phieuMuonDAO.checkAndUpdateOverdue();
        
        List<PhieuMuon> list = phieuMuonDAO.getAll();
        request.setAttribute("phieuMuonList", list);
        request.getRequestDispatcher("/admin/list-phieumuon.jsp").forward(request, response);
    }
    
    private void showForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<DocGia> docGiaList = docGiaDAO.getAll();
        List<Sach> sachList = sachDAO.getAll();
        
        request.setAttribute("docGiaList", docGiaList);
        request.setAttribute("sachList", sachList);
        request.getRequestDispatcher("/admin/form-phieumuon.jsp").forward(request, response);
    }
    
    private void addPhieuMuon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maDocGia = Integer.parseInt(request.getParameter("maDocGia"));
        String ngayMuonStr = request.getParameter("ngayMuon");
        String ngayTraStr = request.getParameter("ngayTra");
        String[] maSachArray = request.getParameterValues("maSach");
        
        Date ngayMuon = Date.valueOf(ngayMuonStr);
        Date ngayTra = ngayTraStr != null && !ngayTraStr.trim().isEmpty() ? 
                      Date.valueOf(ngayTraStr) : null;
        
        String trangThai = ngayTra != null ? "Đã trả" : "Đang mượn";
        
        // Tạo phiếu mượn
        PhieuMuon phieuMuon = new PhieuMuon(maDocGia, ngayMuon, ngayTra, trangThai);
        boolean success = phieuMuonDAO.insertPhieuMuon(phieuMuon);
        
        if (success && maSachArray != null) {
            // Thêm chi tiết mượn
            for (String maSachStr : maSachArray) {
                int maSach = Integer.parseInt(maSachStr);
                ChiTietMuon chiTiet = new ChiTietMuon(
                    phieuMuon.getMaPhieu(), 
                    maSach, 
                    1, 
                    trangThai
                );
                chiTietMuonDAO.insertChiTietMuon(chiTiet);
            }
            request.setAttribute("message", "Thêm phiếu mượn thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi thêm phiếu mượn!");
        }
        
        listPhieuMuon(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maPhieu = Integer.parseInt(request.getParameter("maPhieu"));
        PhieuMuon phieuMuon = phieuMuonDAO.getById(maPhieu);
        List<ChiTietMuon> chiTietList = chiTietMuonDAO.getByMaPhieu(maPhieu);
        
        if (phieuMuon != null) {
            request.setAttribute("phieuMuon", phieuMuon);
            request.setAttribute("chiTietList", chiTietList);
        }
        
        request.getRequestDispatcher("/admin/edit-phieumuon.jsp").forward(request, response);
    }
    
    private void updatePhieuMuon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maPhieu = Integer.parseInt(request.getParameter("maPhieu"));
        String ngayTraStr = request.getParameter("ngayTra");
        String trangThai = request.getParameter("trangThai");
        
        PhieuMuon phieuMuon = phieuMuonDAO.getById(maPhieu);
        if (phieuMuon != null) {
            phieuMuon.setNgayTra(ngayTraStr != null && !ngayTraStr.trim().isEmpty() ? 
                                Date.valueOf(ngayTraStr) : null);
            phieuMuon.setTrangThai(trangThai);
            
            boolean success = phieuMuonDAO.updatePhieuMuon(phieuMuon);
            
            if (success) {
                // Cập nhật chi tiết mượn
                List<ChiTietMuon> chiTietList = chiTietMuonDAO.getByMaPhieu(maPhieu);
                for (ChiTietMuon chiTiet : chiTietList) {
                    chiTiet.setTinhTrang(trangThai);
                    chiTietMuonDAO.updateChiTietMuon(chiTiet);
                }
                
                request.setAttribute("message", "Cập nhật phiếu mượn thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật phiếu mượn!");
            }
        }
        
        listPhieuMuon(request, response);
    }
    
    private void deletePhieuMuon(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maPhieu = Integer.parseInt(request.getParameter("maPhieu"));
        
        // Xóa chi tiết mượn trước
        chiTietMuonDAO.deleteAllByMaPhieu(maPhieu);
        
        // Xóa phiếu mượn
        boolean success = phieuMuonDAO.deletePhieuMuon(maPhieu);
        
        if (success) {
            request.setAttribute("message", "Xóa phiếu mượn thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi xóa phiếu mượn!");
        }
        
        listPhieuMuon(request, response);
    }
    
    private void traSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maPhieu = Integer.parseInt(request.getParameter("maPhieu"));
        
        PhieuMuon phieuMuon = phieuMuonDAO.getById(maPhieu);
        if (phieuMuon != null) {
            phieuMuon.setNgayTra(Date.valueOf(LocalDate.now()));
            phieuMuon.setTrangThai("Đã trả");
            
            boolean success = phieuMuonDAO.updatePhieuMuon(phieuMuon);
            
            if (success) {
                // Cập nhật chi tiết mượn
                List<ChiTietMuon> chiTietList = chiTietMuonDAO.getByMaPhieu(maPhieu);
                for (ChiTietMuon chiTiet : chiTietList) {
                    chiTiet.setTinhTrang("Đã trả");
                    chiTietMuonDAO.updateChiTietMuon(chiTiet);
                }
                
                request.setAttribute("message", "Trả sách thành công!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi trả sách!");
            }
        }
        
        listPhieuMuon(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
