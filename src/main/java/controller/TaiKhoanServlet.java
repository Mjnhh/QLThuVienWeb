package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.TaiKhoan;
import model.TaiKhoanDAO;

@WebServlet(name = "TaiKhoanServlet", urlPatterns = {"/taikhoan"})
public class TaiKhoanServlet extends HttpServlet {

    private TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();

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
                listTaiKhoan(request, response);
                break;
            case "add":
                addTaiKhoan(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateTaiKhoan(request, response);
                break;
            case "delete":
                deleteTaiKhoan(request, response);
                break;
            default:
                listTaiKhoan(request, response);
                break;
        }
    }
    
    private void listTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<TaiKhoan> list = taiKhoanDAO.getAll();
        request.setAttribute("taiKhoanList", list);
        request.getRequestDispatcher("/admin/list-taikhoan.jsp").forward(request, response);
    }
    
    private void addTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");
        String vaiTro = request.getParameter("vaiTro");
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        
        TaiKhoan taiKhoan = new TaiKhoan(tenDangNhap, matKhau, vaiTro, hoTen, email);
        boolean success = taiKhoanDAO.insertTaiKhoan(taiKhoan);
        
        if (success) {
            request.setAttribute("message", "Thêm tài khoản thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi thêm tài khoản!");
        }
        
        listTaiKhoan(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        TaiKhoan taiKhoan = taiKhoanDAO.getByTenDangNhap(tenDangNhap);
        if (taiKhoan != null) {
            request.setAttribute("editTaiKhoan", taiKhoan);
        }
        listTaiKhoan(request, response);
    }
    
    private void updateTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");
        String vaiTro = request.getParameter("vaiTro");
        String hoTen = request.getParameter("hoTen");
        String email = request.getParameter("email");
        
        TaiKhoan taiKhoan = new TaiKhoan(tenDangNhap, matKhau, vaiTro, hoTen, email);
        boolean success = taiKhoanDAO.updateTaiKhoan(taiKhoan);
        
        if (success) {
            request.setAttribute("message", "Cập nhật tài khoản thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật tài khoản!");
        }
        
        listTaiKhoan(request, response);
    }
    
    private void deleteTaiKhoan(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        boolean success = taiKhoanDAO.deleteTaiKhoan(tenDangNhap);
        
        if (success) {
            request.setAttribute("message", "Xóa tài khoản thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi xóa tài khoản!");
        }
        
        listTaiKhoan(request, response);
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
