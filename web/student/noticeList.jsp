<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 系统公告</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-color: #764ba2;
      --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
      --info-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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

    .notice-container {
      background: white;
      border-radius: 18px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.06);
      border: 1px solid #f0f0f0;
      min-height: 400px;
    }

    .notice-header {
      padding: 25px 30px;
      border-bottom: 1px solid #f1f5f9;
      background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    }

    .notice-count {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 8px 16px;
      background: white;
      border-radius: 12px;
      font-weight: 600;
      color: #2d3748;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }

    .notice-list {
      padding: 20px;
    }

    .notice-item {
      background: white;
      border-radius: 16px;
      padding: 25px;
      margin-bottom: 20px;
      border: 1px solid #f1f5f9;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      cursor: pointer;
      position: relative;
      overflow: hidden;
    }

    .notice-item:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 30px rgba(0,0,0,0.08);
      border-color: rgba(102, 126, 234, 0.2);
    }

    .notice-item::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 4px;
      height: 100%;
      background: var(--primary-gradient);
      opacity: 0;
      transition: opacity 0.3s;
    }

    .notice-item:hover::before {
      opacity: 1;
    }

    .notice-header-content {
      display: flex;
      align-items: flex-start;
      gap: 15px;
      margin-bottom: 15px;
    }

    .notice-icon {
      width: 48px;
      height: 48px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
      font-size: 1.2rem;
    }

    .icon-important {
      background: var(--warning-gradient);
      color: white;
    }

    .icon-info {
      background: var(--info-gradient);
      color: white;
    }

    .icon-normal {
      background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
      color: white;
    }

    .notice-title-content {
      flex-grow: 1;
    }

    .notice-title {
      font-weight: 700;
      color: #2d3748;
      font-size: 1.2rem;
      margin-bottom: 8px;
      line-height: 1.4;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .new-badge {
      background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
      color: white;
      padding: 4px 10px;
      border-radius: 20px;
      font-size: 0.7rem;
      font-weight: 600;
      letter-spacing: 0.5px;
    }

    .notice-content {
      color: #64748b;
      font-size: 0.95rem;
      line-height: 1.6;
      margin-bottom: 20px;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    .notice-meta {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding-top: 15px;
      border-top: 1px solid #f1f5f9;
    }

    .notice-time {
      color: #94a3b8;
      font-size: 0.85rem;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .read-more {
      color: var(--primary-color);
      font-weight: 600;
      font-size: 0.9rem;
      display: flex;
      align-items: center;
      gap: 6px;
      transition: gap 0.3s;
    }

    .notice-item:hover .read-more {
      gap: 10px;
    }

    .search-container {
      position: relative;
      max-width: 300px;
    }

    .search-input {
      padding: 14px 20px 14px 45px;
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
      left: 15px;
      top: 50%;
      transform: translateY(-50%);
      color: #94a3b8;
    }

    .empty-state {
      text-align: center;
      padding: 100px 40px;
      color: #64748b;
    }

    .empty-icon {
      width: 100px;
      height: 100px;
      background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 30px;
      color: #94a3b8;
      font-size: 2.5rem;
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
      .notice-header-content {
        flex-direction: column;
      }
      .notice-meta {
        flex-direction: column;
        gap: 10px;
        align-items: flex-start;
      }
      .read-more {
        align-self: flex-end;
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/student/notice/findAll">
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
            <i class="fas fa-bullhorn me-2 text-primary"></i>系统公告
          </h4>
          <small class="text-muted">获取最新的学校通知和重要信息</small>
        </div>
        <div class="notice-count">
          <i class="fas fa-newspaper"></i>
          共 <span id="noticeCount">${noticeCount}</span> 条公告
        </div>
      </div>
    </div>
  </nav>

  <div class="notice-container">
    <div class="notice-header">
      <div class="d-flex justify-content-between align-items-center">
        <h5 class="mb-0 fw-bold text-dark">
          <i class="fas fa-newspaper me-2"></i>公告列表
        </h5>
        <div class="search-container">
          <i class="fas fa-search search-icon"></i>
          <input type="text" class="search-input" placeholder="搜索公告..." id="searchInput">
        </div>
      </div>
    </div>

    <div class="notice-list">
      <c:choose>
        <c:when test="${empty notices}">
          <div class="empty-state">
            <div class="empty-icon">
              <i class="fas fa-bell-slash"></i>
            </div>
            <h4 class="mb-3 fw-bold">暂无公告</h4>
            <p class="text-muted mb-4">暂时没有系统公告，请稍后再来查看</p>
          </div>
        </c:when>
        <c:otherwise>
          <div id="noticeList">
            <c:forEach var="notice" items="${notices}" varStatus="status">
              <div class="notice-item" onclick="viewNotice(${notice.id})">
                <div class="notice-header-content">
                  <div class="notice-icon ${status.index % 3 == 0 ? 'icon-important' : (status.index % 3 == 1 ? 'icon-info' : 'icon-normal')}">
                    <c:choose>
                      <c:when test="${status.index % 3 == 0}">
                        <i class="fas fa-exclamation-triangle"></i>
                      </c:when>
                      <c:when test="${status.index % 3 == 1}">
                        <i class="fas fa-info-circle"></i>
                      </c:when>
                      <c:otherwise>
                        <i class="fas fa-bell"></i>
                      </c:otherwise>
                    </c:choose>
                  </div>
                  <div class="notice-title-content">
                    <div class="notice-title">
                        ${notice.title}
                      <c:if test="${status.index < 3}">
                        <span class="new-badge">NEW</span>
                      </c:if>
                    </div>
                    <div class="notice-content">
                        ${notice.content}
                    </div>
                  </div>
                </div>
                <div class="notice-meta">
                  <div class="notice-time">
                    <i class="far fa-clock"></i>
                      ${notice.createTime}
                  </div>
                  <div class="read-more">
                    查看详情 <i class="fas fa-arrow-right"></i>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('searchInput').addEventListener('input', function(e) {
    const searchTerm = e.target.value.toLowerCase();
    const noticeItems = document.querySelectorAll('.notice-item');

    noticeItems.forEach(item => {
      const title = item.querySelector('.notice-title').textContent.toLowerCase();
      const content = item.querySelector('.notice-content').textContent.toLowerCase();

      if (title.includes(searchTerm) || content.includes(searchTerm)) {
        item.style.display = 'block';
      } else {
        item.style.display = 'none';
      }
    });
  });

  function viewNotice(id) {
    window.location.href = '${pageContext.request.contextPath}/student/notice/findById?id=' + id;
  }

  document.querySelectorAll('.nav-link').forEach(link => {
    if (link.href.includes('/student/notice/')) {
      link.classList.add('active');
    } else {
      link.classList.remove('active');
    }
  });
</script>
</body>
</html>