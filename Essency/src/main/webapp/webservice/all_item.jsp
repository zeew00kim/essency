<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>전체 상품 페이지</title>
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
  <!-- Header Include -->
  <%@ include file="header.jsp" %>

  <main class="main">
    <h1 class="m1">전체상품</h1>
    <section class="m2">
      <div class="product_image">
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241127_111509868_16.jpg" width="859" height="1076" alt="Product 1">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059_15.jpg" width="525" height="700" alt="Product 3">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/다운로드.jpg" width="736" height="736" alt="Product 4">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059_08.jpg" width="736" height="736" alt="Product 5">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241127_111509868_18.jpg" width="860" height="1075" alt="클렌징 제품 1">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241127_111509868_04.jpg" width="858" height="1147" alt="클렌징 제품 2">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/클렌저.jpg" width="1000" height="1000" alt="클렌저 1">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/클렌저2.jpg" width="1000" height="1000" alt="클렌저 2">
        </div>
        <div class="product">
          <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241128_194419059_05.jpg" width="481" height="510" alt="클렌징 제품 3">
        </div>
        <div class="product">
          <a href="itemdetail.jsp">
            <img src="<%= request.getContextPath() %>/webservice/image/KakaoTalk_20241127_111509868_02.jpg" alt="Product 2">
          </a>
        </div>
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

  <!-- Footer Include -->
  <%@ include file="footer.jsp" %>

  <% 
    // 로그아웃 처리
    if (request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("all_item.jsp");  
    }
  %>
</body>
</html>
