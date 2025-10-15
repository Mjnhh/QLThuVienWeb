package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.TaiKhoan;
import model.TaiKhoanDAO;

@WebServlet(name = "UserInfoServlet", urlPatterns = {"/user-info"})
public class UserInfoServlet extends HttpServlet {

    private TaiKhoanDAO taiKhoanDAO = new TaiKhoanDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String tenDangNhap = (String) request.getSession().getAttribute("tenDangNhap");
        
        if (tenDangNhap != null) {
            TaiKhoan taiKhoan = taiKhoanDAO.getByTenDangNhap(tenDangNhap);
            if (taiKhoan != null) {
                request.setAttribute("taiKhoan", taiKhoan);
            }
        }
        
        request.getRequestDispatcher("/user-info.jsp").forward(request, response);
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
        return "User Info Servlet";
    }
}
