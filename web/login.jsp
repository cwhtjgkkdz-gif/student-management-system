<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 登录</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-color: #764ba2;
      --light-purple: rgba(118, 75, 162, 0.1);
    }

    body {
      background: linear-gradient(rgba(102, 126, 234, 0.85), rgba(118, 75, 162, 0.85)),
      url("${pageContext.request.contextPath}/images/设计登录界面背景图.png");
      background-size: cover;
      background-position: center;
      background-attachment: fixed;
      min-height: 100vh;
      display: flex;
      align-items: center;
      padding: 20px 0;
    }

    .login-wrapper {
      animation: fadeIn 0.6s ease-out;
    }

    .login-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
      overflow: hidden;
      border: 1px solid rgba(255, 255, 255, 0.3);
    }

    .login-header {
      background: var(--primary-gradient);
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
      background: radial-gradient(circle, rgba(255,255,255,0.1) 1%, transparent 20%);
      animation: float 20s linear infinite;
    }

    .login-header h2 {
      position: relative;
      z-index: 1;
      font-weight: 700;
      letter-spacing: 0.5px;
    }

    .login-header p {
      position: relative;
      z-index: 1;
      opacity: 0.9;
    }

    .login-body {
      padding: 40px;
    }

    .form-label {
      font-weight: 600;
      color: #495057;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
    }

    .form-label i {
      margin-right: 8px;
      color: var(--primary-color);
    }

    .input-group {
      border-radius: 10px;
      overflow: hidden;
      border: 2px solid #e9ecef;
      transition: all 0.3s;
    }

    .input-group:focus-within {
      border-color: var(--primary-color);
      box-shadow: 0 0 0 0.25rem rgba(118, 75, 162, 0.15);
    }

    .input-group-text {
      background-color: #f8f9fa;
      border: none;
      color: var(--primary-color);
      padding: 0.75rem 1rem;
    }

    .form-control {
      border: none;
      padding: 0.75rem 1rem;
      background-color: transparent;
    }

    .form-control:focus {
      box-shadow: none;
      background-color: transparent;
    }

    .btn-login {
      background: var(--primary-gradient);
      border: none;
      color: white;
      padding: 14px;
      border-radius: 10px;
      font-weight: 600;
      font-size: 1.1rem;
      letter-spacing: 0.5px;
      transition: all 0.3s;
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
      transition: 0.5s;
    }

    .btn-login:hover::before {
      left: 100%;
    }

    .btn-login:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
    }

    .user-type-selector {
      background: #f8f9fa;
      border-radius: 12px;
      padding: 5px;
      margin-bottom: 25px;
    }

    .user-type-btn {
      flex: 1;
      padding: 15px 10px;
      border: 2px solid transparent;
      border-radius: 10px;
      cursor: pointer;
      transition: all 0.3s;
      text-align: center;
      background: white;
    }

    .user-type-btn:hover {
      transform: translateY(-1px);
      border-color: var(--primary-color);
    }

    .user-type-btn.active {
      border-color: var(--primary-color);
      background: var(--light-purple);
      box-shadow: 0 4px 12px rgba(118, 75, 162, 0.15);
    }

    .checkcode-container {
      background: #f8f9fa;
      border-radius: 8px;
      padding: 8px;
      cursor: pointer;
      transition: all 0.3s;
      border: 2px solid #e9ecef;
    }

    .checkcode-container:hover {
      border-color: var(--primary-color);
      transform: scale(1.02);
    }

    .checkcode-container img {
      border-radius: 6px;
    }

    .alert {
      border-radius: 10px;
      border: none;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .alert-success {
      background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
      border-left: 4px solid #28a745;
    }

    .alert-danger {
      background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
      border-left: 4px solid #dc3545;
    }

    .register-link {
      text-align: center;
      margin-top: 25px;
      padding-top: 20px;
      border-top: 1px solid rgba(0,0,0,0.1);
    }

    .register-link a {
      color: var(--primary-color);
      text-decoration: none;
      font-weight: 600;
      position: relative;
      padding-bottom: 2px;
    }

    .register-link a::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 0;
      height: 2px;
      background: var(--primary-gradient);
      transition: width 0.3s;
    }

    .register-link a:hover::after {
      width: 100%;
    }

    .password-toggle {
      background: transparent;
      border: none;
      color: #6c757d;
      transition: all 0.3s;
    }

    .password-toggle:hover {
      color: var(--primary-color);
      background: rgba(118, 75, 162, 0.05);
    }

    .hint-text {
      font-size: 0.85rem;
      opacity: 0.8;
      margin-top: 5px;
      display: block;
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

    @keyframes float {
      0% {
        transform: rotate(0deg);
      }
      100% {
        transform: rotate(360deg);
      }
    }

    @media (max-width: 768px) {
      .login-body {
        padding: 30px 25px;
      }
      .login-header {
        padding: 30px 20px;
      }
      .user-type-btn {
        padding: 12px 8px;
      }
    }

    @media (max-width: 576px) {
      body {
        padding: 15px;
      }
      .login-card {
        border-radius: 15px;
      }
      .login-body {
        padding: 25px 20px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center login-wrapper">
    <div class="col-md-8 col-lg-6 col-xl-5">
      <div class="login-card">
        <div class="login-header">
          <h2><i class="fas fa-graduation-cap"></i> 学生信息管理系统</h2>
          <p class="mb-0">请登录您的账户</p>
        </div>
        <div class="login-body">
          <% String message = request.getParameter("message");
            if (message != null && !message.trim().isEmpty()) { %>
          <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>
            <%= message %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
          </div>
          <% } %>

          <form id="loginForm" action="loginServlet" method="post">
            <div class="mb-4">
              <label class="form-label mb-3">选择登录身份</label>
              <div class="user-type-selector d-flex">
                <div class="user-type-btn active" data-type="student">
                  <i class="fas fa-user-graduate fa-xl mb-2"></i>
                  <div class="fw-bold">学生登录</div>
                </div>
                <div class="user-type-btn ms-2" data-type="admin">
                  <i class="fas fa-user-shield fa-xl mb-2"></i>
                  <div class="fw-bold">管理员登录</div>
                </div>
              </div>
              <input type="hidden" id="userType" name="role" value="student">
            </div>

            <div class="mb-3">
              <label for="username" class="form-label">
                <i class="fas fa-user"></i>用户名
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="fas fa-user"></i>
                </span>
                <input type="text" class="form-control" id="username" name="username"
                       placeholder="请输入学号" required>
              </div>
            </div>

            <div class="mb-4">
              <label for="password" class="form-label">
                <i class="fas fa-lock"></i>密码
              </label>
              <div class="input-group">
                <span class="input-group-text">
                  <i class="fas fa-lock"></i>
                </span>
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="请输入密码" required>
                <button class="btn password-toggle" type="button" id="togglePassword">
                  <i class="fas fa-eye"></i>
                </button>
              </div>
            </div>

            <div class="mb-4">
              <label for="checkCode" class="form-label">
                <i class="fas fa-shield-alt"></i>验证码
              </label>
              <div class="row g-3 align-items-center">
                <div class="col-7">
                  <div class="input-group">
                    <span class="input-group-text">
                      <i class="fas fa-key"></i>
                    </span>
                    <input type="text" class="form-control" id="checkCode" name="checkCode"
                           placeholder="请输入验证码" required maxlength="4">
                  </div>
                  <span class="hint-text">请输入4位验证码</span>
                </div>
                <div class="col-5">
                  <div class="checkcode-container" id="checkCodeImgContainer">
                    <div class="text-center py-2">
                      <div class="spinner-border spinner-border-sm text-primary" role="status">
                        <span class="visually-hidden">加载中...</span>
                      </div>
                    </div>
                  </div>
                  <span class="hint-text">点击刷新验证码</span>
                </div>
              </div>
            </div>

            <c:if test="${not empty error or not empty loginMsg}">
              <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>
                <c:choose>
                  <c:when test="${not empty error}">${error}</c:when>
                  <c:otherwise>${loginMsg}</c:otherwise>
                </c:choose>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
              </div>
            </c:if>

            <div class="d-grid mb-4">
              <button type="submit" class="btn btn-login">
                <i class="fas fa-sign-in-alt me-2"></i>登录系统
              </button>
            </div>

            <div class="text-center mb-3">
              <small class="text-muted">
                <i class="fas fa-info-circle me-1"></i>
                默认学生密码：123456 | 默认管理员密码：admin
              </small>
            </div>

            <div class="register-link">
              <small>
                <i class="fas fa-user-plus me-1"></i>
                还没有账户？
                <a href="${pageContext.request.contextPath}/student/register.jsp">立即注册</a>
              </small>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener('DOMContentLoaded', function() {
    const checkCodeContainer = document.getElementById('checkCodeImgContainer');

    function loadCheckCode() {
      checkCodeContainer.innerHTML = '';
      const img = document.createElement('img');
      img.src = 'CheckCodeServlet?t=' + new Date().getTime();
      img.alt = '验证码';
      img.className = 'w-100 h-100';
      img.style.objectFit = 'cover';
      checkCodeContainer.appendChild(img);
    }

    checkCodeContainer.addEventListener('click', loadCheckCode);
    loadCheckCode();

    document.querySelectorAll('.user-type-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        document.querySelectorAll('.user-type-btn').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
        document.getElementById('userType').value = this.dataset.type;
        document.getElementById('username').placeholder =
                this.dataset.type === 'student' ? '请输入学号' : '请输入用户名';
      });
    });

    document.getElementById('togglePassword').addEventListener('click', function() {
      const passwordInput = document.getElementById('password');
      const icon = this.querySelector('i');
      if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        icon.classList.replace('fa-eye', 'fa-eye-slash');
      } else {
        passwordInput.type = 'password';
        icon.classList.replace('fa-eye-slash', 'fa-eye');
      }
    });

    document.getElementById('loginForm').addEventListener('submit', function(e) {
      const checkCode = document.getElementById('checkCode').value.trim();
      if (checkCode.length !== 4) {
        e.preventDefault();
        alert('验证码必须是4位！');
        return false;
      }
      return true;
    });
  });
</script>
</body>
</html>