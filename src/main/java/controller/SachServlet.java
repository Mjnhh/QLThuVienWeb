package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Sach;
import model.SachDAO;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(name = "SachServlet", urlPatterns = {"/sach"})
public class SachServlet extends HttpServlet {

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
                listSach(request, response);
                break;
            case "add":
                addSach(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "update":
                updateSach(request, response);
                break;
            case "delete":
                deleteSach(request, response);
                break;
            case "search":
                searchSach(request, response);
                break;
            case "viewonly":
                viewOnlySach(request, response);
                break;
            default:
                listSach(request, response);
                break;
        }
    }
    
    private void listSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Sach> list = sachDAO.getAll();
        request.setAttribute("sachList", list);
        request.getRequestDispatcher("/admin/list-sach.jsp").forward(request, response);
    }

    private void addSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Tạo thư mục upload nếu chưa có
            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Xử lý multipart request
            if (ServletFileUpload.isMultipartContent(request)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);
                
                String tenSach = "";
                String tacGia = "";
                int namXuatBan = 0;
                String theLoai = "";
                int soLuong = 1;
                String anhBia = "";
                
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        // Xử lý form field
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString("UTF-8");
                        
                        switch (fieldName) {
                            case "TenSach":
                                tenSach = fieldValue;
                                break;
                            case "TacGia":
                                tacGia = fieldValue;
                                break;
                            case "NamXuatBan":
                                if (!fieldValue.isEmpty()) {
                                    namXuatBan = Integer.parseInt(fieldValue);
                                }
                                break;
                            case "TheLoai":
                                theLoai = fieldValue;
                                break;
                            case "SoLuong":
                                if (!fieldValue.isEmpty()) {
                                    soLuong = Integer.parseInt(fieldValue);
                                }
                                break;
                        }
                    } else {
                        // Xử lý file upload
                        if (item.getSize() > 0) {
                            String fileName = System.currentTimeMillis() + "_" + item.getName();
                            File uploadedFile = new File(uploadPath, fileName);
                            item.write(uploadedFile);
                            anhBia = "uploads/" + fileName;
                        }
                    }
                }
                
                Sach sach = new Sach(tenSach, tacGia, namXuatBan, theLoai, soLuong, anhBia);
                boolean success = sachDAO.insertSach(sach);
                
                if (success) {
                    request.setAttribute("message", "Thêm sách thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi thêm sách!");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra khi upload file: " + e.getMessage());
            e.printStackTrace();
        }
        
        listSach(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maSach = Integer.parseInt(request.getParameter("maSach"));
        Sach sach = sachDAO.getById(maSach);
        if (sach != null) {
            request.setAttribute("editSach", sach);
        }
        listSach(request, response);
    }
    
    private void updateSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Tạo thư mục upload nếu chưa có
            String uploadPath = getServletContext().getRealPath("/") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Xử lý multipart request
            if (ServletFileUpload.isMultipartContent(request)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);
                
                int maSach = 0;
                String tenSach = "";
                String tacGia = "";
                int namXuatBan = 0;
                String theLoai = "";
                int soLuong = 1;
                String anhBia = "";
                
                // Lấy thông tin sách hiện tại
                for (FileItem item : items) {
                    if (item.isFormField() && item.getFieldName().equals("maSach")) {
                        maSach = Integer.parseInt(item.getString("UTF-8"));
                        break;
                    }
                }
                
                Sach currentSach = sachDAO.getById(maSach);
                if (currentSach != null) {
                    anhBia = currentSach.getAnhBia(); // Giữ ảnh cũ nếu không upload mới
                }
                
                for (FileItem item : items) {
                    if (item.isFormField()) {
                        // Xử lý form field
                        String fieldName = item.getFieldName();
                        String fieldValue = item.getString("UTF-8");
                        
                        switch (fieldName) {
                            case "maSach":
                                maSach = Integer.parseInt(fieldValue);
                                break;
                            case "TenSach":
                                tenSach = fieldValue;
                                break;
                            case "TacGia":
                                tacGia = fieldValue;
                                break;
                            case "NamXuatBan":
                                if (!fieldValue.isEmpty()) {
                                    namXuatBan = Integer.parseInt(fieldValue);
                                }
                                break;
                            case "TheLoai":
                                theLoai = fieldValue;
                                break;
                            case "SoLuong":
                                if (!fieldValue.isEmpty()) {
                                    soLuong = Integer.parseInt(fieldValue);
                                }
                                break;
                        }
                    } else {
                        // Xử lý file upload
                        if (item.getSize() > 0) {
                            String fileName = System.currentTimeMillis() + "_" + item.getName();
                            File uploadedFile = new File(uploadPath, fileName);
                            item.write(uploadedFile);
                            anhBia = "uploads/" + fileName;
                        }
                    }
                }
                
                Sach sach = new Sach(maSach, tenSach, tacGia, namXuatBan, theLoai, soLuong, anhBia);
                boolean success = sachDAO.updateSach(sach);
                
                if (success) {
                    request.setAttribute("message", "Cập nhật sách thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi cập nhật sách!");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "Có lỗi xảy ra khi upload file: " + e.getMessage());
            e.printStackTrace();
        }
        
        listSach(request, response);
    }
    
    private void deleteSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int maSach = Integer.parseInt(request.getParameter("maSach"));
        boolean success = sachDAO.deleteSach(maSach);
        
        if (success) {
            request.setAttribute("message", "Xóa sách thành công!");
        } else {
            request.setAttribute("error", "Có lỗi xảy ra khi xóa sách!");
        }
        
        listSach(request, response);
    }
    
    private void searchSach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");
        List<Sach> list = null;
        
        switch (searchType) {
            case "ten":
                list = sachDAO.searchByTen(keyword);
                break;
            case "tacgia":
                list = sachDAO.searchByTacGia(keyword);
                break;
            case "nam":
                try {
                    int nam = Integer.parseInt(keyword);
                    list = sachDAO.searchByNamXuatBan(nam);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Năm xuất bản phải là số!");
                    list = sachDAO.getAll();
                }
                break;
            default:
                list = sachDAO.getAll();
                break;
        }
        
        request.setAttribute("sachList", list);
        request.setAttribute("searchType", searchType);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/admin/list-sach.jsp").forward(request, response);
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

    private void viewOnlySach(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchType = request.getParameter("searchType");
        String keyword = request.getParameter("keyword");
        List<Sach> sachList = null;

        if (keyword != null && !keyword.trim().isEmpty()) {
            switch (searchType) {
                case "ten":
                    sachList = sachDAO.searchByTen(keyword);
                    break;
                case "tacgia":
                    sachList = sachDAO.searchByTacGia(keyword);
                    break;
                case "theloai":
                    sachList = sachDAO.searchByTheLoai(keyword);
                    break;
                default:
                    sachList = sachDAO.getAll();
                    break;
            }
            request.setAttribute("searchType", searchType);
            request.setAttribute("searchKeyword", keyword);
        } else {
            sachList = sachDAO.getAll();
        }
        
        request.setAttribute("sachList", sachList);
        request.getRequestDispatcher("/user-view-sach.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}