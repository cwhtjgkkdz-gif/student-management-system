<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>注册新用户 - 学生信息管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-color: #764ba2;
            --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            padding: 20px;
        }

        .register-container {
            width: 100%;
            max-width: 520px;
            background: rgba(255, 255, 255, 0.98);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.15);
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: fadeIn 0.6s ease-out;
        }

        .register-header {
            background: var(--primary-gradient);
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .register-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1%, transparent 20%);
            animation: float 20s linear infinite;
        }

        .register-header h2 {
            position: relative;
            z-index: 1;
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .register-header p {
            position: relative;
            z-index: 1;
            opacity: 0.9;
            font-size: 0.95rem;
        }

        .register-body {
            padding: 40px;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            color: var(--primary-color);
            width: 18px;
        }

        .form-control {
            padding: 16px 20px;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            font-size: 1rem;
            transition: all 0.3s;
            background: white;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .btn-register {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 18px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.05rem;
            width: 100%;
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
            margin-top: 10px;
        }

        .btn-register::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: 0.5s;
        }

        .btn-register:hover::before {
            left: 100%;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        .login-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
            color: #64748b;
            font-size: 0.95rem;
        }

        .login-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
            padding-bottom: 2px;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary-gradient);
            transition: width 0.3s;
        }

        .login-link a:hover::after {
            width: 100%;
        }

        .alert-custom {
            border-radius: 12px;
            border: none;
            padding: 18px 20px;
            margin-bottom: 24px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            animation: slideIn 0.4s ease-out;
        }

        .password-strength {
            margin-top: 10px;
            padding: 12px 16px;
            background: #f8fafc;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
        }

        .strength-bar {
            display: flex;
            gap: 4px;
            margin-bottom: 8px;
        }

        .strength-segment {
            flex: 1;
            height: 4px;
            background: #e2e8f0;
            border-radius: 2px;
            transition: all 0.3s;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes float {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }

        @media (max-width: 576px) {
            .register-container {
                max-width: 100%;
                margin: 0 15px;
            }

            .register-header {
                padding: 30px 20px;
            }

            .register-body {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="register-header">
        <h2><i class="fas fa-user-plus me-2"></i>注册新用户</h2>
        <p class="mb-0">填写信息创建学生账户</p>
    </div>

    <div class="register-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <input type="hidden" name="action" value="register">

            <div class="row g-3">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label" for="studentNo">
                            <i class="fas fa-id-card"></i>学号
                        </label>
                        <input type="text" class="form-control"
                               id="studentNo" name="studentNo"
                               placeholder="请输入学号" required>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label" for="name">
                            <i class="fas fa-user"></i>姓名
                        </label>
                        <input type="text" class="form-control"
                               id="name" name="name"
                               placeholder="请输入姓名" required>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label" for="password">
                            <i class="fas fa-lock"></i>密码
                        </label>
                        <input type="password" class="form-control"
                               id="password" name="password"
                               placeholder="请输入密码" required>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label" for="confirmPassword">
                            <i class="fas fa-lock"></i>确认密码
                        </label>
                        <input type="password" class="form-control"
                               id="confirmPassword" name="confirmPassword"
                               placeholder="请再次输入密码" required>
                        <div class="password-match mt-2" id="passwordMatch" style="display: none;">
                            <i class="fas fa-check-circle text-success me-1"></i>
                            <small class="text-success">密码匹配</small>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label class="form-label" for="gender">
                            <i class="fas fa-venus-mars"></i>性别
                        </label>
                        <select class="form-control" id="gender" name="gender">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label class="form-label" for="age">
                            <i class="fas fa-birthday-cake"></i>年龄
                        </label>
                        <input type="number" class="form-control"
                               id="age" name="age" value="18"
                               min="1" max="100" required>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group">
                        <label class="form-label" for="phone">
                            <i class="fas fa-phone"></i>手机号
                        </label>
                        <input type="tel" class="form-control"
                               id="phone" name="phone"
                               placeholder="请输入手机号">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <button type="submit" class="btn btn-register">
                    <i class="fas fa-user-plus me-2"></i>注册账户
                </button>
            </div>
        </form>

        <div class="login-link">
            已有账户？<a href="${pageContext.request.contextPath}/login.jsp">立即登录</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function checkPasswordStrength(password) {
        let strength = 0;
        if (password.length >= 8) strength++;
        if (password.match(/[a-z]+/)) strength++;
        if (password.match(/[A-Z]+/)) strength++;
        if (password.match(/[0-9]+/)) strength++;
        if (password.match(/[$@#&!]+/)) strength++;
        return Math.min(strength, 5);
    }

    function checkPasswordMatch() {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const matchDiv = document.getElementById('passwordMatch');

        if (confirmPassword.length === 0) {
            matchDiv.style.display = 'none';
            return;
        }

        if (password === confirmPassword) {
            matchDiv.style.display = 'block';
        } else {
            matchDiv.style.display = 'none';
        }
    }

    document.getElementById('password').addEventListener('input', checkPasswordMatch);
    document.getElementById('confirmPassword').addEventListener('input', checkPasswordMatch);

    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const studentNo = document.getElementById('studentNo').value;

        if (password !== confirmPassword) {
            e.preventDefault();
            alert('密码和确认密码不一致！');
            return false;
        }

        if (password.length < 6) {
            e.preventDefault();
            alert('密码长度至少需要6位！');
            return false;
        }

        if (studentNo.length < 3) {
            e.preventDefault();
            alert('学号长度至少需要3位！');
            return false;
        }

        return true;
    });
</script>
</body>
</html>