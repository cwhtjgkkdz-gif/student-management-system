<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 学生首页</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/echarts@5.4.3/dist/echarts.min.js"></script>
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-color: #764ba2;
      --success-gradient: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
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

    .welcome-card {
      background: var(--primary-gradient);
      color: white;
      border-radius: 20px;
      padding: 40px;
      margin-bottom: 30px;
      box-shadow: 0 15px 35px rgba(102, 126, 234, 0.2);
      position: relative;
      overflow: hidden;
    }

    .welcome-card::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle, rgba(255,255,255,0.1) 1%, transparent 20%);
      animation: float 20s linear infinite;
    }

    .student-avatar {
      width: 90px;
      height: 90px;
      border-radius: 20px;
      background: rgba(255, 255, 255, 0.2);
      backdrop-filter: blur(10px);
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 2.5rem;
      margin-right: 25px;
      border: 2px solid rgba(255, 255, 255, 0.3);
      flex-shrink: 0;
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
      gap: 20px;
      margin-bottom: 30px;
    }

    .stat-card {
      background: white;
      border-radius: 16px;
      padding: 25px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.06);
      border: 1px solid #f0f0f0;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      overflow: hidden;
    }

    .stat-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 15px 35px rgba(0,0,0,0.1);
      border-color: rgba(102, 126, 234, 0.2);
    }

    .stat-card::before {
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

    .stat-card:hover::before {
      opacity: 1;
    }

    .stat-icon {
      width: 56px;
      height: 56px;
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.8rem;
      margin-bottom: 20px;
    }

    .icon-primary {
      background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
      color: var(--primary-color);
    }

    .icon-indigo {
      background: linear-gradient(135deg, rgba(79, 70, 229, 0.1) 0%, rgba(147, 51, 234, 0.1) 100%);
      color: #4f46e5;
    }

    .icon-success {
      background: linear-gradient(135deg, rgba(34, 197, 94, 0.1) 0%, rgba(21, 128, 61, 0.1) 100%);
      color: #16a34a;
    }

    .icon-warning {
      background: linear-gradient(135deg, rgba(245, 158, 11, 0.1) 0%, rgba(217, 119, 6, 0.1) 100%);
      color: #f59e0b;
    }

    .stat-number {
      font-size: 2.2rem;
      font-weight: 700;
      color: #1a202c;
      margin-bottom: 5px;
      line-height: 1;
    }

    .stat-label {
      color: #64748b;
      font-size: 0.95rem;
      font-weight: 500;
    }

    .dashboard-grid {
      display: grid;
      grid-template-columns: 2fr 1fr;
      gap: 30px;
      margin-bottom: 30px;
    }

    .chart-card {
      background: white;
      border-radius: 20px;
      padding: 30px;
      box-shadow: 0 6px 20px rgba(0,0,0,0.06);
      border: 1px solid #f0f0f0;
      height: 100%;
    }

    .chart-card-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 25px;
    }

    .chart-title {
      font-weight: 700;
      color: #1a202c;
      font-size: 1.3rem;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    #chart-container {
      width: 100%;
      height: 320px;
      margin-top: 10px;
    }

    .quick-actions-grid {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 15px;
    }

    .action-btn {
      background: white;
      border: 2px solid #e2e8f0;
      border-radius: 16px;
      padding: 25px 15px;
      text-decoration: none;
      color: #4a5568;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 15px;
      text-align: center;
    }

    .action-btn:hover {
      transform: translateY(-4px);
      box-shadow: 0 12px 25px rgba(0,0,0,0.1);
      border-color: var(--primary-color);
      color: var(--primary-color);
    }

    .action-icon {
      width: 60px;
      height: 60px;
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.8rem;
    }

    .action-1 { background: rgba(102, 126, 234, 0.1); color: var(--primary-color); }
    .action-2 { background: rgba(34, 197, 94, 0.1); color: #16a34a; }
    .action-3 { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
    .action-4 { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }

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

    .badge-light {
      background: rgba(255, 255, 255, 0.2);
      backdrop-filter: blur(10px);
      color: white;
      padding: 6px 14px;
      border-radius: 20px;
      font-weight: 600;
    }

    @keyframes float {
      0% {
        transform: rotate(0deg);
      }
      100% {
        transform: rotate(360deg);
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
      .dashboard-grid {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 768px) {
      .welcome-card {
        padding: 30px 20px;
      }
      .student-avatar {
        width: 70px;
        height: 70px;
        font-size: 2rem;
        margin-right: 20px;
      }
      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
      }
      .quick-actions-grid {
        grid-template-columns: 1fr;
      }
      .time-display {
        flex-direction: column;
        gap: 10px;
        align-items: flex-start;
      }
    }

    @media (max-width: 576px) {
      .stats-grid {
        grid-template-columns: 1fr;
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/student/countServlet">
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
            <i class="fas fa-user-graduate me-2 text-primary"></i>学生个人中心
          </h4>
          <small class="text-muted">欢迎使用学生信息管理系统</small>
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

  <!-- 欢迎卡片 -->
  <div class="welcome-card">
    <div class="d-flex align-items-center">
      <div class="student-avatar">
        <i class="fas fa-user-graduate"></i>
      </div>
      <div class="flex-grow-1">
        <h3 class="mb-2 fw-bold">欢迎回来，${student.name}同学！</h3>
        <p class="mb-0 opacity-90">
          <i class="fas fa-quote-left me-2"></i>
          学如逆水行舟，不进则退。今天也要努力学习哦！
        </p>
      </div>
      <div class="text-end">
        <div class="h5 mb-2">${student.studentNo}</div>
        <div class="badge-light">${student.gender}·${student.age}岁</div>
      </div>
    </div>
  </div>

  <!-- 统计数据 -->
  <div class="stats-grid">
    <div class="stat-card">
      <div class="stat-icon icon-primary">
        <i class="fas fa-book"></i>
      </div>
      <div class="stat-number" id="courseCount">${selectedCourseCount}</div>
      <div class="stat-label">已选课程</div>
    </div>

    <div class="stat-card">
      <div class="stat-icon icon-indigo">
        <i class="fas fa-book-open"></i>
      </div>
      <div class="stat-number" id="totalCourseCount">${courseCount}</div>
      <div class="stat-label">总课程数</div>
    </div>

    <div class="stat-card">
      <div class="stat-icon icon-success">
        <i class="fas fa-star"></i>
      </div>
      <div class="stat-number" id="creditCount">${totalCredits}</div>
      <div class="stat-label">获得学分</div>
    </div>

    <div class="stat-card">
      <div class="stat-icon icon-warning">
        <i class="fas fa-bullhorn"></i>
      </div>
      <div class="stat-number" id="noticeCount">${noticeCount}</div>
      <div class="stat-label">系统公告</div>
    </div>
  </div>

  <!-- 图表和快速操作 -->
  <div class="dashboard-grid">
    <!-- 图表区域 -->
    <div class="chart-card">
      <div class="chart-card-header">
        <div class="chart-title">
          <i class="fas fa-chart-pie text-primary"></i>
          ${student.name}同学综合统计图
        </div>
      </div>
      <div id="chart-container"></div>
    </div>

    <!-- 快速操作区域 -->
    <div class="chart-card">
      <div class="chart-card-header">
        <div class="chart-title">
          <i class="fas fa-bolt text-success"></i>
          快速操作
        </div>
      </div>
      <div class="quick-actions-grid">
        <a href="${pageContext.request.contextPath}/student/selectCourse/findAllCourses" class="action-btn">
          <div class="action-icon action-1">
            <i class="fas fa-clipboard-check"></i>
          </div>
          <div class="fw-bold">选课</div>
        </a>

        <a href="${pageContext.request.contextPath}/student/selectCourse/findMyCourses" class="action-btn">
          <div class="action-icon action-2">
            <i class="fas fa-list-ul"></i>
          </div>
          <div class="fw-bold">我的课程</div>
        </a>

        <a href="${pageContext.request.contextPath}/student/notice/findAll" class="action-btn">
          <div class="action-icon action-3">
            <i class="fas fa-bullhorn"></i>
          </div>
          <div class="fw-bold">查看公告</div>
        </a>

        <a href="${pageContext.request.contextPath}/student/settings" class="action-btn">
          <div class="action-icon action-4">
            <i class="fas fa-user-cog"></i>
          </div>
          <div class="fw-bold">用户设置</div>
        </a>
      </div>
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

  const myChart = echarts.init(document.getElementById('chart-container'));
  const option = {
    color: ['#764ba2', '#667eea', '#41b883', '#f7b84b'],
    tooltip: {
      trigger: 'item',
      formatter: '<b>{b}</b> : {c}<br/>占比 : {d}%',
      backgroundColor: 'rgba(255,255,255,0.95)',
      borderColor: '#e1e5ee',
      borderWidth: 1,
      textStyle: { color: '#333', fontSize: 13 },
      padding: [10,15]
    },
    legend: {
      orient: 'horizontal',
      bottom: 5,
      left: 'center',
      textStyle: { fontSize: 12 },
      itemGap: 20
    },
    series: [{
      name: '学习数据统计',
      type: 'pie',
      radius: ['35%', '70%'],
      center: ['50%', '45%'],
      avoidLabelOverlap: false,
      itemStyle: {
        borderRadius: 10,
        borderColor: '#ffffff',
        borderWidth: 2
      },
      label: { show: false },
      labelLine: { show: false },
      emphasis: {
        label: {
          show: true,
          fontSize: 16,
          fontWeight: 'bold',
          color: '#333'
        }
      },
      data: [
        { value: ${selectedCourseCount},  name: '已选课程' },
        { value: ${courseCount}, name: '总课程数' },
        { value: ${totalCredits}, name: '获得学分' },
        { value: ${noticeCount},  name: '系统公告' }
      ]
    }]
  };
  myChart.setOption(option);

  window.addEventListener('resize', function(){ myChart.resize(); });
</script>
</body>
</html>