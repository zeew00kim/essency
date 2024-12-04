<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>제품 상세 페이지</title>
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
    
    .welcome-message {
      color: black;
      font-weight: bold;
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

    .product-name {
      font-weight: bold;
      font-size: 1.5em;
    }
    .product-price, .shipping-fee {
      font-size: 1.2em;
      margin-top: 10px;
      display: block;
    }

    .buttons {
      margin-top: 20px;
      display: flex;
      gap: 10px;
    }
    .buttons button {
      padding: 10px 20px;
      font-size: 1em;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }
    .buttons .button {
      background-color: #b8d0fa;
      border: 2px solid silver;
      color: black;
    }
    .buttons .button:hover {
      background-color: skyblue;
      transform: scale(1.05);
    }

    .button {
      padding: 10px 20px;
      background-color: #B8D0FA;
      cursor: pointer;
      color: black;
      border: none;
      font-weight: bold;
      border-radius: 5px;
    }
    .button:hover {
      background-color: Skyblue;
      color: purple;
      transform: scale(1.05);
    }

    .confirm-banner {
      display: none;
      position: fixed;
      top: 30%;
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: white;
      border: 2px solid #B8D0FA;
      border-radius: 10px;
      padding: 20px;
      width: 300px;
      text-align: center;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      z-index: 1000;
    }
    .confirm-banner button {
      margin: 10px;
      padding: 10px 20px;
      font-weight: bold;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }
    .confirm-banner .confirm {
      background-color: #B8D0FA;
      color: black;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }
    .confirm-banner .confirm:hover {
      background-color: Skyblue;
      color: purple;
      transform: scale(1.05);
    }
    .confirm-banner .cancel {
      background-color: #ccc;
      color: black;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }
    .confirm-banner .cancel:hover {
      background-color: #999;
      color: purple;
      transform: scale(1.05);
    }
    .overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.5);
      z-index: 999;
    }
  </style>
</head>
<body>
  <div class="wrap">
    <header class="header">
      <div class="h1">
        <% 
          String userName = (String) session.getAttribute("userName");
          if (userName != null) {
        %> 
          <p class="welcome-message"><%= userName %>님 반갑습니다 😊</p>
          <form action="itemdetail.jsp" method="post" style="display: inline;">
            <button type="submit" name="logout" class="button">로그아웃</button>
          </form>
        <% } else { %>
          <a href="register.jsp" class="button">회원가입</a>
          <a href="login.jsp" class="button">로그인</a>
        <% } %>
      </div>
      <div class="h2">
        <a href="index.jsp">
          <img src="../webservice/image/스크린샷 2024-11-28 210005.png" width="289" height="103" alt="로고">
        </a>
      </div>
      <nav class="h3">
        <div class="h3_center">
          <a href="all_item.jsp">전체상품</a>&nbsp;
          <a href="lotion.jsp">로션/크림</a>&nbsp;
          <a href="cleansing.jsp">클렌징</a>&nbsp;
          <a href="ampoule.jsp">앰플/세럼</a>&nbsp;
        </div>
      </nav>
    </header>

    <main class="main">
      <section class="m2">
        <div class="m2_left">
          <img src="../webservice/image/KakaoTalk_20241127_111509868_02.jpg" alt="제품 이미지" width="300" height="400">
        </div>
        <div class="m2_right">
          <span class="product-name">제품명</span>
          <span class="product-price">판매 가격&nbsp;&nbsp;15,000원</span>
          <span class="shipping-fee">배송비&nbsp;&nbsp;2,500원</span><br>
          <div class="buttons">
            <button class="button" onclick="showCartBanner()">장바구니에 담기</button>
            <button class="button" onclick="checkLogin()">구매하기</button>
          </div>
        </div>
      </section>
    </main>

    <footer class="footer">
      <span style="font-weight: bold">웹프로그래밍응용 Team_Project</span>
    </footer>
  </div>

  <div class="overlay" id="overlay"></div>
  <div class="confirm-banner" id="confirmBanner">
    <p id="bannerMessage">로그인이 필요합니다!</p>
    <button class="confirm" id="confirmButton">확인</button>
    <button class="cancel" onclick="hideBanner()">취소</button>
  </div>

  <script>
    function showCartBanner() {
      document.getElementById('bannerMessage').innerText = "장바구니에 담으시겠습니까?";
      document.getElementById('confirmButton').onclick = redirectToCart;
      document.getElementById('overlay').style.display = 'block';
      document.getElementById('confirmBanner').style.display = 'block';
    }

    function checkLogin() {
      <% if (userName == null) { %>
        document.getElementById('bannerMessage').innerText = "로그인이 필요합니다!";
        document.getElementById('confirmButton').onclick = redirectToLogin;
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('confirmBanner').style.display = 'block';
      <% } else { %>
        window.location.href = 'buy.jsp';
      <% } %>
    }

    function hideBanner() {
      document.getElementById('overlay').style.display = 'none';
      document.getElementById('confirmBanner').style.display = 'none';
    }

    function redirectToCart() {
      window.location.href = 'cart.jsp';
    }

    function redirectToLogin() {
      window.location.href = 'login.jsp';
    }
  </script>
  <% 
    if (request.getParameter("logout") != null) {
        session.invalidate();  
        response.sendRedirect("cleansing.jsp");
    }
  %>
</body>
</html>
