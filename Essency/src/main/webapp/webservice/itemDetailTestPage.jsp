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
    .button {
      padding: 10px 20px;
      background-color: #b8d0fa;
      cursor: pointer;
      color: black;
      border: none;
      font-weight: bold;
      border-radius: 5px;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }
    .button:hover {
      background-color: skyblue;
      color: purple;
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
    .main_footer img {
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      width: auto;
      height: auto;
      display: block;
      margin: 5px auto;
    }
    .confirm-banner {
      display: none;
      position: fixed;
      top: 30%;
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: white;
      border: 2px solid #b8d0fa;
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
      background-color: #b8d0fa;
      color: black;
    }
    .confirm-banner .confirm:hover {
      background-color: skyblue;
      color: purple;
    }
    .confirm-banner .cancel {
      background-color: #ccc;
      color: black;
    }
    .confirm-banner .cancel:hover {
      background-color: #999;
      color: purple;
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
    <%@ include file="header.jsp" %>

    <main class="main">
      <section class="m2">
        <div class="m2_left">
          <img src="../webservice/image/KakaoTalk_20241127_111509868_02.jpg" alt="제품 이미지" width="300" height="400">
        </div>
        <div class="m2_right">
          <span class="product-name">제품명</span>
          <span class="product-price">판매 가격 15,000원</span>
          <span class="shipping-fee">배송비 2,500원</span>
          <span class="shipping-fee">배송일 결제 후 7일 이내 도착예정</span>
          <span class="shipping-fee">배송/출고 cj대한통운(오네)</span>
          <div class="buttons">
            <button class="button" onclick="addToCart()">장바구니에 담기</button>
            <button class="button" onclick="checkLogin()">구매하기</button>
          </div>
        </div>
      </section>
      <div class="main_footer">
        <div class="mf1">
          <img src="image/KakaoTalk_20241207_142012247_01.jpg" alt="상세정보 이미지 1">
        </div>
        <div class="mf2">
          <img src="image/KakaoTalk_20241207_142012247_04.jpg" alt="상세정보 이미지 2">
        </div>
        <div class="mf3">          
          <img src="image/KakaoTalk_20241207_142012247.jpg" alt="멤버십 혜택 이미지">
        </div>
        <div class="mf4">
          <img src="image/KakaoTalk_20241207_142012247_03.jpg" alt="상품정보 이미지">
        </div>
      </div>
    </main>

    <%@ include file="footer.jsp" %>
  </div>

  <div class="overlay" id="overlay"></div>
  <div class="confirm-banner" id="confirmBanner">
    <p id="bannerMessage">로그인이 필요합니다!</p>
    <button class="confirm" id="confirmButton">확인</button>
    <button class="cancel" onclick="hideBanner()">취소</button>
  </div>

  <script>
    const userName = '<%= (String) session.getAttribute("userName") %>'; // JSP 세션 변수 -> JavaScript 변수로 전달

    function addToCart() {
      if (!userName || userName === 'null') {
        showBanner("로그인이 필요합니다!", redirectToLogin);
      } else {
        window.location.href = 'cart.jsp';
      }
    }

    function checkLogin() {
      if (!userName || userName === 'null') {
        showBanner("로그인이 필요합니다!", redirectToLogin);
      } else {
        window.location.href = 'buy.jsp';
      }
    }

    function showBanner(message, confirmAction) {
      document.getElementById('bannerMessage').innerText = message;
      document.getElementById('confirmButton').onclick = confirmAction;
      document.getElementById('overlay').style.display = 'block';
      document.getElementById('confirmBanner').style.display = 'block';
    }

    function hideBanner() {
      document.getElementById('overlay').style.display = 'none';
      document.getElementById('confirmBanner').style.display = 'none';
    }

    function redirectToLogin() {
      window.location.href = '<%= request.getContextPath() %>/jsp/login.jsp';
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