<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Essency.User, java.sql.*" %>
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
    .product-price, .shipping-fee, .total-price {
      font-size: 1.2em;
      margin-top: 10px;
      display: block;
    }
    .buttons {
      margin-top: 20px;
      display: flex;
      gap: 10px;
    }
    .product-image img {
      width: 300px;
      height: 400px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .main_footer img {
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      width: auto;
      height: auto;
      display: block;
      margin: 5px auto;
    }
  </style>
</head>
<body>
  <div class="wrap">
    <%@ include file="header.jsp" %>

    <% 
    // 로그인된 사용자 정보
    User currentUser = (User) session.getAttribute("loggedInUser");
    String userName = (currentUser != null) ? currentUser.getUsername() : "null";
	%>
	
    <main class="main">
      <section class="m2">
        <div class="product-image">
          <%
            // 상품 ID를 URL에서 가져옴
            String productId = request.getParameter("productId");

            // 데이터베이스 연결 설정
            String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
            String dbUser = "root";
            String dbPassword = "root";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String productName = "";
            int salePrice = 0;
            int shippingCharge = 0;
            String imagePath = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // 상품 정보 조회
                String query = "SELECT product_name, sale_price, shipping_charge FROM products WHERE product_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, productId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    productName = rs.getString("product_name");
                    salePrice = rs.getInt("sale_price");
                    shippingCharge = rs.getInt("shipping_charge");
                    imagePath = request.getContextPath() + "/webservice/image/" + productName + ".jpg";
                }
            } catch (Exception e) {
                out.println("<p>에러 발생: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
          %>
          <img src="<%= imagePath %>" alt="<%= productName %>">
        </div>
        <div class="product-info" style="margin-left: 50px;">
          <span class="product-name"><%= productName %></span>
          <span class="product-price">판매 가격 : <%= salePrice %>원</span>
          <span class="shipping-fee">배송비 : <%= shippingCharge %>원</span>
          <span class="total-price">결제 총액 : <%= salePrice + shippingCharge %>원</span>
          <div class="buttons">
            <form action="addToCart.jsp" method="post" onsubmit="return showBanner()">
              <input type="hidden" name="productId" value="<%= productId %>">
              <input type="hidden" name="quantity" value="1"> <!-- 기본 수량 설정 -->
              <button type="submit" class="button">장바구니에 담기</button>
            </form>
            <form action="processOrder.jsp" method="post" onsubmit="return confirmPurchase()">
    			<input type="hidden" name="productId" value="<%= productId %>">
    			<input type="hidden" name="quantity" value="1">
    			<input type="hidden" name="totalPrice" value="<%= salePrice + shippingCharge %>">
    			<button type="submit" class="button">구매하기</button>
		 	</form>
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
  </div>

  <script>
    const userName = '<%= userName %>'; // 서버에서 전달된 세션 값 사용

    function showBanner() {
        if (userName === 'null') {
            alert("로그인이 필요합니다!");
            window.location.href = '<%= request.getContextPath() %>/jsp/login.jsp'; // 경로 수정
            return false;
        }
        return confirm("장바구니에 추가하시겠습니까?");
    }

    function confirmPurchase() {
        if (userName === 'null') {
            alert("로그인이 필요합니다!");
            window.location.href = '<%= request.getContextPath() %>/jsp/login.jsp'; // 경로 수정
            return false;
        }
        if (confirm("해당 상품을 구매하시겠습니까?")) {
            alert("감사합니다. 구매가 완료되었습니다. 🥰");
            return true; // 폼 제출 허용
        }
    }
</script>
</body>
</html>