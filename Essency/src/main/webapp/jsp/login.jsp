<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인 페이지</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      margin: 0;
      padding: 0;
      background: url('<%= request.getContextPath() %>/webservice/image/login-bg.jpg') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Roboto', sans-serif;
    } 
    .card {
      background-color: rgba(255, 255, 255, 0.9); /* 카드 배경을 약간 투명하게 */
      border-radius: 15px;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    .container {
      padding-top: 20px;
    }
    .card-title {
      font-weight: bold;
      color: #2c3e50; /* 진한 네이비 */
    }
    .form-control {
      border-radius: 10px;
    }
    .btn-primary {
      background-color: #B8D0FA;
      border: none;
      color: #2c3e50;
      font-weight: bold;
    } 
    .btn-primary:hover {
      background-color: skyblue;
      color: purple;
    }
    .text-decoration-none {
      color: #2c3e50 !important;
    }
    .text-decoration-none:hover {
      color: purple !important;
      text-decoration: underline;
    }
    .mb-3 {
    	font-weight: bold;
    	color: #2c3e50; 
    }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %>

  <div class="container d-flex justify-content-center align-items-center vh-100" style="margin-top: -50px;"> 
    <div class="card" style="width: 25rem;">
      <div class="card-body">
        <h3 class="card-title text-center mb-4">로그인</h3>
        
        <!-- 에러 메시지 표시 -->
        <% 
          String errorMessage = (String) request.getAttribute("errorMessage"); 
          if (errorMessage != null && !errorMessage.isEmpty()) { 
        %>
        <div class="alert alert-danger text-center">
          <%= errorMessage %>
        </div>
        <% } %>
        
        <!-- 로그인 폼 -->
        <form action="<%= request.getContextPath() %>/loginControl" method="POST">
          <!-- 아이디 입력 -->
          <div class="mb-3">
            <label for="username" class="form-label">아이디</label>
            <input type="text" class="form-control" id="username" name="username" placeholder="아이디를 입력하세요" required>
          </div>

          <!-- 비밀번호 입력 -->
          <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
          </div>

          <!-- 로그인 버튼 -->
          <button type="submit" class="btn btn-primary w-100">로그인</button>
        </form>

        <div class="text-center mt-3">
          <p>계정이 없으신가요? 
            <a href="<%= request.getContextPath() %>/jsp/signUp.jsp" class="text-decoration-none">회원가입</a>
          </p>
        </div>
      </div>
    </div>
  </div>

  <% 
    // 추가 로직: POST 요청 처리 후 관리자 계정 확인
    if ("POST".equalsIgnoreCase(request.getMethod())) {
      String username = request.getParameter("username");
      String password = request.getParameter("password");

      if ("admin".equals(username) && "admin".equals(password)) {
        // 관리자 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/jsp/adminPage.jsp");
      }
    }
  %>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>

<%@ include file="footer.jsp" %>
</html>
