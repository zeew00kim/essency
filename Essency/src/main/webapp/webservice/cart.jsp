<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Essency.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>장바구니</title>
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
      background-color: #B8D0FA;
      border: none;
      cursor: pointer;
      color: black;
      font-weight: bold;
      border-radius: 5px;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }

    .button:hover {
      background-color: Skyblue;
      color: purple;
      transform: scale(1.05);
    }

    .delete-btn {
      padding: 8px 12px;
      background-color: silver;
      border: none;
      cursor: pointer;
      color: black;
      font-weight: bold;
      border-radius: 5px;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }

    .delete-btn:hover {
      background-color: #f05252;
      color: purple;
      transform: scale(1.05);
    }

    .cart-table {
      width: 80%;
      margin: 20px auto;
      border-collapse: collapse;
      border: solid silver 2px;
    }

    .cart-table th, .cart-table td {
      border: solid silver 2px;
      padding: 10px;
      text-align: center;
      font-size: 20px;
    }

    .cart-table th {
      background-color: #B8D0FA;
      font-weight: bold;
    }

    .product-img {
      width: 80px;
      height: 80px;
      object-fit: cover;
      border-radius: 10px;
      margin-bottom: 5px;
    }

    .total-section {
      text-align: right;
      margin-right: 10%;
      font-size: 1.5em;
      font-weight: bold;
      margin-top: 20px;
    }
  </style>
</head>
<body>
  <!-- Header 포함 -->
  <%@ include file="header.jsp" %>

  <main class="main">
    <h1 class="m1">장바구니</h1>

    <table class="cart-table">
      <thead>
        <tr>
          <th>제품</th>
          <th>수량</th>
          <th>판매 가격</th>
          <th>배송비</th>
          <th>총 가격</th>
          <th>삭제</th>
        </tr>
      </thead>
      <tbody>
        <%
          User currentUser = (User) session.getAttribute("loggedInUser");
          int totalPrice = 0; // 총 결제 금액

          if (currentUser != null) {
              String username = currentUser.getUsername(); // 사용자 이름으로 식별
              Connection conn = null;
              PreparedStatement pstmt = null;
              ResultSet rs = null;

              try {
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
                  String dbUser = "root";
                  String dbPassword = "root";
                  conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                  // cart와 products 테이블을 조인하여 데이터 가져오기
                  String query = "SELECT p.product_name, c.quantity, p.sale_price, p.shipping_charge, c.product_id " +
                                 "FROM cart c " +
                                 "JOIN products p ON c.product_id = p.product_id " +
                                 "WHERE c.user_id = (SELECT user_id FROM users WHERE username = ?)";
                  pstmt = conn.prepareStatement(query);
                  pstmt.setString(1, username);
                  rs = pstmt.executeQuery();

                  boolean hasItems = false;

                  while (rs.next()) {
                      hasItems = true;
                      String productName = rs.getString("product_name");
                      int quantity = rs.getInt("quantity");
                      int salePrice = rs.getInt("sale_price");
                      int shippingCharge = rs.getInt("shipping_charge");
                      int productId = rs.getInt("product_id");
                      int total = (salePrice * quantity) + shippingCharge;

                      totalPrice += total;

                      %>
                      <tr style="background-color: #f8f8f8">
                          <td>
                            <a href="<%= request.getContextPath() %>/webservice/itemdetail.jsp?productId=<%= productId %>">
                              <!-- 제품 이미지 -->
                              <img src="<%= request.getContextPath() %>/webservice/image/<%= productName %>.jpg" 
                                   alt="<%= productName %>" class="product-img" style="margin-bottom: -5px;"><br>
                              <%= productName %>
                            </a>
                          </td>
                          <td><%= quantity %></td>
                          <td><%= salePrice %>원</td>
                          <td><%= shippingCharge %>원</td>
                          <td><%= total %>원</td>
                          <td>
                            <!-- 삭제 버튼 -->
                            <form action="deleteCartItem.jsp" method="POST" style="display:inline;" onsubmit="return confirm('해당 제품을 삭제하시겠습니까?')">
                              <input type="hidden" name="product_id" value="<%= productId %>">
                              <button type="submit" class="delete-btn">삭제</button>
                            </form>
                          </td>
                      </tr>
                      <%
                  }

                  if (!hasItems) {
                      %>
                      <tr>
                          <td colspan="6">장바구니가 비어 있습니다.</td>
                      </tr>
                      <%
                  }
              } catch (Exception e) {
                  out.println("<p>에러 발생: " + e.getMessage() + "</p>");
              } finally {
                  if (rs != null) rs.close();
                  if (pstmt != null) pstmt.close();
                  if (conn != null) conn.close();
              }
          } else {
              %>
              <tr>
                  <td colspan="6">로그인이 필요합니다.</td>
              </tr>
              <%
          }
        %>
      </tbody>
    </table>

    <% if (currentUser != null) { %>
    <div class="total-section" style="font-size: 20px">
      담긴 상품의 총액 : <%= totalPrice %>원
    </div>
    <% } %>
  </main>

  <!-- Footer 포함 -->
  <%@ include file="footer.jsp" %>
</body>
</html>
