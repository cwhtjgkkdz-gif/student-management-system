<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 管理员首页</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      --tertiary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
      --light-bg: #f8f9fa;
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

    .main-content {
      margin-left: var(--sidebar-width);
      padding: 25px;
      min-height: 100vh;
    }

    @media (max-width: 992px) {
      .sidebar {
        transform: translateX(-100%);
      }
      .main-content {
        margin-left: 0;
      }
    }

    .navbar {
      background: var(--primary-gradient);
      box-shadow: var(--shadow-sm);
      padding: 15px 25px;
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

    .dashboard-card {
      background: white;
      border-radius: 20px;
      padding: 30px;
      margin-bottom: 25px;
      box-shadow: var(--shadow-md);
      border: none;
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      overflow: hidden;
    }

    .dashboard-card::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 5px;
      background: var(--primary-gradient);
    }

    .dashboard-card:nth-child(2)::after { background: var(--secondary-gradient); }
    .dashboard-card:nth-child(3)::after { background: var(--tertiary-gradient); }
    .dashboard-card:nth-child(4)::after { background: var(--success-gradient); }

    .dashboard-card:hover {
      transform: translateY(-10px);
      box-shadow: var(--shadow-lg);
    }

    .stat-number {
      font-size: 3rem;
      font-weight: 800;
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      margin: 15px 0;
      display: inline-block;
      position: relative;
    }

    .dashboard-card:nth-child(2) .stat-number {
      background: var(--secondary-gradient);
      -webkit-background-clip: text;
    }

    .dashboard-card:nth-child(3) .stat-number {
      background: var(--tertiary-gradient);
      -webkit-background-clip: text;
    }

    .dashboard-card:nth-child(4) .stat-number {
      background: var(--success-gradient);
      -webkit-background-clip: text;
    }

    .stat-label {
      font-size: 1.1rem;
      color: #6c757d;
      font-weight: 500;
    }

    .stat-icon {
      font-size: 2.5rem;
      background: linear-gradient(135deg, #6a11cb20 0%, #2575fc20 100%);
      width: 70px;
      height: 70px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 15px;
      color: #6a11cb;
    }

    .dashboard-card:nth-child(2) .stat-icon {
      background: linear-gradient(135deg, #f093fb20 0%, #f5576c20 100%);
      color: #f5576c;
    }

    .dashboard-card:nth-child(3) .stat-icon {
      background: linear-gradient(135deg, #4facfe20 0%, #00f2fe20 100%);
      color: #4facfe;
    }

    .dashboard-card:nth-child(4) .stat-icon {
      background: linear-gradient(135deg, #43e97b20 0%, #38f9d720 100%);
      color: #43e97b;
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

    .btn-primary-custom::after {
      content: '';
      position: absolute;
      top: 50%;
      left: 50%;
      width: 5px;
      height: 5px;
      background: rgba(255, 255, 255, 0.5);
      opacity: 0;
      border-radius: 100%;
      transform: scale(1, 1) translate(-50%);
      transform-origin: 50% 50%;
    }

    .btn-primary-custom:hover {
      transform: translateY(-3px);
      box-shadow: var(--shadow-md);
    }

    .btn-primary-custom:hover::after {
      animation: ripple 1s ease-out;
    }

    @keyframes ripple {
      0% {
        transform: scale(0, 0);
        opacity: 0.5;
      }
      100% {
        transform: scale(40, 40);
        opacity: 0;
      }
    }

    .table-container {
      background: white;
      border-radius: 20px;
      padding: 30px;
      box-shadow: var(--shadow-md);
      transition: all 0.3s ease;
    }

    .table-container:hover {
      box-shadow: var(--shadow-lg);
    }

    .table th {
      border: none;
      font-weight: 600;
      color: #495057;
      background: rgba(106, 17, 203, 0.05);
      padding: 18px 15px;
      font-size: 0.95rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .table td {
      padding: 16px 15px;
      vertical-align: middle;
      border-bottom: 1px solid rgba(0,0,0,0.05);
    }

    .table tbody tr {
      transition: all 0.2s ease;
    }

    .table tbody tr:hover {
      background: rgba(106, 17, 203, 0.03);
      transform: translateX(5px);
    }

    .badge {
      padding: 8px 12px;
      border-radius: 8px;
      font-weight: 600;
      font-size: 0.85rem;
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

    .welcome-title {
      color: #2d3748;
      font-weight: 700;
      margin-bottom: 35px;
      padding-bottom: 20px;
      border-bottom: 2px solid rgba(106, 17, 203, 0.1);
      position: relative;
    }

    .welcome-title::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      width: 80px;
      height: 2px;
      background: var(--primary-gradient);
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
      border-radius: 10px;
      padding: 10px 15px;
      font-size: 1.2rem;
    }

    @media (max-width: 992px) {
      .hamburger-menu {
        display: block;
      }
      .sidebar.active {
        transform: translateX(0);
      }
    }

    .fade-in {
      animation: fadeIn 0.8s ease-out forwards;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .delay-1 { animation-delay: 0.1s; }
    .delay-2 { animation-delay: 0.2s; }
    .delay-3 { animation-delay: 0.3s; }
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/countServlet">
          <i class="fas fa-home"></i>首页
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/student/findAll">
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
  <nav class="navbar navbar-expand-lg navbar-dark mb-4 fade-in">
    <div class="container-fluid">
      <span class="navbar-brand fw-bold">
        <i class="fas fa-tachometer-alt me-2"></i>管理员控制面板
      </span>
    </div>
  </nav>

  <!-- 仪表板 -->
  <h3 class="welcome-title fade-in">
    <i class="fas fa-user-shield me-2"></i>欢迎回来，管理员！
  </h3>

  <div class="row">
    <div class="col-xl-3 col-lg-6 col-md-6">
      <div class="dashboard-card fade-in">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <div class="stat-icon">
            <i class="fas fa-users"></i>
          </div>
          <i class="fas fa-arrow-up text-success" style="font-size: 1.5rem;"></i>
        </div>
        <div class="stat-number" id="studentCount">${studentCount}</div>
        <div class="stat-label">学生总数</div>
      </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-md-6">
      <div class="dashboard-card fade-in delay-1">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <div class="stat-icon">
            <i class="fas fa-chalkboard-teacher"></i>
          </div>
          <i class="fas fa-chart-line text-info" style="font-size: 1.5rem;"></i>
        </div>
        <div class="stat-number" id="teacherCount">${teacherCount}</div>
        <div class="stat-label">教师总数</div>
      </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-md-6">
      <div class="dashboard-card fade-in delay-2">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <div class="stat-icon">
            <i class="fas fa-book"></i>
          </div>
          <i class="fas fa-layer-group text-primary" style="font-size: 1.5rem;"></i>
        </div>
        <div class="stat-number" id="courseCount">${courseCount}</div>
        <div class="stat-label">课程总数</div>
      </div>
    </div>
    <div class="col-xl-3 col-lg-6 col-md-6">
      <div class="dashboard-card fade-in delay-3">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <div class="stat-icon">
            <i class="fas fa-bullhorn"></i>
          </div>
          <i class="fas fa-bell text-warning" style="font-size: 1.5rem;"></i>
        </div>
        <div class="stat-number" id="noticeCount">${noticeCount}</div>
        <div class="stat-label">公告总数</div>
      </div>
    </div>
  </div>

  <!-- 快速操作 -->
  <div class="table-container mt-4 fade-in">
    <h5 class="mb-4 fw-bold">
      <i class="fas fa-bolt me-2" style="color: #f093fb;"></i>快速操作
    </h5>
    <div class="row">
      <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
        <a href="${pageContext.request.contextPath}/admin/student/findAll"
           class="btn btn-primary-custom w-100 d-flex align-items-center justify-content-center">
          <i class="fas fa-user-plus me-3"></i>
          <span>添加学生</span>
        </a>
      </div>
      <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
        <a href="${pageContext.request.contextPath}/admin/teacher/findAll"
           class="btn btn-primary-custom w-100 d-flex align-items-center justify-content-center">
          <i class="fas fa-chalkboard-teacher me-3"></i>
          <span>添加教师</span>
        </a>
      </div>
      <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
        <a href="${pageContext.request.contextPath}/admin/course/findAll"
           class="btn btn-primary-custom w-100 d-flex align-items-center justify-content-center">
          <i class="fas fa-book-medical me-3"></i>
          <span>添加课程</span>
        </a>
      </div>
      <div class="col-xl-3 col-lg-6 col-md-6 mb-3">
        <a href="${pageContext.request.contextPath}/admin/notice/findAll"
           class="btn btn-primary-custom w-100 d-flex align-items-center justify-content-center">
          <i class="fas fa-bullhorn me-3"></i>
          <span>发布公告</span>
        </a>
      </div>
    </div>
  </div>

  <!-- 最近操作 -->
  <div class="table-container mt-4 fade-in">
    <h5 class="mb-4 fw-bold">
      <i class="fas fa-history me-2" style="color: #4facfe;"></i>最近操作记录
    </h5>
    <div class="table-responsive">
      <table class="table table-hover">
        <thead>
        <tr>
          <th><i class="far fa-clock me-1"></i>时间</th>
          <th><i class="fas fa-tag me-1"></i>操作类型</th>
          <th><i class="fas fa-file-alt me-1"></i>操作内容</th>
          <th><i class="fas fa-user me-1"></i>操作人员</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td class="text-nowrap">今日 10:30</td>
          <td><span class="badge bg-primary">登录</span></td>
          <td>管理员登录系统</td>
          <td><span class="text-primary">admin</span></td>
        </tr>
        <tr>
          <td class="text-nowrap">昨日 15:42</td>
          <td><span class="badge bg-success">添加</span></td>
          <td>添加新学生：张三</td>
          <td><span class="text-success">admin</span></td>
        </tr>
        <tr>
          <td class="text-nowrap">昨日 14:20</td>
          <td><span class="badge bg-warning text-dark">更新</span></td>
          <td>更新课程信息：Java编程</td>
          <td><span class="text-warning">admin</span></td>
        </tr>
        </tbody>
      </table>
    </div>
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
    if (link.href === window.location.href) {
      link.classList.add('active');
    } else {
      link.classList.remove('active');
    }
  });

  // 数字动画效果
  function animateCounter(element) {
    const target = parseInt(element.textContent);
    const duration = 1500;
    const increment = target / (duration / 16);
    let current = 0;

    const timer = setInterval(() => {
      current += increment;
      if (current >= target) {
        element.textContent = target;
        clearInterval(timer);
      } else {
        element.textContent = Math.floor(current);
      }
    }, 16);
  }

  // 页面加载完成后执行数字动画
  document.addEventListener('DOMContentLoaded', function() {
    const counters = document.querySelectorAll('.stat-number');
    counters.forEach(counter => {
      animateCounter(counter);
    });
  });
</script>
</body>
</html>