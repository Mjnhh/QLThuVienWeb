package filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(filterName = "SachAccessFilter", urlPatterns = {"/sach"})
public class SachAccessFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Lấy session
        HttpSession session = httpRequest.getSession(false);
        
        if (session != null && session.getAttribute("user") != null) {
            String vaiTro = (String) session.getAttribute("vaiTro");
            String action = httpRequest.getParameter("action");
            
            // User thường chỉ được xem (viewonly)
            if (vaiTro != null && vaiTro.equals("Người dùng")) {
                if (action == null || action.equals("viewonly")) {
                    // Cho phép user xem sách
                    chain.doFilter(request, response);
                    return;
                } else {
                    // User không được thực hiện các action khác
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/trang-chu");
                    return;
                }
            }
            
            // Admin và Thủ thư có toàn quyền
            if (vaiTro != null && (vaiTro.equals("Admin") || vaiTro.equals("Thủ thư"))) {
                chain.doFilter(request, response);
                return;
            }
        }
        
        // Chưa đăng nhập hoặc không có quyền
        httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
    }
    
    @Override
    public void destroy() {
        // Cleanup filter
    }
}
