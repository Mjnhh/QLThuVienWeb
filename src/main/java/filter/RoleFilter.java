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

@WebFilter(filterName = "RoleFilter", urlPatterns = {"/taikhoan", "/admin/*"})
public class RoleFilter implements Filter {
    
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
            
            // Chỉ Admin và Thủ thư mới được truy cập các trang quản trị
            if (vaiTro != null && (vaiTro.equals("Admin") || vaiTro.equals("Thủ thư"))) {
                chain.doFilter(request, response);
            } else {
                // User thường không có quyền, redirect về trang chủ
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/trang-chu");
                return;
            }
        } else {
            // Chưa đăng nhập, redirect về login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup filter
    }
}
