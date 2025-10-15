package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.TaiKhoan;
import model.TaiKhoanDAO;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "show";
        }
        
        switch (action) {
            case "show":
                showLoginForm(request, response);
                break;
            case "login":
                doLogin(request, response);
                break;
            case "logout":
                doLogout(request, response);
                break;
            default:
                showLoginForm(request, response);
                break;
        }
    }
    
    private void showLoginForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra nếu đã đăng nhập thì redirect về trang chủ
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("trang-chu");
            return;
        }
        
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
    
    private void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tenDangNhap = request.getParameter("tenDangNhap");
        String matKhau = request.getParameter("matKhau");
        
        if (tenDangNhap == null || matKhau == null || tenDangNhap.trim().isEmpty() || matKhau.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        TaiKhoan taiKhoan = taiKhoanDAO.checkLogin(tenDangNhap, matKhau);
        
        if (taiKhoan != null) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("user", taiKhoan);
            session.setAttribute("tenDangNhap", taiKhoan.getTenDangNhap());
            session.setAttribute("vaiTro", taiKhoan.getVaiTro());
            session.setAttribute("hoTen", taiKhoan.getHoTen());
            
            // Redirect về trang chủ
            response.sendRedirect("trang-chu");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    private void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login");
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
