<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>学生信息管理系统 - 公告详情</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      --primary-color: #764ba2;
      --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
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

    .notice-detail-container {
      background: white;
      border-radius: 20px;
      box-shadow: 0 8px 30px rgba(0,0,0,0.06);
      border: 1px solid #f0f0f0;
      overflow: hidden;
    }

    .notice-header {
      padding: 40px;
      background: linear-gradient(135deg, #667eea10 0%, #764ba210 100%);
      border-bottom: 1px solid #f1f5f9;
    }

    .notice-title {
      font-weight: 800;
      color: #1a202c;
      font-size: 2rem;
      margin-bottom: 20px;
      line-height: 1.3;
    }

    .notice-meta {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      margin-bottom: 10px;
    }

    .meta-item {
      display: flex;
      align-items: center;
      gap: 8px;
      color: #64748b;
      font-size: 0.95rem;
    }

    .meta-item i {
      color: var(--primary-color);
      width: 16px;
    }

    .notice-content {
      padding: 40px;
      color: #4a5568;
      line-height: 1.8;
      font-size: 1.05rem;
    }

    .notice-content p {
      margin-bottom: 24px;
    }

    .notice-content h3 {
      color: #2d3748;
      margin: 30px 0 20px;
      font-weight: 600;
    }

    .notice-content ul, .notice-content ol {
      margin-bottom: 24px;
      padding-left: 24px;
    }

    .notice-content li {
      margin-bottom: 8px;
    }

    .notice-content img {
      max-width: 100%;
      height: auto;
      border-radius: 12px;
      margin: 24px 0;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .important-notice {
      background: linear-gradient(135deg, #fff9e6 0%, #ffe6e6 100%);
      border-left: 5px solid #ff6b6b;
      padding: 25px;
      border-radius: 12px;
      margin: 30px 0;
    }

    .important-notice h5 {
      color: #dc2626;
      margin-bottom: 10px;
      font-weight: 700;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .attachment-box {
      background: #f8fafc;
      border-radius: 12px;
      padding: 30px;
      margin-top: 40px;
      border: 1px solid #e2e8f0;
    }

    .attachment-item {
      display: flex;
      align-items: center;
      padding: 20px;
      border-bottom: 1px solid #e2e8f0;
      transition: all 0.3s;
    }

    .attachment-item:hover {
      background: white;
      transform: translateX(4px);
    }

    .attachment-item:last-child {
      border-bottom: none;
    }

    .attachment-icon {
      font-size: 1.8rem;
      margin-right: 20px;
      color: var(--primary-color);
      min-width: 50px;
    }

    .attachment-info {
      flex-grow: 1;
    }

    .attachment-name {
      font-weight: 600;
      color: #2d3748;
      margin-bottom: 5px;
    }

    .attachment-size {
      color: #94a3b8;
      font-size: 0.9rem;
    }

    .btn-primary-custom {
      background: var(--primary-gradient);
      border: none;
      color: white;
      padding: 12px 28px;
      border-radius: 12px;
      font-weight: 600;
      font-size: 1rem;
      transition: all 0.3s;
      display: inline-flex;
      align-items: center;
      gap: 8px;
    }

    .btn-primary-custom:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(102, 126, 234, 0.3);
      color: white;
    }

    .btn-outline-custom {
      background: white;
      border: 2px solid #e2e8f0;
      color: #64748b;
      padding: 12px 24px;
      border-radius: 12px;
      font-weight: 600;
      transition: all 0.3s;
      display: inline-flex;
      align-items: center;
      gap: 8px;
    }

    .btn-outline-custom:hover {
      border-color: var(--primary-color);
      color: var(--primary-color);
      background: rgba(102, 126, 234, 0.04);
    }

    .action-buttons {
      padding: 30px 40px;
      background: #f8fafc;
      border-top: 1px solid #f1f5f9;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .back-button {
      margin-bottom: 20px;
    }

    .back-link {
      color: var(--primary-color);
      font-weight: 600;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      text-decoration: none;
      padding: 10px 20px;
      border-radius: 10px;
      transition: all 0.3s;
    }

    .back-link:hover {
      background: rgba(102, 126, 234, 0.1);
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
      .notice-header {
        padding: 30px 20px;
      }
      .notice-content {
        padding: 30px 20px;
      }
      .action-buttons {
        padding: 20px;
        flex-direction: column;
        gap: 15px;
      }
      .notice-meta {
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
            <i class="fas fa-newspaper me-2 text-primary"></i>公告详情
          </h4>
          <small class="text-muted">查看公告的详细内容</small>
        </div>
        <div>
          <a href="${pageContext.request.contextPath}/student/notice/findAll" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>返回列表
          </a>
        </div>
      </div>
    </div>
  </nav>

  <!-- 返回按钮 -->
  <div class="back-button">
    <a href="${pageContext.request.contextPath}/student/notice/findAll" class="back-link">
      <i class="fas fa-arrow-left"></i>返回公告列表
    </a>
  </div>

  <!-- 公告详情 -->
  <div class="notice-detail-container">
    <div class="notice-header">
      <h1 class="notice-title">${notice.title}</h1>
      <div class="notice-meta">
        <div class="meta-item">
          <i class="far fa-clock"></i>
          发布时间: ${notice.createTime}
        </div>
        <div class="meta-item">
          <i class="fas fa-eye"></i>
          阅读次数: <span id="readCount">${notice.id * 100 + 254}</span>
        </div>
        <div class="meta-item">
          <i class="fas fa-user-shield"></i>
          发布者: 系统管理员
        </div>
        <div class="meta-item">
          <i class="fas fa-tag"></i>
          分类: <span class="badge bg-primary">系统通知</span>
        </div>
      </div>
    </div>

    <div class="notice-content">
      <c:if test="${notice.id % 3 == 0}">
        <div class="important-notice">
          <h5>
            <i class="fas fa-exclamation-triangle"></i>
            重要通知
          </h5>
          <p>此公告包含重要信息，请所有同学务必仔细阅读并按要求执行。</p>
        </div>
      </c:if>

      <div class="content-body">
        <p>${notice.content}</p>

        <h3><i class="fas fa-info-circle me-2 text-primary"></i>补充说明</h3>
        <p>为了确保通知内容的完整性，以下为补充说明：</p>
        <ul>
          <li>请所有同学在规定时间内完成相关操作</li>
          <li>如有疑问，请及时联系相关负责人</li>
          <li>本通知自发布之日起生效</li>
          <li>请同学们相互转告，确保信息传达</li>
        </ul>

        <h3><i class="fas fa-calendar-alt me-2 text-primary"></i>时间安排</h3>
        <p>请按照以下时间节点完成相应工作：</p>
        <ol>
          <li>第一阶段：信息确认（发布日起3天内）</li>
          <li>第二阶段：材料提交（发布日起7天内）</li>
          <li>第三阶段：结果公示（发布日起14天内）</li>
        </ol>
      </div>

      <c:if test="${notice.id % 2 == 0}">
        <div class="attachment-box">
          <h5 class="mb-4">
            <i class="fas fa-paperclip me-2 text-primary"></i>附件下载
          </h5>
          <div class="attachment-item">
            <div class="attachment-icon">
              <i class="fas fa-file-pdf"></i>
            </div>
            <div class="attachment-info">
              <div class="attachment-name">详细说明文档.pdf</div>
              <div class="attachment-size">大小: 2.4 MB · 更新日期: 2023-11-15</div>
            </div>
            <a href="#" class="btn btn-primary-custom btn-sm">
              <i class="fas fa-download"></i>下载
            </a>
          </div>
          <div class="attachment-item">
            <div class="attachment-icon">
              <i class="fas fa-file-excel"></i>
            </div>
            <div class="attachment-info">
              <div class="attachment-name">相关表格.xlsx</div>
              <div class="attachment-size">大小: 1.8 MB · 更新日期: 2023-11-15</div>
            </div>
            <a href="#" class="btn btn-primary-custom btn-sm">
              <i class="fas fa-download"></i>下载
            </a>
          </div>
        </div>
      </c:if>
    </div>

    <!-- 操作按钮 -->
    <div class="action-buttons">
      <div class="d-flex gap-2">
        <button class="btn-outline-custom" onclick="window.print()">
          <i class="fas fa-print"></i>打印公告
        </button>
        <button class="btn-outline-custom" onclick="shareNotice()">
          <i class="fas fa-share-alt"></i>分享公告
        </button>
      </div>
      <div>
        <a href="${pageContext.request.contextPath}/student/notice/findAll" class="btn-primary-custom">
          <i class="fas fa-list"></i>返回列表
        </a>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  document.querySelectorAll('.nav-link').forEach(link => {
    if (link.href.includes('/student/notice/')) {
      link.classList.add('active');
    } else {
      link.classList.remove('active');
    }
  });

  function shareNotice() {
    const title = document.querySelector('.notice-title').textContent;
    const text = '查看学校公告：' + title;
    const url = window.location.href;

    if (navigator.share) {
      navigator.share({
        title: title,
        text: text,
        url: url
      })
              .then(() => console.log('分享成功'))
              .catch((error) => {
                console.log('分享失败', error);
                copyToClipboard(url);
              });
    } else {
      copyToClipboard(url);
    }
  }

  function copyToClipboard(text) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    alert('链接已复制到剪贴板！');
  }

  // 模拟阅读次数更新
  window.addEventListener('load', () => {
    const readCountEl = document.getElementById('readCount');
    let count = parseInt(readCountEl.textContent);
    count += 1;
    readCountEl.textContent = count;
  });
</script>
</body>
</html>