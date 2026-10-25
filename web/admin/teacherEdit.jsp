<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 编辑教师</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      --tertiary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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

    .subject-badge {
      display: inline-block;
      background: var(--tertiary-gradient);
      color: white;
      padding: 8px 16px;
      border-radius: 10px;
      font-weight: 600;
      font-size: 0.9rem;
      box-shadow: var(--shadow-sm);
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

    .teacher-avatar {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      background: var(--primary-gradient);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2.5rem;
      margin: 0 auto 30px;
      box-shadow: var(--shadow-md);
    }

    .teacher-header {
      text-align: center;
      margin-bottom: 40px;
      padding-bottom: 30px;
      border-bottom: 1px solid #f1f5f9;
    }

    .teacher-name {
      font-size: 2rem;
      font-weight: 700;
      color: #2d3748;
      margin-bottom: 10px;
    }

    .teacher-id {
      color: #64748b;
      font-size: 1rem;
    }
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
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/student/findAll">
          <i class="fas fa-users"></i>学生管理
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/teacher/findAll">
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
          <c:when test="${empty teacher}">添加新教师</c:when>
          <c:otherwise>${param.action == 'view' ? '查看教师信息' : '编辑教师信息'}</c:otherwise>
        </c:choose>
      </span>
      <a href="${pageContext.request.contextPath}/admin/teacher/findAll"
         class="btn btn-light btn-sm" style="border-radius: 10px;">
        <i class="fas fa-arrow-left me-2"></i>返回列表
      </a>
    </div>
  </nav>

  <!-- 编辑/查看表单 -->
  <div class="form-container ${param.action == 'view' ? 'view-mode' : ''} fade-in">
    <c:if test="${param.action == 'view' and not empty teacher}">
      <div class="teacher-header">
        <div class="teacher-avatar">
          <i class="fas fa-chalkboard-teacher"></i>
        </div>
        <div class="teacher-name">${teacher.name}</div>
        <div class="teacher-id">教师ID: ${teacher.id}</div>
      </div>
    </c:if>

    <h4 class="page-title mb-4">
      <i class="fas fa-user-tie me-2"></i>
      <c:choose>
        <c:when test="${empty teacher}">添加新教师</c:when>
        <c:when test="${param.action == 'view'}">教师详细信息</c:when>
        <c:otherwise>编辑教师信息</c:otherwise>
      </c:choose>
    </h4>

    <c:choose>
      <c:when test="${param.action == 'view'}">
        <!-- 查看模式 -->
        <div class="row">
          <div class="col-lg-6">
            <div class="info-item">
              <div class="info-label">教师编号</div>
              <div class="info-value">
                <i class="fas fa-id-card"></i>${teacher.teacherNo}
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="info-item">
              <div class="info-label">姓名</div>
              <div class="info-value">
                <i class="fas fa-user"></i>${teacher.name}
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="info-item">
              <div class="info-label">性别</div>
              <div class="info-value">
                <i class="fas ${teacher.gender == '男' ? 'fa-mars' : 'fa-venus'}"></i>${teacher.gender}
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="info-item">
              <div class="info-label">授课科目</div>
              <div class="info-value">
                <span class="subject-badge">${teacher.subject}</span>
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="info-item">
              <div class="info-label">手机号</div>
              <div class="info-value">
                <i class="fas fa-phone"></i>${teacher.phone}
              </div>
            </div>
          </div>
        </div>

        <div class="d-flex justify-content-between mt-5 pt-4 border-top">
          <a href="${pageContext.request.contextPath}/admin/teacher/findAll"
             class="btn btn-secondary-custom">
            <i class="fas fa-arrow-left me-2"></i>返回列表
          </a>
          <div>
            <a href="${pageContext.request.contextPath}/admin/teacher/findById?id=${teacher.id}"
               class="btn btn-primary-custom me-2">
              <i class="fas fa-edit me-2"></i>编辑信息
            </a>
            <button class="btn btn-danger"
                    onclick="deleteTeacher(${teacher.id}, '${teacher.name}')">
              <i class="fas fa-trash me-2"></i>删除教师
            </button>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <!-- 编辑/添加模式 -->
        <form action="${pageContext.request.contextPath}/admin/teacher/${empty teacher ? 'add' : 'update'}" method="post" id="teacherForm">
          <c:if test="${not empty teacher}">
            <input type="hidden" name="id" value="${teacher.id}">
          </c:if>

          <div class="row">
            <div class="col-lg-6 mb-4">
              <label class="form-label required">教师编号</label>
              <input type="text" class="form-control" name="teacherNo" required
                     value="${teacher.teacherNo}" placeholder="请输入教师编号">
              <small class="text-muted mt-2 d-block">教师的唯一识别号码</small>
            </div>
            <div class="col-lg-6 mb-4">
              <label class="form-label required">姓名</label>
              <input type="text" class="form-control" name="name" required
                     value="${teacher.name}" placeholder="请输入姓名">
            </div>
            <div class="col-lg-6 mb-4">
              <label class="form-label">性别</label>
              <select class="form-select" name="gender">
                <option value="男" ${teacher.gender == '男' ? 'selected' : ''}>男</option>
                <option value="女" ${teacher.gender == '女' ? 'selected' : ''}>女</option>
              </select>
            </div>
            <div class="col-lg-6 mb-4">
              <label class="form-label required">授课科目</label>
              <input type="text" class="form-control" name="subject" required
                     value="${teacher.subject}" placeholder="请输入授课科目">
            </div>
            <div class="col-12 mb-4">
              <label class="form-label">手机号</label>
              <input type="tel" class="form-control" name="phone"
                     value="${teacher.phone}" placeholder="请输入手机号">
            </div>
          </div>

          <div class="d-flex justify-content-between mt-5 pt-4 border-top">
            <a href="${pageContext.request.contextPath}/admin/teacher/findAll"
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
    if (link.href.includes('/admin/teacher/')) {
      link.classList.add('active');
    } else {
      link.classList.remove('active');
    }
  });

  // 删除教师
  function deleteTeacher(id, name) {
    Swal.fire({
      title: '确定要删除吗？',
      text: `您确定要删除教师 "${name}" 吗？此操作不可恢复！`,
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#6a11cb',
      cancelButtonColor: '#6c757d',
      confirmButtonText: '确定删除',
      cancelButtonText: '取消',
      reverseButtons: true,
      background: '#ffffff',
      backdrop: 'rgba(0,0,0,0.4)'
    }).then((result) => {
      if (result.isConfirmed) {
        window.location.href = '${pageContext.request.contextPath}/admin/teacher/delete?id=' + id;
      }
    });
  }

  // 表单验证
  const form = document.getElementById('teacherForm');
  if (form) {
    form.addEventListener('submit', function(e) {
      const teacherNo = document.querySelector('input[name="teacherNo"]').value.trim();
      const name = document.querySelector('input[name="name"]').value.trim();
      const subject = document.querySelector('input[name="subject"]').value.trim();

      if (!teacherNo) {
        e.preventDefault();
        showAlert('请输入教师编号！', 'error');
        return false;
      }

      if (!name) {
        e.preventDefault();
        showAlert('请输入教师姓名！', 'error');
        return false;
      }

      if (!subject) {
        e.preventDefault();
        showAlert('请输入授课科目！', 'error');
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

  // 添加 SweetAlert2 用于更好的确认对话框
  if (!window.Swal) {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/npm/sweetalert2@11';
    document.head.appendChild(script);
  }
</script>
</body>
</html>