package controller;

import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DocGia;
import model.DocGiaDAO;

@WebServlet(name = "DocGiaServlet", urlPatterns = {"/docgia"})
public class DocGiaServlet extends HttpServlet {

    private DocGiaDAO docGiaDAO = new DocGiaDAO();

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
                listDocGia(request, response);
                break;
            case "add":
                addDocGia(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateDocGia(request, response);
                break;
            case "delete":
                deleteDocGia(request, response);
                break;
            case "search":
                searchDocGia(request, response);
                break;
            default:
                listDocGia(request, response);
                break;
        }
    }
    
    private void listDocGia(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<DocGia> list = docGiaDAO.getAll();
        request.setAttribute("docGiaList", list);
        request.getRequestDispatcher("/admin/list-docgia.jsp").forward(request, response);
    }
    
    private void addDocGia(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String hoTen = request.getParameter("HoTen");
        String ngaySinhStr = request.getParameter("NgaySinh");
        String diaChi = request.getParameter("DiaChi");
        String soDienThoai = request.getParameter("SoDienThoai");
        String email = request.getParameter("Email");
        
        Date ngaySinh = null;
        if (ngaySinhStr != null && !ngaySinhStr.trim().isEmpty()) {
            ngaySinh = Date.valueOf(ngaySinhStr);
        }
        
        DocGia docGia = new DocGia(hoTen, ngaySinh, diaChi, soDienThoai, email);
        boolean success = docGiaDAO.insertDocGia(docGia);
        
        if (success) {
            request.setAttribute("message", "Thêm độc giả thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi thêm độc giả!");
        }
        
        listDocGia(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maDocGia = Integer.parseInt(request.getParameter("maDocGia"));
        // Có thể implement method getById trong DocGiaDAO nếu cần
        request.setAttribute("editMode", true);
        request.setAttribute("editMaDocGia", maDocGia);
        listDocGia(request, response);
    }
    
    private void updateDocGia(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maDocGia = Integer.parseInt(request.getParameter("maDocGia"));
        String hoTen = request.getParameter("HoTen");
        String ngaySinhStr = request.getParameter("NgaySinh");
        String diaChi = request.getParameter("DiaChi");
        String soDienThoai = request.getParameter("SoDienThoai");
        String email = request.getParameter("Email");
        
        Date ngaySinh = null;
        if (ngaySinhStr != null && !ngaySinhStr.trim().isEmpty()) {
            ngaySinh = Date.valueOf(ngaySinhStr);
        }
        
        DocGia docGia = new DocGia(maDocGia, hoTen, ngaySinh, diaChi, soDienThoai, email);
        boolean success = docGiaDAO.updateDocGia(docGia);
        
        if (success) {
            request.setAttribute("message", "Cập nhật độc giả thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi cập nhật độc giả!");
        }
        
        listDocGia(request, response);
    }
    
    private void deleteDocGia(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maDocGia = Integer.parseInt(request.getParameter("maDocGia"));
        boolean success = docGiaDAO.deleteDocGia(maDocGia);
        
        if (success) {
            request.setAttribute("message", "Xóa độc giả thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi xóa độc giả!");
        }
        
        listDocGia(request, response);
    }
    
    private void searchDocGia(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");
        List<DocGia> list = null;
        
        switch (searchType) {
            case "ten":
                list = docGiaDAO.searchByTen(keyword);
                break;
            case "sdt":
                list = docGiaDAO.searchBySoDienThoai(keyword);
                break;
            case "email":
                list = docGiaDAO.searchByEmail(keyword);
                break;
            default:
                list = docGiaDAO.getAll();
                break;
        }
        
        request.setAttribute("docGiaList", list);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/admin/list-docgia.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
