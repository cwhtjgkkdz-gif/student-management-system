<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 我的课程</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-color: #764ba2;
      --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
      --danger-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
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

    .stats-card {
      background: white;
      border-radius: 18px;
      padding: 30px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.06);
      border: 1px solid #f0f0f0;
      margin-bottom: 30px;
    }

    .stats-content {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 30px;
      align-items: center;
    }

    .credits-display {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .credits-circle {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      background: var(--primary-gradient);
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 2.5rem;
      font-weight: 700;
      box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
    }

    .credits-info h4 {
      color: #2d3748;
      margin-bottom: 10px;
      font-weight: 600;
    }

    .credits-progress {
      background: #e2e8f0;
      height: 8px;
      border-radius: 4px;
      overflow: hidden;
      margin-top: 15px;
    }

    .progress-bar {
      height: 100%;
      background: var(--primary-gradient);
      border-radius: 4px;
      width: ${(totalCredits / 30) * 100}%;
      transition: width 0.3s ease;
    }

    .table-container {
      background: white;
      border-radius: 18px;
      overflow: hidden;
      box-shadow: 0 6px 20px rgba(0,0,0,0.06);
      border: 1px solid #f0f0f0;
    }

    .table-header {
      background: #f8fafc;
      padding: 20px 30px;
      border-bottom: 1px solid #e2e8f0;
    }

    .table {
      margin: 0;
      border-collapse: separate;
      border-spacing: 0;
    }

    .table thead th {
      background: #f8fafc;
      color: #4a5568;
      font-weight: 600;
      font-size: 0.9rem;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      padding: 18px 20px;
      border-bottom: 2px solid #e2e8f0;
    }

    .table tbody tr {
      transition: all 0.2s ease;
    }

    .table tbody tr:hover {
      background: #f8fafc;
      transform: translateY(-1px);
      box-shadow: 0 3px 10px rgba(0,0,0,0.04);
    }

    .table tbody td {
      padding: 20px;
      vertical-align: middle;
      border-bottom: 1px solid #f1f5f9;
      color: #4a5568;
    }

    .course-cell {
      display: flex;
      flex-direction: column;
      gap: 4px;
    }

    .course-name {
      font-weight: 600;
      color: #2d3748;
      font-size: 1.05rem;
    }

    .course-teacher {
      font-size: 0.9rem;
      color: #64748b;
    }

    .credit-badge {
      background: var(--primary-gradient);
      color: white;
      padding: 6px 14px;
      border-radius: 20px;
      font-weight: 600;
      font-size: 0.85rem;
      display: inline-block;
    }

    .time-badge {
      background: #f1f5f9;
      color: #64748b;
      padding: 6px 12px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 500;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }

    .btn-drop {
      background: var(--danger-gradient);
      border: none;
      color: white;
      padding: 10px 20px;
      border-radius: 10px;
      font-weight: 600;
      font-size: 0.9rem;
      transition: all 0.3s;
    }

    .btn-drop:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 15px rgba(245, 87, 108, 0.3);
    }

    .search-container {
      position: relative;
      max-width: 280px;
    }

    .search-input {
      padding: 12px 20px 12px 45px;
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
      padding: 80px 40px;
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

    .btn-select-course {
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

    .btn-select-course:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
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
      .stats-content {
        grid-template-columns: 1fr;
        gap: 20px;
      }
      .credits-display {
        justify-content: center;
        text-align: center;
      }
      .table-responsive {
        border-radius: 12px;
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/student/selectCourse/findMyCourses">
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
            <i class="fas fa-list-check me-2 text-primary"></i>我的课程
          </h4>
          <small class="text-muted">查看和管理您已选择的课程</small>
        </div>
        <div>
          <a href="${pageContext.request.contextPath}/student/selectCourse/findAllCourses" class="btn btn-outline-primary">
            <i class="fas fa-plus-circle me-2"></i>继续选课
          </a>
        </div>
      </div>
    </div>
  </nav>

  <!-- 学分统计 -->
  <div class="stats-card">
    <div class="stats-content">
      <div class="credits-display">
        <div class="credits-circle">
          ${totalCredits}
        </div>
        <div class="credits-info">
          <h4>已获得总学分</h4>
          <p class="text-muted">已选课程: <span class="fw-bold">${selectedCourseCount}</span> 门</p>
          <div class="credits-progress">
            <div class="progress-bar"></div>
          </div>
          <small class="text-muted mt-2 d-block">本学期最多可选30学分</small>
        </div>
      </div>

      <div class="d-flex flex-column gap-3">
        <div class="search-container">
          <i class="fas fa-search search-icon"></i>
          <input type="text" class="search-input" placeholder="搜索我的课程..." id="searchInput">
        </div>
        <div class="d-flex gap-2">
          <button class="btn btn-outline-secondary flex-grow-1">
            <i class="fas fa-filter me-2"></i>筛选
          </button>
          <button class="btn btn-outline-secondary flex-grow-1">
            <i class="fas fa-sort me-2"></i>排序
          </button>
        </div>
      </div>
    </div>
  </div>

  <!-- 课程列表 -->
  <div class="table-container">
    <c:choose>
      <c:when test="${empty myCourses}">
        <div class="empty-state">
          <div class="empty-icon">
            <i class="fas fa-book-open"></i>
          </div>
          <h4 class="mb-3 fw-bold">您还没有选择任何课程</h4>
          <p class="text-muted mb-4">快去课程中心选择您感兴趣的课程吧！</p>
          <a href="${pageContext.request.contextPath}/student/selectCourse/findAllCourses" class="btn-select-course">
            <i class="fas fa-arrow-right me-2"></i>前往选课
          </a>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-header">
          <h5 class="mb-0 fw-bold text-dark">
            <i class="fas fa-book-open me-2"></i>我的课程列表
            <span class="badge bg-primary ms-2">${selectedCourseCount} 门课程</span>
          </h5>
        </div>

        <div class="table-responsive">
          <table class="table table-hover" id="myCourseTable">
            <thead>
            <tr>
              <th width="40%">课程信息</th>
              <th width="15%">课程编号</th>
              <th width="15%">学分</th>
              <th width="20%">选课时间</th>
              <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="course" items="${myCourses}">
              <tr>
                <td>
                  <div class="course-cell">
                    <div class="course-name">${course.courseName}</div>
                    <div class="course-teacher">
                      <i class="fas fa-chalkboard-teacher me-1"></i>${course.teacherName}
                    </div>
                  </div>
                </td>
                <td>
                  <span class="badge bg-light text-dark">${course.courseNo}</span>
                </td>
                <td>
                  <span class="credit-badge">${course.credit}</span>
                </td>
                <td>
                    <span class="time-badge">
                      <i class="far fa-clock"></i>
                      <fmt:formatDate value="${course.selectTime}" pattern="yyyy-MM-dd HH:mm"/>
                    </span>
                </td>
                <td>
                  <button class="btn-drop" onclick="dropCourse(${course.courseId}, '${course.courseName}')">
                    <i class="fas fa-trash me-1"></i>退课
                  </button>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.getElementById('searchInput').addEventListener('input', function(e) {
    const searchTerm = e.target.value.toLowerCase();
    const rows = document.querySelectorAll('#myCourseTable tbody tr');

    rows.forEach(row => {
      const text = row.textContent.toLowerCase();
      row.style.display = text.includes(searchTerm) ? '' : 'none';
    });
  });

  function dropCourse(courseId, courseName) {
    if (!confirm('确定要退选课程 "' + courseName + '" 吗？')) return;

    const params = new URLSearchParams();
    params.append('courseId', courseId);

    fetch('${pageContext.request.contextPath}/student/selectCourse/drop', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: params
    })
            .then(response => {
              if (!response.ok) throw new Error('请求失败');
              return response.text();
            })
            .then(text => {
              try {
                const data = JSON.parse(text);
                alert(data.msg);
                if (data.success) {
                  location.reload();
                }
              } catch (e) {
                alert('操作成功！');
                location.reload();
              }
            })
            .catch(error => {
              console.error('Error:', error);
              alert('请求失败: ' + error.message);
            });
  }

  document.querySelectorAll('.nav-link').forEach(link => {
    if (link.href.includes('/student/selectCourse/findMyCourses')) {
      link.classList.add('active');
    } else {
      link.classList.remove('active');
    }
  });
</script>
</body>
</html>