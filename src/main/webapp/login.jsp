<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Hệ thống Quản lý Thư viện</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            padding: 20px 0;
        }

        /* Animated background */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/><circle cx="10" cy="60" r="0.5" fill="white" opacity="0.1"/><circle cx="90" cy="40" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            animation: float 20s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(1deg); }
        }

        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            box-shadow: 
                0 25px 50px rgba(0, 0, 0, 0.15),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            overflow: hidden;
            max-width: 450px;
            width: 90%;
            position: relative;
            z-index: 10;
            animation: slideUp 0.8s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .login-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .login-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 4s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 0.5; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }

        .login-header h2 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
            z-index: 2;
        }

        .login-header p {
            font-size: 1rem;
            opacity: 0.9;
            position: relative;
            z-index: 2;
        }

        .login-body {
            padding: 40px 30px;
        }

        .form-floating {
            margin-bottom: 20px;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            padding: 15px 20px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
            transform: translateY(-2px);
        }

        .form-floating > label {
            color: #6c757d;
            font-weight: 500;
        }

        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 15px;
            padding: 15px 30px;
            color: white;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .btn-login:hover::before {
            left: 100%;
        }

        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-login:active {
            transform: translateY(-1px);
        }

        .demo-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 15px;
            padding: 25px;
            margin-top: 30px;
            border: 1px solid rgba(102, 126, 234, 0.1);
        }

        .demo-section h6 {
            color: #495057;
            margin-bottom: 20px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .demo-account {
            background: white;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 12px;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .demo-account:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.15);
        }

        .demo-account:last-child {
            margin-bottom: 0;
        }

        .demo-account strong {
            color: #667eea;
            font-size: 1rem;
        }

        .demo-account small {
            color: #6c757d;
            font-size: 0.85rem;
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 25px;
            animation: slideDown 0.5s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .footer {
            position: absolute;
            bottom: 20px;
            right: 20px;
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            z-index: 5;
        }

        /* Responsive */
        @media (max-width: 576px) {
            body {
                align-items: flex-start;
                padding: 10px 0;
            }
            
            .login-container {
                margin: 10px;
                width: calc(100% - 20px);
                max-width: none;
            }
            
            .login-header {
                padding: 25px 20px;
            }
            
            .login-body {
                padding: 25px 20px;
            }
            
            .login-header h2 {
                font-size: 1.5rem;
            }
            
            .demo-section {
                padding: 20px;
            }
        }
        
        @media (max-height: 600px) {
            body {
                align-items: flex-start;
                padding: 10px 0;
            }
            
            .login-container {
                margin: 10px;
            }
        }

        /* Loading animation */
        .loading {
            display: none;
        }

        .btn-login.loading {
            pointer-events: none;
        }

        .btn-login.loading .loading {
            display: inline-block;
        }

        .btn-login.loading .btn-text {
            display: none;
        }

        .spinner {
            width: 20px;
            height: 20px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h2><i class="bi bi-book"></i> Thư viện Online</h2>
            <p>Đăng nhập để tiếp tục</p>
        </div>
        
        <div class="login-body">
            <!-- Hiển thị lỗi -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <form action="login" method="post" id="loginForm">
                <input type="hidden" name="action" value="login" />
                
                <div class="form-floating">
                    <input type="text" name="tenDangNhap" class="form-control" id="username" placeholder="Tên đăng nhập" required>
                    <label for="username"><i class="bi bi-person me-2"></i>Tên đăng nhập</label>
                </div>
                
                <div class="form-floating">
                    <input type="password" name="matKhau" class="form-control" id="password" placeholder="Mật khẩu" required>
                    <label for="password"><i class="bi bi-lock me-2"></i>Mật khẩu</label>
                </div>
                
                <button type="submit" class="btn btn-login" id="loginBtn">
                    <span class="btn-text">
                        <i class="bi bi-box-arrow-in-right me-2"></i> Đăng nhập
                    </span>
                    <span class="loading">
                        <div class="spinner"></div>
                    </span>
                </button>
            </form>
            
            <!-- Demo accounts -->
            <div class="demo-section">
                <h6>
                    <i class="bi bi-info-circle"></i> 
                    Tài khoản demo
                </h6>
                <div class="demo-account" onclick="fillCredentials('admin', 'admin123')">
                    <strong>Admin:</strong> admin / admin123<br>
                    <small>Quyền: Quản trị viên</small>
                </div>
                <div class="demo-account" onclick="fillCredentials('thuthu', 'thuthu123')">
                    <strong>Thủ thư:</strong> thuthu / thuthu123<br>
                    <small>Quyền: Thủ thư</small>
                </div>
                <div class="demo-account" onclick="fillCredentials('user', 'user123')">
                    <strong>Người dùng:</strong> user / user123<br>
                    <small>Quyền: Người dùng</small>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        © 2025 Hệ thống Quản lý Thư viện | JSP / Servlet
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto fill demo account credentials
        function fillCredentials(username, password) {
            document.getElementById('username').value = username;
            document.getElementById('password').value = password;
            
            // Add visual feedback
            const accounts = document.querySelectorAll('.demo-account');
            accounts.forEach(account => {
                account.style.transform = 'translateX(0)';
                account.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.05)';
            });
            
            // Highlight selected account
            event.currentTarget.style.transform = 'translateX(10px)';
            event.currentTarget.style.boxShadow = '0 8px 25px rgba(102, 126, 234, 0.3)';
            
            // Focus on password field
            document.getElementById('password').focus();
        }

        // Form submission with loading animation
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const btn = document.getElementById('loginBtn');
            btn.classList.add('loading');
            
            // Simulate loading for better UX
            setTimeout(() => {
                if (btn.classList.contains('loading')) {
                    btn.classList.remove('loading');
                }
            }, 3000);
        });

        // Add floating label animation
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.classList.remove('focused');
                }
            });
        });

        // Add enter key support
        document.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.getElementById('loginForm').submit();
            }
        });

        // Auto focus on username field
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('username').focus();
        });
    </script>
</body>
</html>