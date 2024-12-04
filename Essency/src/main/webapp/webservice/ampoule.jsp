<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>앰플/세럼 페이지</title>
  <link href="layout1.css" rel="stylesheet" type="text/css">
  <style>
    html, body {
      margin: 0;
      padding: 0;
      overflow-x: hidden;
      width: 100%;
      box-sizing: border-box;
    }

    * {
      box-sizing: inherit;
    }
    a {
      text-decoration: none;
      font-weight: bold; 
      color: black;
    }
    a:hover {
      text-decoration: underline;
      color: purple !important;
      transform: scale(1.05);
    }
    .welcome-message {
      color: black;
      font-weight: bold;
    }
    .button {
      padding: 10px 20px;
      background-color: #B8D0FA;
      border: none;
      cursor: pointer;
      color: black;
      font-weight: bold;
      border-radius: 5px;
    }
    .button:hover {
      background-color: Skyblue;
      color: purple;
      transform: scale(1.05);
    }
  </style>
</head>
<body>
  <!-- 중복된 헤더를 제거하고 header.jsp를 포함 -->
  <%@ include file="header.jsp" %>

  <main class="main">
    <h1 class="m1">앰플/세럼</h1>
    <section class="m2">
      <div class="product_image">
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059_10.jpg" alt="앰플 제품 1">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059_06.jpg" width="300" height="300" alt="앰플 제품 2">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059_12.jpg" width="300" height="300" alt="앰플 제품 3">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/콩에센스.jpg" width="300" height="300" alt="콩 에센스">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059_10.jpg" width="300" height="300" alt="앰플 제품 4">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059.jpg" width="300" height="300" alt="앰플 제품 5">
        </div>
      </div>
    </section>
  </main>

  <!-- footer.jsp를 포함 -->
  <%@ include file="footer.jsp" %>

  <% 
    if (request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("ampoule.jsp");
    }
  %>
</body>
</html>
