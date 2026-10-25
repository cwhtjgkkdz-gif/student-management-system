<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户设置 - 学生信息管理系统</title>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --primary-color: #764ba2;
            --danger-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --sidebar-width: 240px;
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        }

        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: white;
            box-shadow: 3px 0 20px rgba(0,0,0,0.06);
            z-index: 1000;
            padding: 25px 0;
            display: flex;
            flex-direction: column;
            border-right: 1px solid #f0f0f0;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
            min-height: 100vh;
        }

        .navbar-main {
            background: white;
            backdrop-filter: blur(10px);
            box-shadow: 0 4px 20px rgba(0,0,0,0.04);
            padding: 18px 30px;
            border-radius: 16px;
            margin-bottom: 30px;
            border: 1px solid rgba(255,255,255,0.8);
        }

        .nav-link {
            color: #4a5568;
            padding: 14px 20px;
            margin: 4px 12px;
            border-radius: 12px;
            transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
        }

        .nav-link:hover {
            background: rgba(102, 126, 234, 0.08);
            color: var(--primary-color);
            transform: translateX(4px);
        }

        .nav-link.active {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            color: var(--primary-color);
            border-left: 4px solid var(--primary-color);
        }

        .nav-link i {
            width: 22px;
            margin-right: 12px;
            font-size: 1.1rem;
        }

        .logo-area {
            padding: 0 25px 25px;
            border-bottom: 1px solid #f0f0f0;
            margin-bottom: 25px;
        }

        .logo {
            font-weight: 700;
            font-size: 1.5rem;
            color: var(--primary-color);
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .logo-icon {
            width: 36px;
            height: 36px;
            background: var(--primary-gradient);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }

        .user-area {
            padding: 20px;
            margin-top: auto;
            border-top: 1px solid #f0f0f0;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: var(--primary-gradient);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            margin-right: 12px;
        }

        .settings-grid {
            display: grid;
            grid-template-columns: 1fr 1.5fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        .settings-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.06);
            border: 1px solid #f0f0f0;
            padding: 30px;
            height: 100%;
        }

        .card-header-custom {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 25px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f1f5f9;
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

        .form-control-custom {
            padding: 14px 20px;
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            font-size: 1rem;
            transition: all 0.3s;
            background: white;
            width: 100%;
        }

        .form-control-custom:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            outline: none;
        }

        .btn-primary-custom {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 14px 28px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
            color: white;
        }

        .btn-danger-custom {
            background: var(--danger-gradient);
            border: none;
            color: white;
            padding: 14px 28px;
            border-radius: 12px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s;
        }

        .btn-danger-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 87, 108, 0.3);
            color: white;
        }

        .alert-custom {
            border-radius: 12px;
            padding: 18px 20px;
            margin-bottom: 25px;
            border: none;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .info-grid {
            display: flex;
            flex-direction: column;
            gap: 12px;
            margin-top: 20px;
        }

        .info-item {
            display: flex;
            align-items: center;
            padding: 16px;
            background: #f8fafc;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            transition: all 0.3s;
        }

        .info-item:hover {
            background: white;
            border-color: rgba(102, 126, 234, 0.3);
            transform: translateX(4px);
        }

        .info-icon {
            width: 40px;
            height: 40px;
            background: var(--primary-gradient);
            color: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
            flex-shrink: 0;
        }

        .info-content {
            flex-grow: 1;
        }

        .info-label {
            color: #64748b;
            font-size: 0.85rem;
            margin-bottom: 3px;
        }

        .info-value {
            font-weight: 600;
            color: #2d3748;
        }

        .password-input-group {
            position: relative;
            margin-bottom: 20px;
        }

        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #94a3b8;
            cursor: pointer;
            font-size: 1.1rem;
            transition: color 0.3s;
        }

        .password-toggle:hover {
            color: var(--primary-color);
        }

        .password-strength {
            padding: 15px;
            background: #f8fafc;
            border-radius: 12px;
            margin-top: 15px;
            border: 1px solid #e2e8f0;
        }

        .strength-bar {
            display: flex;
            gap: 5px;
            margin-bottom: 8px;
        }

        .strength-segment {
            flex: 1;
            height: 6px;
            background: #e2e8f0;
            border-radius: 3px;
            transition: all 0.3s;
        }

        .password-match {
            padding: 12px 16px;
            background: #f8fafc;
            border-radius: 12px;
            margin-top: 15px;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .danger-zone {
            padding: 25px;
            background: linear-gradient(135deg, rgba(254, 242, 242, 0.5) 0%, rgba(254, 242, 242, 0.8) 100%);
            border-radius: 16px;
            border: 1px solid #fecaca;
            margin-top: 25px;
        }

        .security-tips {
            padding: 20px;
            background: #f0f9ff;
            border-radius: 12px;
            border-left: 4px solid #3b82f6;
            margin-top: 25px;
        }

        .time-display {
            display: flex;
            gap: 20px;
        }

        .time-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: white;
            font-size: 0.95rem;
        }

        @media (max-width: 1200px) {
            .settings-grid {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 992px) {
            .sidebar {
                width: 220px;
                transform: translateX(-100%);
                transition: transform 0.3s;
            }
            .sidebar.active {
                transform: translateX(0);
            }
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .settings-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .settings-card {
                padding: 25px 20px;
            }
            .card-header-custom {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            .time-display {
                flex-direction: column;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<!-- 侧边栏 -->
<div class="sidebar">
    <div class="logo-area">
        <div class="logo">
            <div class="logo-icon">
                <i class="fas fa-graduation-cap"></i>
            </div>
            学生系统
        </div>
    </div>
    <div class="flex-grow-1">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/student/countServlet">
                    <i class="fas fa-home"></i>首页
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/student/selectCourse/findAllCourses">
                    <i class="fas fa-book"></i>课程中心
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/student/selectCourse/findMyCourses">
                    <i class="fas fa-list-check"></i>我的课程
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/student/notice/findAll">
                    <i class="fas fa-bullhorn"></i>系统公告
                </a>
            </li>
        </ul>
    </div>
    <div class="user-area">
        <div class="d-flex align-items-center">
            <div class="user-avatar">
                <i class="fas fa-user"></i>
            </div>
            <div class="flex-grow-1">
                <div class="fw-bold text-dark">${student.name}</div>
                <small class="text-muted">学号: ${student.studentNo}</small>
            </div>
            <a href="${pageContext.request.contextPath}/logoutServlet" class="btn btn-sm btn-outline-danger">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </div>
</div>

<!-- 主内容区域 -->
<div class="main-content">
    <!-- 顶部导航栏 -->
    <nav class="navbar-main">
        <div class="container-fluid">
            <div class="d-flex align-items-center justify-content-between w-100">
                <div>
                    <h4 class="mb-0 fw-bold text-dark">
                        <i class="fas fa-user-cog me-2 text-primary"></i>用户设置
                    </h4>
                    <small class="text-muted">管理您的账户信息和安全设置</small>
                </div>
                <div class="time-display">
                    <div class="time-item">
                        <i class="fas fa-calendar-alt"></i>
                        <span id="currentDate"></span>
                    </div>
                    <div class="time-item">
                        <i class="fas fa-clock"></i>
                        <span id="currentTime"></span>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <!-- 操作提示 -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-custom alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="settings-grid">
        <!-- 用户信息卡片 -->
        <div class="settings-card">
            <div class="card-header-custom">
                <div>
                    <h5 class="mb-0 fw-bold">
                        <i class="fas fa-user me-2 text-primary"></i>个人信息
                    </h5>
                    <small class="text-muted">您的个人资料</small>
                </div>
                <div class="avatar-circle" style="width: 70px; height: 70px; background: var(--primary-gradient); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 2rem;">
                    <i class="fas fa-user"></i>
                </div>
            </div>

            <div class="info-grid">
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-id-card"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">学号</div>
                        <div class="info-value">${student.studentNo}</div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">姓名</div>
                        <div class="info-value">${student.name}</div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-venus-mars"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">性别</div>
                        <div class="info-value">${student.gender}</div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-birthday-cake"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">年龄</div>
                        <div class="info-value">${student.age}岁</div>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="info-content">
                        <div class="info-label">手机号码</div>
                        <div class="info-value">${student.phone}</div>
                    </div>
                </div>
            </div>

            <div class="mt-4 pt-3 border-top">
                <div class="d-flex align-items-center text-muted">
                    <i class="fas fa-info-circle me-2"></i>
                    <small>账户创建时间: 2025年12月</small>
                </div>
            </div>
        </div>

        <!-- 修改密码卡片 -->
        <div class="settings-card">
            <div class="card-header-custom">
                <div>
                    <h5 class="mb-0 fw-bold">
                        <i class="fas fa-key me-2 text-success"></i>修改密码
                    </h5>
                    <small class="text-muted">定期更改密码以确保账户安全</small>
                </div>
                <div class="badge bg-success bg-opacity-10 text-success px-3 py-2">
                    <i class="fas fa-shield-alt me-1"></i>安全
                </div>
            </div>

            <form id="changePasswordForm" action="${pageContext.request.contextPath}/student/settings" method="post">
                <input type="hidden" name="action" value="changePassword">

                <div class="password-input-group">
                    <label class="form-label">
                        <i class="fas fa-lock text-muted"></i>当前密码
                    </label>
                    <div class="position-relative">
                        <input type="password" class="form-control-custom"
                               id="oldPassword" name="oldPassword"
                               placeholder="请输入当前密码" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('oldPassword', this)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="password-input-group">
                    <label class="form-label">
                        <i class="fas fa-lock text-muted"></i>新密码
                    </label>
                    <div class="position-relative">
                        <input type="password" class="form-control-custom"
                               id="newPassword" name="newPassword"
                               placeholder="请输入6-20位新密码" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('newPassword', this)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-strength mt-3">
                        <div class="strength-bar">
                            <div class="strength-segment" data-strength="1"></div>
                            <div class="strength-segment" data-strength="2"></div>
                            <div class="strength-segment" data-strength="3"></div>
                            <div class="strength-segment" data-strength="4"></div>
                        </div>
                        <small class="text-muted d-block mt-2">密码强度: <span id="strengthText">弱</span></small>
                    </div>
                </div>

                <div class="password-input-group">
                    <label class="form-label">
                        <i class="fas fa-lock text-muted"></i>确认新密码
                    </label>
                    <div class="position-relative">
                        <input type="password" class="form-control-custom"
                               id="confirmPassword" name="confirmPassword"
                               placeholder="请再次输入新密码" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword', this)">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                    <div class="password-match mt-3">
                        <i class="fas fa-check-circle text-success" id="matchIcon" style="display: none;"></i>
                        <small id="matchText" class="text-muted">两次输入的密码需保持一致</small>
                    </div>
                </div>

                <div class="d-flex gap-2 mt-4">
                    <button type="submit" class="btn-primary-custom flex-grow-1">
                        <i class="fas fa-save me-2"></i>更新密码
                    </button>
                    <button type="reset" class="btn btn-outline-secondary px-4">
                        <i class="fas fa-redo"></i>
                    </button>
                </div>
            </form>
        </div>

        <!-- 账户安全卡片 -->
        <div class="settings-card">
            <div class="text-center mb-4">
                <div class="mx-auto mb-3" style="width: 70px; height: 70px; background: var(--danger-gradient); border-radius: 16px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.8rem;">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <h5 class="fw-bold mb-2">账户安全</h5>
                <p class="text-muted">保护您的账户安全</p>
            </div>

            <div class="security-tips">
                <h6 class="mb-3 text-primary">
                    <i class="fas fa-lightbulb me-2"></i>安全建议
                </h6>
                <ul class="list-unstyled mb-0">
                    <li class="mb-2">
                        <i class="fas fa-check-circle text-success me-2"></i>
                        <small>定期更改密码</small>
                    </li>
                    <li class="mb-2">
                        <i class="fas fa-check-circle text-success me-2"></i>
                        <small>不要与他人共享密码</small>
                    </li>
                    <li class="mb-2">
                        <i class="fas fa-check-circle text-success me-2"></i>
                        <small>使用复杂密码组合</small>
                    </li>
                    <li>
                        <i class="fas fa-check-circle text-success me-2"></i>
                        <small>及时关注账户动态</small>
                    </li>
                </ul>
            </div>

            <div class="danger-zone">
                <div class="d-flex align-items-center mb-3">
                    <div class="me-3" style="width: 40px; height: 40px; background: #fef2f2; border-radius: 10px; display: flex; align-items: center; justify-content: center; color: #dc2626;">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div>
                        <h6 class="mb-0 text-danger fw-bold">注销账户</h6>
                        <small class="text-muted">永久删除账户</small>
                    </div>
                </div>

                <p class="text-muted mb-3 small">
                    此操作将永久删除您的账户和所有数据，包括课程信息、成绩记录等。
                </p>

                <button type="button" class="btn btn-outline-danger w-100" data-bs-toggle="modal" data-bs-target="#deactivateModal">
                    <i class="fas fa-trash-alt me-2"></i>注销账户
                </button>
            </div>
        </div>
    </div>
</div>

<!-- 注销账户确认模态框 -->
<div class="modal fade" id="deactivateModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle me-2"></i>确认注销账户
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="deactivateForm" action="${pageContext.request.contextPath}/student/settings" method="post">
                <input type="hidden" name="action" value="deactivate">
                <div class="modal-body">
                    <div class="alert alert-danger mb-3">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        <strong>警告：</strong>此操作将永久删除您的账户和所有相关数据！
                    </div>
                    <p class="text-muted mb-3">
                        请输入您的密码以确认注销操作：
                    </p>
                    <div class="mb-3">
                        <label for="confirmPasswordModal" class="form-label">密码确认</label>
                        <input type="password" class="form-control-custom"
                               id="confirmPasswordModal" name="password" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>取消
                    </button>
                    <button type="submit" class="btn-danger-custom">
                        <i class="fas fa-trash-alt me-1"></i>确认注销
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function updateDateTime() {
        const now = new Date();
        const options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' };
        document.getElementById('currentDate').textContent = now.toLocaleDateString('zh-CN', options);
        const timeStr = now.toLocaleTimeString('zh-CN', { hour12: false });
        document.getElementById('currentTime').textContent = timeStr;
    }
    updateDateTime();
    setInterval(updateDateTime, 1000);

    function checkPasswordStrength(password) {
        let strength = 0;
        if (password.length >= 6) strength++;
        if (password.match(/[a-z]+/)) strength++;
        if (password.match(/[A-Z]+/)) strength++;
        if (password.match(/[0-9]+/)) strength++;
        if (password.match(/[$@#&!]+/)) strength++;
        return Math.min(strength, 4);
    }

    function updatePasswordStrength(password) {
        const strength = checkPasswordStrength(password);
        const segments = document.querySelectorAll('.strength-segment');
        const strengthText = document.getElementById('strengthText');

        segments.forEach((segment, index) => {
            if (index < strength) {
                segment.style.background = getStrengthColor(strength);
            } else {
                segment.style.background = '#e2e8f0';
            }
        });

        const strengthLabels = ['弱', '中', '强', '非常强'];
        strengthText.textContent = strengthLabels[strength - 1] || '弱';
        strengthText.style.color = getStrengthColor(strength);
    }

    function getStrengthColor(strength) {
        switch(strength) {
            case 1: return '#ef4444';
            case 2: return '#f59e0b';
            case 3: return '#10b981';
            case 4: return '#10b981';
            default: return '#6b7280';
        }
    }

    function togglePassword(inputId, button) {
        const input = document.getElementById(inputId);
        const icon = button.querySelector('i');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    function checkPasswordMatch() {
        const password = document.getElementById('newPassword').value;
        const confirm = document.getElementById('confirmPassword').value;
        const matchIcon = document.getElementById('matchIcon');
        const matchText = document.getElementById('matchText');

        if (confirm.length === 0) {
            matchIcon.style.display = 'none';
            matchText.textContent = '两次输入的密码需保持一致';
            matchText.className = 'text-muted';
            return;
        }

        if (password === confirm) {
            matchIcon.style.display = 'inline-block';
            matchIcon.className = 'fas fa-check-circle text-success';
            matchText.textContent = '密码匹配';
            matchText.className = 'text-success';
        } else {
            matchIcon.style.display = 'inline-block';
            matchIcon.className = 'fas fa-times-circle text-danger';
            matchText.textContent = '密码不匹配';
            matchText.className = 'text-danger';
        }
    }

    document.getElementById('newPassword').addEventListener('input', function(e) {
        updatePasswordStrength(e.target.value);
        checkPasswordMatch();
    });

    document.getElementById('confirmPassword').addEventListener('input', checkPasswordMatch);

    document.getElementById('changePasswordForm').addEventListener('submit', function(e) {
        const oldPassword = document.getElementById('oldPassword').value;
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (!oldPassword || !newPassword || !confirmPassword) {
            e.preventDefault();
            alert('请填写所有密码字段！');
            return false;
        }

        if (newPassword !== confirmPassword) {
            e.preventDefault();
            alert('新密码和确认密码不一致！');
            return false;
        }

        if (newPassword.length < 6) {
            e.preventDefault();
            alert('密码长度至少需要6位！');
            return false;
        }

        if (oldPassword === newPassword) {
            e.preventDefault();
            alert('新密码不能与旧密码相同！');
            return false;
        }
    });

    document.getElementById('deactivateForm').addEventListener('submit', function(e) {
        if (!confirm('您确定要注销账户吗？此操作不可撤销！')) {
            e.preventDefault();
            return false;
        }
    });
</script>
</body>
</html>