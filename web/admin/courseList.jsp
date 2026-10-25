<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 课程管理</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
      --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      --tertiary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
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
      padding: 20px 16px;
      font-size: 0.95rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 2px solid rgba(106, 17, 203, 0.1);
    }

    .table td {
      padding: 18px 16px;
      vertical-align: middle;
      border-bottom: 1px solid rgba(0,0,0,0.05);
      color: #2d3748;
      font-weight: 500;
    }

    .table tbody tr {
      transition: all 0.3s ease;
    }

    .table tbody tr:hover {
      background: rgba(106, 17, 203, 0.03);
      transform: translateX(10px);
      box-shadow: var(--shadow-sm);
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

    .btn-action {
      padding: 10px 16px;
      margin: 0 5px;
      border-radius: 10px;
      font-size: 0.875rem;
      font-weight: 500;
      transition: all 0.3s ease;
      border: none;
      box-shadow: var(--shadow-sm);
    }

    .btn-view {
      background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
      color: white;
    }

    .btn-view:hover {
      transform: translateY(-3px) scale(1.05);
      box-shadow: var(--shadow-md);
    }

    .btn-edit {
      background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
      color: white;
    }

    .btn-edit:hover {
      transform: translateY(-3px) scale(1.05);
      box-shadow: var(--shadow-md);
    }

    .btn-delete {
      background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
      color: white;
    }

    .btn-delete:hover {
      transform: translateY(-3px) scale(1.05);
      box-shadow: var(--shadow-md);
    }

    .search-box {
      position: relative;
      max-width: 400px;
      margin-right: 20px;
    }

    .search-box i {
      position: absolute;
      left: 20px;
      top: 50%;
      transform: translateY(-50%);
      color: #6c757d;
      z-index: 1;
    }

    .search-box input {
      padding-left: 50px;
      border-radius: 12px;
      border: 1px solid #e1e5eb;
      height: 50px;
      font-size: 1rem;
      transition: all 0.3s ease;
      background: white;
    }

    .search-box input:focus {
      border-color: #6a11cb;
      box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.15);
      transform: translateY(-2px);
    }

    .search-box button {
      position: absolute;
      right: 5px;
      top: 5px;
      height: 40px;
      padding: 0 20px;
      border-radius: 10px;
      background: var(--primary-gradient);
      border: none;
      color: white;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .search-box button:hover {
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

    .credit-badge {
      display: inline-block;
      background: var(--tertiary-gradient);
      color: white;
      padding: 8px 16px;
      border-radius: 10px;
      font-weight: 600;
      font-size: 0.85rem;
      box-shadow: var(--shadow-sm);
    }

    .course-code {
      font-family: 'Courier New', monospace;
      background: #f8f9fa;
      padding: 8px 12px;
      border-radius: 8px;
      font-weight: 600;
      color: #495057;
      display: inline-block;
      border: 1px solid #e1e5eb;
    }

    .teacher-info {
      display: flex;
      align-items: center;
    }

    .teacher-avatar {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      background: var(--primary-gradient);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1rem;
      margin-right: 12px;
      box-shadow: var(--shadow-sm);
    }

    .modal-content {
      border-radius: 20px;
      border: none;
      box-shadow: var(--shadow-lg);
      overflow: hidden;
    }

    .modal-header {
      background: var(--primary-gradient);
      color: white;
      padding: 25px 30px;
      border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    .form-control, .form-select, .form-textarea {
      border-radius: 12px;
      border: 1px solid #e1e5eb;
      padding: 14px 18px;
      transition: all 0.3s ease;
      font-size: 1rem;
    }

    .form-control:focus, .form-select:focus, .form-textarea:focus {
      border-color: #6a11cb;
      box-shadow: 0 0 0 0.25rem rgba(106, 17, 203, 0.15);
      transform: translateY(-2px);
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

    .course-avatar {
      width: 50px;
      height: 50px;
      border-radius: 12px;
      background: var(--primary-gradient);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      margin-right: 15px;
      box-shadow: var(--shadow-sm);
    }

    .course-info {
      display: flex;
      align-items: center;
    }

    .fade-in {
      animation: fadeIn 0.6s ease-out forwards;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .pagination {
      margin-top: 30px;
    }

    .page-link {
      border: none;
      color: #6a11cb;
      padding: 10px 18px;
      margin: 0 5px;
      border-radius: 10px;
      font-weight: 500;
      transition: all 0.3s ease;
      background: white;
      box-shadow: var(--shadow-sm);
    }

    .page-link:hover {
      background: var(--primary-gradient);
      color: white;
      transform: translateY(-3px);
      box-shadow: var(--shadow-md);
    }

    .page-item.active .page-link {
      background: var(--primary-gradient);
      border: none;
      transform: translateY(-3px);
      box-shadow: var(--shadow-md);
    }

    .page-item.disabled .page-link {
      opacity: 0.5;
      transform: none;
      box-shadow: none;
    }

    .stats-card {
      background: white;
      border-radius: 15px;
      padding: 20px;
      margin-bottom: 25px;
      box-shadow: var(--shadow-sm);
      display: flex;
      align-items: center;
      transition: all 0.3s ease;
    }

    .stats-card:hover {
      transform: translateY(-5px);
      box-shadow: var(--shadow-md);
    }

    .stats-icon {
      width: 50px;
      height: 50px;
      border-radius: 12px;
      background: var(--primary-gradient);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      margin-right: 15px;
    }

    .stats-content {
      flex-grow: 1;
    }

    .stats-number {
      font-size: 1.8rem;
      font-weight: 700;
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      line-height: 1;
    }

    .stats-label {
      color: #64748b;
      font-size: 0.9rem;
      margin-top: 5px;
    }

    .description-preview {
      color: #64748b;
      font-size: 0.9rem;
      line-height: 1.4;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .form-textarea {
      min-height: 120px;
      resize: vertical;
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
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/teacher/findAll">
          <i class="fas fa-chalkboard-teacher"></i>教师管理
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/course/findAll">
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
    <div class="container-fluid">
      <span class="navbar-brand fw-bold">
        <i class="fas fa-book me-2"></i>课程管理
      </span>
    </div>
  </nav>

  <!-- 统计卡片 -->
  <div class="row mb-4 fade-in">
    <div class="col-lg-3 col-md-6">
      <div class="stats-card">
        <div class="stats-icon">
          <i class="fas fa-book"></i>
        </div>
        <div class="stats-content">
          <div class="stats-number">${pb.totalCount}</div>
          <div class="stats-label">课程总数</div>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="stats-card">
        <div class="stats-icon" style="background: var(--secondary-gradient);">
          <i class="fas fa-star"></i>
        </div>
        <div class="stats-content">
          <div class="stats-number" style="background: var(--secondary-gradient); -webkit-background-clip: text;">
            <c:set var="totalCredit" value="0" />
            <c:forEach var="course" items="${pb.list}">
              <c:set var="totalCredit" value="${totalCredit + course.credit}" />
            </c:forEach>
            ${totalCredit}
          </div>
          <div class="stats-label">总学分</div>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="stats-card">
        <div class="stats-icon" style="background: var(--tertiary-gradient);">
          <i class="fas fa-chart-line"></i>
        </div>
        <div class="stats-content">
          <div class="stats-number" style="background: var(--tertiary-gradient); -webkit-background-clip: text;">
            <c:set var="avgCredit" value="0" />
            <c:if test="${pb.totalCount > 0}">
              <c:set var="avgCredit" value="${totalCredit / pb.totalCount}" />
              <fmt:formatNumber value="${avgCredit}" pattern="#.##" />
            </c:if>
            <c:if test="${pb.totalCount == 0}">0</c:if>
          </div>
          <div class="stats-label">平均学分</div>
        </div>
      </div>
    </div>
    <div class="col-lg-3 col-md-6">
      <div class="stats-card">
        <div class="stats-icon" style="background: var(--success-gradient);">
          <i class="fas fa-layer-group"></i>
        </div>
        <div class="stats-content">
          <div class="stats-number" style="background: var(--success-gradient); -webkit-background-clip: text;">
            ${pb.totalPage}
          </div>
          <div class="stats-label">总页数</div>
        </div>
      </div>
    </div>
  </div>

  <!-- 操作栏 -->
  <div class="d-flex justify-content-between align-items-center mb-4 fade-in">
    <h4 class="page-title m-0">
      <i class="fas fa-book-open me-2"></i>课程信息列表
    </h4>
    <div class="d-flex align-items-center">
      <div class="search-box">
        <form action="${pageContext.request.contextPath}/admin/course/findAll" method="get" class="position-relative">
          <i class="fas fa-search"></i>
          <input type="text" class="form-control" placeholder="搜索课程编号或课程名称..." name="keyword" value="${keyword}">
          <button type="submit" class="btn">搜索</button>
        </form>
      </div>
      <button class="btn btn-primary-custom" data-bs-toggle="modal" data-bs-target="#addCourseModal">
        <i class="fas fa-plus-circle me-2"></i>添加课程
      </button>
    </div>
  </div>

  <!-- 课程列表 -->
  <div class="table-container fade-in">
    <div class="table-responsive">
      <table class="table table-hover" id="courseTable">
        <thead>
        <tr>
          <th>课程信息</th>
          <th>学分</th>
          <th>授课教师</th>
          <th>课程描述</th>
          <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="course" items="${pb.list}">
          <tr>
            <td>
              <div class="course-info">
                <div class="course-avatar">
                  <i class="fas fa-book-open"></i>
                </div>
                <div>
                  <div class="fw-bold" style="color: #2d3748;">${course.name}</div>
                  <div class="text-muted small mt-1">
                    <i class="fas fa-hashtag"></i> ${course.courseNo}
                  </div>
                </div>
              </div>
            </td>
            <td>
              <span class="credit-badge">${course.credit} 学分</span>
            </td>
            <td>
              <div class="teacher-info">
                <div class="teacher-avatar">
                  <i class="fas fa-chalkboard-teacher"></i>
                </div>
                <div>
                  <div>教师 ID: ${course.teacherId}</div>
                </div>
              </div>
            </td>
            <td>
              <div class="description-preview">
                  ${course.description}
              </div>
            </td>
            <td>
              <div class="d-flex">
                <button class="btn btn-view btn-action"
                        onclick="viewCourse(${course.id})"
                        data-bs-toggle="tooltip" title="查看详情">
                  <i class="fas fa-eye"></i>
                </button>
                <button class="btn btn-edit btn-action"
                        onclick="editCourse(${course.id})"
                        data-bs-toggle="tooltip" title="编辑信息">
                  <i class="fas fa-edit"></i>
                </button>
                <button class="btn btn-delete btn-action"
                        onclick="deleteCourse(${course.id}, '${course.name}')"
                        data-bs-toggle="tooltip" title="删除课程">
                  <i class="fas fa-trash"></i>
                </button>
              </div>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>

    <!-- 分页 -->
    <nav aria-label="Page navigation" class="mt-4">
      <ul class="pagination justify-content-center">
        <li class="page-item ${pb.currentPage == 1 ? 'disabled' : ''}">
          <a class="page-link" href="${pageContext.request.contextPath}/admin/course/findAll?currentPage=${pb.currentPage - 1}&rows=${pb.rows}&keyword=${keyword}">
            <i class="fas fa-chevron-left me-1"></i>上一页
          </a>
        </li>

        <c:forEach begin="1" end="${pb.totalPage}" var="i">
          <c:if test="${i == 1 || i == pb.totalPage || (i >= pb.currentPage - 2 && i <= pb.currentPage + 2)}">
            <li class="page-item ${pb.currentPage == i ? 'active' : ''}">
              <a class="page-link" href="${pageContext.request.contextPath}/admin/course/findAll?currentPage=${i}&rows=${pb.rows}&keyword=${keyword}">${i}</a>
            </li>
          </c:if>
          <c:if test="${i == pb.currentPage - 3 && i > 1}">
            <li class="page-item disabled">
              <span class="page-link">...</span>
            </li>
          </c:if>
        </c:forEach>

        <li class="page-item ${pb.currentPage == pb.totalPage ? 'disabled' : ''}">
          <a class="page-link" href="${pageContext.request.contextPath}/admin/course/findAll?currentPage=${pb.currentPage + 1}&rows=${pb.rows}&keyword=${keyword}">
            下一页<i class="fas fa-chevron-right ms-1"></i>
          </a>
        </li>
      </ul>
    </nav>
  </div>
</div>

<!-- 添加课程模态框 -->
<div class="modal fade" id="addCourseModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title fw-bold">
          <i class="fas fa-plus-circle me-2"></i>添加新课程
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <form action="${pageContext.request.contextPath}/admin/course/add" method="post" id="addForm">
        <div class="modal-body">
          <div class="row">
            <div class="col-md-6 mb-4">
              <label class="form-label">课程编号 *</label>
              <input type="text" class="form-control" name="courseNo" required
                     placeholder="请输入课程编号">
            </div>
            <div class="col-md-6 mb-4">
              <label class="form-label">课程名称 *</label>
              <input type="text" class="form-control" name="name" required
                     placeholder="请输入课程名称">
            </div>
            <div class="col-md-6 mb-4">
              <label class="form-label">学分 *</label>
              <input type="number" class="form-control" name="credit" required
                     min="1" max="10" placeholder="请输入学分">
            </div>
            <div class="col-md-6 mb-4">
              <label class="form-label">授课教师ID</label>
              <input type="number" class="form-control" name="teacherId"
                     placeholder="请输入教师ID">
            </div>
            <div class="col-12 mb-4">
              <label class="form-label">课程描述</label>
              <textarea class="form-control form-textarea" name="description"
                        placeholder="请输入课程描述"></textarea>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary-custom" data-bs-dismiss="modal">
            取消
          </button>
          <button type="submit" class="btn btn-primary-custom">
            <i class="fas fa-save me-2"></i>保存课程
          </button>
        </div>
      </form>
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

  // 查看课程详情
  function viewCourse(id) {
    window.location.href = '${pageContext.request.contextPath}/admin/course/findById?id=' + id + '&action=view';
  }

  // 编辑课程
  function editCourse(id) {
    window.location.href = '${pageContext.request.contextPath}/admin/course/findById?id=' + id + '&action=edit';
  }

  // 删除课程
  function deleteCourse(id, name) {
    Swal.fire({
      title: '确定要删除吗？',
      text: `您确定要删除课程 "${name}" 吗？此操作不可恢复！`,
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
        window.location.href = '${pageContext.request.contextPath}/admin/course/delete?id=' + id;
      }
    });
  }

  // 侧边栏激活状态
  document.querySelectorAll('.nav-link').forEach(link => {
    if (link.href.includes('/admin/course/')) {
      link.classList.add('active');
    } else {
      link.classList.remove('active');
    }
  });

  // 初始化工具提示
  const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
  const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
  });

  // 模态框表单验证
  const addForm = document.getElementById('addForm');
  if (addForm) {
    addForm.addEventListener('submit', function(e) {
      const credit = document.querySelector('input[name="credit"]').value;
      const courseNo = document.querySelector('input[name="courseNo"]').value.trim();
      const name = document.querySelector('input[name="name"]').value.trim();

      if (!courseNo) {
        e.preventDefault();
        alert('请输入课程编号！');
        return false;
      }

      if (!name) {
        e.preventDefault();
        alert('请输入课程名称！');
        return false;
      }

      if (credit < 1 || credit > 10) {
        e.preventDefault();
        alert('学分必须在1-10之间！');
        return false;
      }

      return true;
    });
  }

  // 实时搜索建议
  const searchInput = document.querySelector('input[name="keyword"]');
  if (searchInput) {
    let debounceTimer;
    searchInput.addEventListener('input', function() {
      clearTimeout(debounceTimer);
      debounceTimer = setTimeout(() => {
        // 可以在这里添加AJAX搜索建议
      }, 300);
    });
  }

  // 表格行点击效果
  document.querySelectorAll('#courseTable tbody tr').forEach(row => {
    row.addEventListener('click', function(e) {
      if (!e.target.closest('button')) {
        const id = this.getAttribute('data-id') ||
                this.querySelector('button').onclick.toString().match(/\d+/)[0];
        viewCourse(id);
      }
    });
  });

  // 添加 SweetAlert2 用于更好的确认对话框
  if (!window.Swal) {
    const script = document.createElement('script');
    script.src = 'https://cdn.jsdelivr.net/npm/sweetalert2@11';
    document.head.appendChild(script);
  }
</script>
</body>
</html>