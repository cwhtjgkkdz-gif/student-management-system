<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>500 - 服务器内部错误</title>
  <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
  <style>
    .error-container {
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
    }
    .error-card {
      background: white;
      border-radius: 15px;
      padding: 40px;
      text-align: center;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    }
    .error-icon {
      font-size: 80px;
      color: #ee5a52;
      margin-bottom: 20px;
    }
    .error-title {
      font-size: 48px;
      font-weight: bold;
      color: #333;
      margin-bottom: 10px;
    }
    .error-message {
      font-size: 18px;
      color: #666;
      margin-bottom: 30px;
    }
  </style>
</head>
<body>
<div class="error-container">
  <div class="error-card">
    <div class="error-icon">
      <i class="fas fa-server"></i>
    </div>
    <h1 class="error-title">500</h1>
    <p class="error-message">抱歉，服务器处理您的请求时发生了错误！</p>
    <div class="row g-3 justify-content-center">
      <div class="col-auto">
        <a href="${pageContext.request.contextPath}/" class="btn btn-danger btn-lg">
          <i class="fas fa-home me-2"></i>返回首页
        </a>
      </div>
      <div class="col-auto">
        <button onclick="history.back()" class="btn btn-outline-danger btn-lg">
          <i class="fas fa-arrow-left me-2"></i>返回上一页
        </button>
      </div>
    </div>
  </div>
</div>
</body>
</html>