<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 헤더</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .admin-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      background-color: #B8D0FA;
      padding: 10px 20px;
    }
    .admin-header h1 {
      margin: 0;
      font-size: 24px;
      font-weight: bold;
      color: #2c3e50;
    }
    .logout-btn {
      padding: 8px 16px;
      background-color: silver;
      border: none;
      border-radius: 5px;
      font-weight: bold;
      cursor: pointer;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }
    .logout-btn:hover {
      background-color: #f05252;
      transform: scale(1.05);
      color: purple;
    }
  </style>
  <script>
    function confirmLogout() {
      if (confirm("관리자 페이지를 종료하시겠습니까?")) {
        window.location.href = "<%= request.getContextPath() %>/webservice/index.jsp?logout=true"; // 로그아웃 처리
      }
    }
  </script>
</head>
<body>
  <div class="admin-header">
    <h1>관리자 페이지</h1>
    <button class="logout-btn" onclick="confirmLogout()">관리자 페이지 나가기</button>
  </div>
</body>
</html>
