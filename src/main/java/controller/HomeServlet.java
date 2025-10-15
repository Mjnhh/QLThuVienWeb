package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DocGiaDAO;
import model.SachDAO;
import model.PhieuMuonDAO;

@WebServlet(name = "HomeServlet", urlPatterns = {"/trang-chu"})
public class HomeServlet extends HttpServlet {

    private DocGiaDAO docGiaDAO = new DocGiaDAO();
    private SachDAO sachDAO = new SachDAO();
    private PhieuMuonDAO phieuMuonDAO = new PhieuMuonDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Kiểm tra vai trò user
        String vaiTro = (String) request.getSession().getAttribute("vaiTro");
        
        if (vaiTro != null && vaiTro.equals("Người dùng")) {
            // User thường -> redirect đến user dashboard
            request.getRequestDispatcher("/user-dashboard.jsp").forward(request, response);
            return;
        }
        
        // Admin và Thủ thư -> dashboard đầy đủ
        // Kiểm tra và cập nhật trạng thái quá hạn
        phieuMuonDAO.checkAndUpdateOverdue();
        
        // Lấy thống kê
        int totalDocGia = docGiaDAO.getAll().size();
        int totalSach = sachDAO.getAll().size();
        int dangMuon = phieuMuonDAO.getDangMuon();
        int quaHan = phieuMuonDAO.getQuaHan();
        
        // Set attributes
        request.setAttribute("totalDocGia", totalDocGia);
        request.setAttribute("totalSach", totalSach);
        request.setAttribute("dangMuon", dangMuon);
        request.setAttribute("quaHan", quaHan);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
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