<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 课程中心</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-color: #764ba2;
      --light-purple: rgba(118, 75, 162, 0.08);
      --sidebar-width: 240px;
    }

    body {
      background: linear-gradient(135deg, #f5f7fb 0%, #e4edf5 100%);
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
      background: var(--light-purple);
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

    .course-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      gap: 25px;
      margin-bottom: 30px;
    }

    .course-card {
      background: white;
      border-radius: 18px;
      overflow: hidden;
      box-shadow: 0 6px 20px rgba(0,0,0,0.06);
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      border: 1px solid #f0f0f0;
      height: 100%;
      display: flex;
      flex-direction: column;
    }

    .course-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 15px 35px rgba(0,0,0,0.1);
      border-color: rgba(102, 126, 234, 0.2);
    }

    .course-header {
      padding: 25px;
      color: white;
      position: relative;
      min-height: 140px;
      background: var(--primary-gradient);
    }

    .course-code {
      position: absolute;
      top: 20px;
      right: 20px;
      background: rgba(255,255,255,0.2);
      backdrop-filter: blur(10px);
      padding: 6px 14px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
      letter-spacing: 0.3px;
    }

    .course-credits {
      position: absolute;
      bottom: 20px;
      right: 20px;
      background: white;
      color: var(--primary-color);
      width: 48px;
      height: 48px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      font-size: 1.3rem;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }

    .course-title {
      font-weight: 700;
      color: white;
      margin-bottom: 10px;
      font-size: 1.3rem;
      line-height: 1.4;
      padding-right: 80px;
    }

    .course-description {
      color: rgba(255,255,255,0.85);
      font-size: 0.92rem;
      line-height: 1.5;
      margin-bottom: 15px;
      max-height: 72px;
      overflow: hidden;
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
    }

    .course-body {
      padding: 25px;
      flex-grow: 1;
      display: flex;
      flex-direction: column;
    }

    .course-meta {
      display: flex;
      flex-direction: column;
      gap: 12px;
      margin-bottom: 20px;
    }

    .meta-item {
      display: flex;
      align-items: center;
      font-size: 0.9rem;
      color: #64748b;
    }

    .meta-item i {
      margin-right: 10px;
      color: var(--primary-color);
      width: 16px;
    }

    .course-status {
      display: inline-block;
      padding: 6px 16px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
      letter-spacing: 0.3px;
      margin-top: 8px;
      align-self: flex-start;
    }

    .status-available {
      background: rgba(34, 197, 94, 0.1);
      color: #16a34a;
      border: 1px solid rgba(34, 197, 94, 0.2);
    }

    .status-full {
      background: rgba(239, 68, 68, 0.1);
      color: #dc2626;
      border: 1px solid rgba(239, 68, 68, 0.2);
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

    .search-container {
      position: relative;
      max-width: 320px;
    }

    .search-input {
      padding: 14px 20px 14px 50px;
      border-radius: 12px;
      border: 2px solid #e2e8f0;
      background: white;
      width: 100%;
      font-size: 0.95rem;
      transition: all 0.3s;
    }

    .search-input:focus {
      outline: none;
      border-color: var(--primary-color);
      box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    .search-icon {
      position: absolute;
      left: 20px;
      top: 50%;
      transform: translateY(-50%);
      color: #94a3b8;
    }

    .selected-badge {
      background: var(--primary-gradient);
      color: white;
      padding: 10px 20px;
      border-radius: 12px;
      font-weight: 600;
      font-size: 0.95rem;
      display: flex;
      align-items: center;
      gap: 8px;
      box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
    }

    .btn-select {
      background: var(--primary-gradient);
      border: none;
      color: white;
      padding: 14px;
      border-radius: 12px;
      font-weight: 600;
      font-size: 0.95rem;
      width: 100%;
      transition: all 0.3s;
      margin-top: auto;
    }

    .btn-select:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
    }

    .btn-selected {
      background: #e2e8f0;
      color: #64748b;
      cursor: not-allowed;
    }

    .btn-view-courses {
      background: white;
      border: 2px solid var(--primary-color);
      color: var(--primary-color);
      padding: 10px 20px;
      border-radius: 12px;
      font-weight: 600;
      transition: all 0.3s;
    }

    .btn-view-courses:hover {
      background: var(--primary-color);
      color: white;
    }

    .pagination-container {
      background: white;
      padding: 20px;
      border-radius: 16px;
      box-shadow: 0 4px 16px rgba(0,0,0,0.04);
    }

    .page-link {
      padding: 10px 18px;
      margin: 0 4px;
      border-radius: 10px;
      border: 1px solid #e2e8f0;
      color: #4a5568;
      font-weight: 500;
      transition: all 0.3s;
    }

    .page-link:hover {
      background: var(--light-purple);
      color: var(--primary-color);
      border-color: rgba(102, 126, 234, 0.3);
    }

    .page-item.active .page-link {
      background: var(--primary-gradient);
      border-color: var(--primary-color);
      color: white;
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
    }

    @media (max-width: 768px) {
      .course-grid {
        grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
        gap: 20px;
      }
      .navbar-main {
        padding: 15px;
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/student/selectCourse/findAllCourses">
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
        <div class="d-flex align-items-center">
          <div class="me-4">
            <h4 class="mb-0 fw-bold text-dark">
              <i class="fas fa-book-open me-2 text-primary"></i>课程中心
            </h4>
            <small class="text-muted">探索并选择您感兴趣的课程</small>
          </div>
          <form class="search-container" action="${pageContext.request.contextPath}/student/selectCourse/findAllCourses" method="get">
            <i class="fas fa-search search-icon"></i>
            <input type="text"
                   class="search-input"
                   placeholder="搜索课程名称、编号或教师..."
                   name="keyword"
                   value="${param.keyword}"
                   id="keywordInput">
          </form>
        </div>

        <div class="d-flex align-items-center gap-3">
          <div class="selected-badge">
            <i class="fas fa-check-circle"></i>
            已选 <span class="fw-bold">${selectedCourses}</span> 门课程
          </div>
          <a href="${pageContext.request.contextPath}/student/selectCourse/findMyCourses" class="btn-view-courses">
            <i class="fas fa-list-check me-2"></i>我的课程
          </a>
        </div>
      </div>
    </div>
  </nav>

  <!-- 课程列表 -->
  <div class="course-grid">
    <c:forEach var="course" items="${pb.list}">
      <div class="course-card">
        <div class="course-header">
          <div class="course-code">${course.courseNo}</div>
          <div class="course-credits">${course.credit}</div>
          <div class="course-status ${course.selected ? 'status-full' : 'status-available'}">
              ${course.selected ? '已选' : '可选'}
          </div>
          <h5 class="course-title">${course.name}</h5>
          <div class="course-description">${course.description}</div>
        </div>
        <div class="course-body">
          <div class="course-meta">
            <div class="meta-item">
              <i class="fas fa-chalkboard-teacher"></i>
              <span>教师: ${course.teacherName}</span>
            </div>
            <div class="meta-item">
              <i class="fas fa-graduation-cap"></i>
              <span>${course.credit}学分</span>
            </div>
          </div>
          <c:choose>
            <c:when test="${course.selected}">
              <button class="btn-select btn-selected" disabled>
                <i class="fas fa-check me-2"></i>已选课
              </button>
            </c:when>
            <c:otherwise>
              <button class="btn-select" onclick="selectCourse(${course.id},'${course.name}')">
                <i class="fas fa-plus me-2"></i>立即选课
              </button>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </c:forEach>
  </div>

  <!-- 分页 -->
  <div class="pagination-container">
    <nav aria-label="Page navigation">
      <form id="pageForm" action="${pageContext.request.contextPath}/student/selectCourse/findAllCourses" method="get">
        <input type="hidden" name="keyword" value="${param.keyword}" id="keyword">
        <input type="hidden" name="currentPage" id="currentPage">

        <ul class="pagination justify-content-center">
          <li class="page-item ${pb.currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href="javascript:goPage(1)">
              <i class="fas fa-angle-double-left"></i>
            </a>
          </li>
          <li class="page-item ${pb.currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link" href="javascript:goPage(${pb.currentPage - 1})">
              <i class="fas fa-chevron-left"></i>
            </a>
          </li>
          <c:forEach begin="1" end="${pb.totalPage}" var="i">
            <li class="page-item ${pb.currentPage == i ? 'active' : ''}">
              <a class="page-link" href="javascript:goPage(${i})">${i}</a>
            </li>
          </c:forEach>
          <li class="page-item ${pb.currentPage == pb.totalPage ? 'disabled' : ''}">
            <a class="page-link" href="javascript:goPage(${pb.currentPage + 1})">
              <i class="fas fa-chevron-right"></i>
            </a>
          </li>
          <li class="page-item ${pb.currentPage == pb.totalPage ? 'disabled' : ''}">
            <a class="page-link" href="javascript:goPage(${pb.totalPage})">
              <i class="fas fa-angle-double-right"></i>
            </a>
          </li>
        </ul>
      </form>
    </nav>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  const courseColors = [
    'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
    'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)',
    'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)',
    'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)',
    'linear-gradient(135deg, #fa709a 0%, #fee140 100%)',
    'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)'
  ];

  document.querySelectorAll('.course-header').forEach((header, index) => {
    header.style.background = courseColors[index % courseColors.length];
  });

  function goPage(page) {
    if (page < 1 || page > ${pb.totalPage}) return;

    const keyword = document.getElementById('keywordInput')?.value || '${param.keyword}';
    let url = '${pageContext.request.contextPath}/student/selectCourse/findAllCourses?currentPage=' + page;
    if (keyword) {
      url += '&keyword=' + encodeURIComponent(keyword);
    }

    document.getElementById('currentPage').value = page;
    document.getElementById('keyword').value = keyword;
    document.getElementById('pageForm').submit();
  }

  function selectCourse(courseId, courseName) {
    if (!confirm('确定要选择课程《' + courseName + '》吗？')) return;

    fetch('${pageContext.request.contextPath}/student/selectCourse/select?courseId=' + courseId, {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
    })
            .then(response => response.json())
            .then(data => {
              alert(data.msg);
              if (data.success) {
                location.reload();
              }
            })
            .catch(error => {
              console.error('Error:', error);
              alert('选课请求失败，请重试！');
            });
  }

  document.getElementById('keywordInput').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
      e.preventDefault();
      this.form.submit();
    }
  });
</script>
</body>
</html>