<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Essency.User" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>구매 목록</title>
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

    .buy-table {
      width: 80%;
      margin: 20px auto;
      border-collapse: collapse;
      border: solid silver 2px;
    }

    .buy-table th, .buy-table td {
      border: solid silver 2px;
      padding: 10px;
      text-align: center;
      font-size: 20px;
    }

    .buy-table th {
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
  <%@ include file="header.jsp" %>

  <main class="main">
    <h1 class="m1">구매 목록</h1>
    <table class="buy-table">
      <thead>
        <tr>
          <th>제품</th>
          <th>수량</th>
          <th>판매 가격</th>
          <th>배송비</th>
          <th>총 가격</th>
          <th>주문 일자</th>
        </tr>
      </thead>
      <tbody>
        <%
          User currentUser = (User) session.getAttribute("loggedInUser");
          int totalOrderPrice = 0;

          if (currentUser != null) {
              String username = currentUser.getUsername();
              Connection conn = null;
              PreparedStatement pstmt = null;
              ResultSet rs = null;

              try {
                  Class.forName("com.mysql.cj.jdbc.Driver");
                  String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
                  String dbUser = "root";
                  String dbPassword = "root";
                  conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                  String query = "SELECT oi.product_id, p.product_name, oi.quantity, oi.price, p.shipping_charge, o.created_at " +
                                 "FROM orders o " +
                                 "JOIN order_items oi ON o.order_id = oi.order_id " +
                                 "JOIN products p ON oi.product_id = p.product_id " +
                                 "WHERE o.user_id = (SELECT user_id FROM users WHERE username = ?)";
                  pstmt = conn.prepareStatement(query);
                  pstmt.setString(1, username);
                  rs = pstmt.executeQuery();

                  boolean hasOrders = false;

                  while (rs.next()) {
                      hasOrders = true;
                      String productName = rs.getString("product_name");
                      int quantity = rs.getInt("quantity");
                      int price = rs.getInt("price");
                      int shippingCharge = rs.getInt("shipping_charge");
                      int total = price + shippingCharge;
                      String createdAt = rs.getString("created_at");

                      totalOrderPrice += total;

                      %>
                      <tr style="background-color: #f8f8f8">
                          <td>
                            <a href="<%= request.getContextPath() %>/webservice/itemdetail.jsp?productId=<%= rs.getInt("product_id") %>">
                              <!-- 제품 이미지 -->
                              <img src="<%= request.getContextPath() %>/webservice/image/<%= productName %>.jpg" 
                                   alt="<%= productName %>" class="product-img" style="margin-bottom: -5px;"><br>
                              <%= productName %>
                            </a>
                          </td>
                          <td><%= quantity %></td>
                          <td><%= price %>원</td>
                          <td><%= shippingCharge %>원</td>
                          <td><%= total %>원</td>
                          <td><%= createdAt %></td>
                      </tr>
                      <%
                  }

                  if (!hasOrders) {
                      %>
                      <tr>
                          <td colspan="6">구매 내역이 없습니다.</td>
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
    <div class="total-section" style="font-size: 20px;">
      총 결제 금액 : <%= totalOrderPrice %>원
    </div>
    <% } %>
  </main>
  <%@ include file="footer.jsp" %>
</body>
</html>
