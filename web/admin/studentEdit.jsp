<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生信息管理系统 - 编辑学生</title>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --sidebar-width: 250px;
            --shadow-sm: 0 2px 10px rgba(0,0,0,0.08);
            --shadow-md: 0 5px 20px rgba(0,0,0,0.12);
            --shadow-lg: 0 10px 30px rgba(0,0,0,0.15);
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4edf5 100%);
            font-family: 'Segoe UI', 'Microsoft YaHei', sans-serif;
            min-height: 100vh;
        }

        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            background: white;
            box-shadow: var(--shadow-md);
            z-index: 1000;
            padding-top: 20px;
            transition: all 0.3s ease;
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-100%);
            }
            .main-content {
                margin-left: 0;
            }
            .hamburger-menu {
                display: block;
            }
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 25px;
            min-height: 100vh;
        }

        .navbar {
            background: var(--primary-gradient);
            box-shadow: var(--shadow-sm);
            padding: 15px 25px;
            margin-bottom: 25px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .navbar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.1) 50%, transparent 70%);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        .nav-link {
            color: #5d6778;
            padding: 12px 20px;
            margin: 8px 15px;
            border-radius: 10px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 4px;
            background: var(--primary-gradient);
            transform: scaleY(0);
            transition: transform 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            background: rgba(106, 17, 203, 0.08);
            color: #6a11cb;
            transform: translateX(5px);
        }

        .nav-link.active::before {
            transform: scaleY(1);
        }

        .nav-link i {
            width: 20px;
            margin-right: 12px;
            color: #6a11cb;
        }

        .form-container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: var(--primary-gradient);
        }

        .form-container:hover {
            box-shadow: var(--shadow-lg);
            transform: translateY(-5px);
        }

        .btn-primary-custom {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 14px 25px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
        }

        .btn-primary-custom:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .btn-secondary-custom {
            background: #6c757d;
            border: none;
            color: white;
            padding: 14px 25px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .btn-secondary-custom:hover {
            background: #5a6268;
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .form-control, .form-select {
            border-radius: 12px;
            border: 1px solid #e1e5eb;
            padding: 14px 18px;
            transition: all 0.3s ease;
            font-size: 1rem;
            background: white;
        }

        .form-control:focus, .form-select:focus {
            border-color: #6a11cb;
            box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.15);
            transform: translateY(-2px);
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 10px;
            font-size: 0.95rem;
            display: block;
        }

        .required:after {
            content: " *";
            color: #f5576c;
            font-weight: bold;
        }

        /* 查看模式样式 */
        .view-mode .form-control,
        .view-mode .form-select {
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            color: #2d3748;
            font-weight: 500;
        }

        .view-mode .form-control:focus,
        .view-mode .form-select:focus {
            background-color: #f8fafc;
            box-shadow: none;
            transform: none;
        }

        .info-item {
            margin-bottom: 24px;
            padding-bottom: 20px;
            border-bottom: 1px solid #f1f5f9;
            transition: all 0.3s ease;
        }

        .info-item:hover {
            border-bottom-color: #6a11cb;
        }

        .info-label {
            font-weight: 600;
            color: #64748b;
            margin-bottom: 8px;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            color: #2d3748;
            font-size: 1.2rem;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .info-value i {
            margin-right: 10px;
            color: #6a11cb;
        }

        .logo {
            font-weight: 800;
            font-size: 1.8rem;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-left: 20px;
            margin-bottom: 40px;
            padding: 10px 0;
        }

        .logo i {
            margin-right: 12px;
        }

        .user-info {
            padding: 20px;
            background: rgba(106, 17, 203, 0.03);
            margin: 20px 15px;
            border-radius: 15px;
            border: 1px solid rgba(106, 17, 203, 0.1);
        }

        .page-title {
            color: #2d3748;
            font-weight: 700;
            margin-bottom: 35px;
            padding-bottom: 20px;
            border-bottom: 2px solid rgba(106, 17, 203, 0.1);
            position: relative;
            font-size: 1.8rem;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 80px;
            height: 2px;
            background: var(--primary-gradient);
        }

        .page-title i {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-right: 12px;
        }

        .hamburger-menu {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1001;
            background: var(--primary-gradient);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 12px 18px;
            font-size: 1.3rem;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
        }

        .hamburger-menu:hover {
            transform: rotate(90deg);
        }

        .password-strength {
            height: 4px;
            background: #e2e8f0;
            border-radius: 2px;
            margin-top: 8px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            border-radius: 2px;
            transition: all 0.3s ease;
        }

        .password-match {
            font-size: 0.875rem;
            margin-top: 5px;
            font-weight: 500;
        }

        .password-match.valid {
            color: #43e97b;
        }

        .password-match.invalid {
            color: #f5576c;
        }

        .btn-danger {
            background: var(--secondary-gradient);
            border: none;
            padding: 14px 25px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-md);
        }

        .fade-in {
            animation: fadeIn 0.6s ease-out forwards;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.2s; }
    </style>
</head>
<body>
<!-- 移动端菜单按钮 -->
<button class="hamburger-menu" id="menuToggle">
    <i class="fas fa-bars"></i>
</button>

<!-- 侧边栏 -->
<div class="sidebar d-flex flex-column" id="sidebar">
    <div class="logo">
        <i class="fas fa-graduation-cap"></i>学生管理系统
    </div>

    <div class="flex-grow-1">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/countServlet">
                    <i class="fas fa-home"></i>首页
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/student/findAll">
                    <i class="fas fa-users"></i>学生管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/teacher/findAll">
                    <i class="fas fa-chalkboard-teacher"></i>教师管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/course/findAll">
                    <i class="fas fa-book"></i>课程管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/notice/findAll">
                    <i class="fas fa-bullhorn"></i>公告管理
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/selectCourse/findAll">
                    <i class="fas fa-tasks"></i>选课管理
                </a>
            </li>
        </ul>
    </div>

    <div class="user-info">
        <div class="d-flex align-items-center">
            <div class="flex-grow-1">
                <div class="fw-bold" style="color: #2d3748;">管理员</div>
                <small class="text-muted">${admin.username}</small>
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
    <nav class="navbar navbar-expand-lg navbar-dark fade-in">
        <div class="container-fluid d-flex justify-content-between align-items-center">
            <span class="navbar-brand fw-bold">
                <i class="fas fa-user-edit me-2"></i>
                <c:choose>
                    <c:when test="${empty student}">添加新学生</c:when>
                    <c:otherwise>${param.action == 'view' ? '查看学生信息' : '编辑学生信息'}</c:otherwise>
                </c:choose>
            </span>
            <a href="${pageContext.request.contextPath}/admin/student/findAll"
               class="btn btn-light btn-sm" style="border-radius: 10px;">
                <i class="fas fa-arrow-left me-2"></i>返回列表
            </a>
        </div>
    </nav>

    <!-- 编辑/查看表单 -->
    <div class="form-container ${param.action == 'view' ? 'view-mode' : ''} fade-in">
        <h4 class="page-title mb-4">
            <i class="fas fa-user-graduate me-2"></i>
            <c:choose>
                <c:when test="${empty student}">添加新学生</c:when>
                <c:when test="${param.action == 'view'}">查看学生信息</c:when>
                <c:otherwise>编辑学生信息</c:otherwise>
            </c:choose>
        </h4>

        <c:choose>
            <c:when test="${param.action == 'view'}">
                <!-- 查看模式 -->
                <div class="row">
                    <div class="col-lg-6">
                        <div class="info-item">
                            <div class="info-label">学号</div>
                            <div class="info-value">
                                <i class="fas fa-id-card"></i>${student.studentNo}
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="info-item">
                            <div class="info-label">姓名</div>
                            <div class="info-value">
                                <i class="fas fa-user"></i>${student.name}
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="info-item">
                            <div class="info-label">性别</div>
                            <div class="info-value">
                                <i class="fas ${student.gender == '男' ? 'fa-mars' : 'fa-venus'}"></i>${student.gender}
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="info-item">
                            <div class="info-label">年龄</div>
                            <div class="info-value">
                                <i class="fas fa-birthday-cake"></i>${student.age}岁
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="info-item">
                            <div class="info-label">手机号</div>
                            <div class="info-value">
                                <i class="fas fa-phone"></i>${student.phone}
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="info-item">
                            <div class="info-label">学生ID</div>
                            <div class="info-value">
                                <i class="fas fa-fingerprint"></i>${student.id}
                            </div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-5 pt-4 border-top">
                    <a href="${pageContext.request.contextPath}/admin/student/findAll"
                       class="btn btn-secondary-custom">
                        <i class="fas fa-arrow-left me-2"></i>返回列表
                    </a>
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/student/findById?id=${student.id}"
                           class="btn btn-primary-custom me-2">
                            <i class="fas fa-edit me-2"></i>编辑信息
                        </a>
                        <button class="btn btn-danger"
                                onclick="deleteStudent(${student.id}, '${student.name}')">
                            <i class="fas fa-trash me-2"></i>删除学生
                        </button>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 编辑/添加模式 -->
                <form action="${pageContext.request.contextPath}/admin/student/${empty student ? 'add' : 'update'}" method="post" id="studentForm">
                    <c:if test="${not empty student}">
                        <input type="hidden" name="id" value="${student.id}">
                    </c:if>

                    <div class="row">
                        <div class="col-lg-6 mb-4">
                            <label class="form-label required">学号</label>
                            <input type="text" class="form-control" name="studentNo" required
                                   value="${student.studentNo}" placeholder="请输入学号">
                            <small class="text-muted mt-2 d-block">学生的唯一识别号码</small>
                        </div>
                        <div class="col-lg-6 mb-4">
                            <label class="form-label required">姓名</label>
                            <input type="text" class="form-control" name="name" required
                                   value="${student.name}" placeholder="请输入姓名">
                        </div>
                        <div class="col-lg-6 mb-4">
                            <label class="form-label required">密码</label>
                            <input type="password" class="form-control" name="password" id="password" required
                                   value="${student.password}" placeholder="请输入密码">
                            <div class="password-strength mt-2">
                                <div class="password-strength-bar" id="passwordStrengthBar"></div>
                            </div>
                        </div>
                        <div class="col-lg-6 mb-4">
                            <label class="form-label required">确认密码</label>
                            <input type="password" class="form-control" id="confirmPassword" required
                                   value="${student.password}" placeholder="请确认密码">
                            <div class="password-match" id="passwordMatch"></div>
                        </div>
                        <div class="col-lg-6 mb-4">
                            <label class="form-label">性别</label>
                            <select class="form-select" name="gender">
                                <option value="男" ${student.gender == '男' ? 'selected' : ''}>男</option>
                                <option value="女" ${student.gender == '女' ? 'selected' : ''}>女</option>
                            </select>
                        </div>
                        <div class="col-lg-6 mb-4">
                            <label class="form-label">年龄</label>
                            <input type="number" class="form-control" name="age"
                                   value="${student.age}" min="1" max="60" placeholder="请输入年龄">
                        </div>
                        <div class="col-12 mb-4">
                            <label class="form-label">手机号</label>
                            <input type="tel" class="form-control" name="phone"
                                   value="${student.phone}" placeholder="请输入手机号">
                        </div>
                    </div>

                    <div class="d-flex justify-content-between mt-5 pt-4 border-top">
                        <a href="${pageContext.request.contextPath}/admin/student/findAll"
                           class="btn btn-secondary-custom">
                            <i class="fas fa-times me-2"></i>取消
                        </a>
                        <button type="submit" class="btn btn-primary-custom">
                            <i class="fas fa-save me-2"></i>保存信息
                        </button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 移动端菜单切换
    document.getElementById('menuToggle').addEventListener('click', function() {
        document.getElementById('sidebar').classList.toggle('active');
    });

    // 点击外部关闭侧边栏
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const menuToggle = document.getElementById('menuToggle');

        if (window.innerWidth <= 992 &&
            !sidebar.contains(event.target) &&
            !menuToggle.contains(event.target) &&
            sidebar.classList.contains('active')) {
            sidebar.classList.remove('active');
        }
    });

    // 侧边栏激活状态
    document.querySelectorAll('.nav-link').forEach(link => {
        if (link.href.includes('/admin/student/')) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });

    // 删除学生
    function deleteStudent(id, name) {
        if (confirm(`确定要删除学生"${name}"吗？此操作不可恢复！`)) {
            window.location.href = '${pageContext.request.contextPath}/admin/student/delete?id=' + id;
        }
    }

    // 密码强度检测
    const passwordInput = document.getElementById('password');
    const passwordStrengthBar = document.getElementById('passwordStrengthBar');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const passwordMatch = document.getElementById('passwordMatch');

    if (passwordInput) {
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            let strength = 0;

            if (password.length >= 6) strength += 25;
            if (/[a-z]/.test(password)) strength += 25;
            if (/[A-Z]/.test(password)) strength += 25;
            if (/[0-9]/.test(password)) strength += 25;

            passwordStrengthBar.style.width = strength + '%';

            if (strength < 50) {
                passwordStrengthBar.style.background = '#f5576c';
            } else if (strength < 75) {
                passwordStrengthBar.style.background = '#fee140';
            } else {
                passwordStrengthBar.style.background = '#43e97b';
            }

            checkPasswordMatch();
        });
    }

    if (confirmPasswordInput) {
        confirmPasswordInput.addEventListener('input', checkPasswordMatch);
    }

    function checkPasswordMatch() {
        if (passwordInput && confirmPasswordInput) {
            const password = passwordInput.value;
            const confirmPassword = confirmPasswordInput.value;

            if (confirmPassword === '') {
                passwordMatch.textContent = '';
                passwordMatch.className = 'password-match';
            } else if (password === confirmPassword) {
                passwordMatch.textContent = '✓ 密码匹配';
                passwordMatch.className = 'password-match valid';
            } else {
                passwordMatch.textContent = '✗ 密码不匹配';
                passwordMatch.className = 'password-match invalid';
            }
        }
    }

    // 表单验证
    const form = document.getElementById('studentForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            const password = document.querySelector('input[name="password"]')?.value;
            const confirmPassword = document.querySelector('#confirmPassword')?.value;
            const studentNo = document.querySelector('input[name="studentNo"]')?.value.trim();
            const name = document.querySelector('input[name="name"]')?.value.trim();

            if (studentNo && !studentNo) {
                e.preventDefault();
                showAlert('请输入学号！', 'error');
                return false;
            }

            if (name && !name) {
                e.preventDefault();
                showAlert('请输入学生姓名！', 'error');
                return false;
            }

            if (password && confirmPassword && password !== confirmPassword) {
                e.preventDefault();
                showAlert('两次输入的密码不一致！', 'error');
                return false;
            }

            if (password && password.length < 6) {
                e.preventDefault();
                showAlert('密码长度不能少于6位！', 'error');
                return false;
            }

            return true;
        });
    }

    function showAlert(message, type) {
        const alertDiv = document.createElement('div');
        alertDiv.className = `alert alert-${type == 'error' ? 'danger' : 'success'} alert-dismissible fade show position-fixed`;
        alertDiv.style.cssText = `
            top: 20px;
            right: 20px;
            z-index: 9999;
            min-width: 300px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        `;
        alertDiv.innerHTML = `
            <strong>${type == 'error' ? '错误' : '成功'}</strong> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        document.body.appendChild(alertDiv);
        setTimeout(() => alertDiv.remove(), 5000);
    }
</script>
</body>
</html>