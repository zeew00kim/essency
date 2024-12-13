<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Essency.User" %>
<%
  // 세션에서 로그인한 사용자 정보 가져오기
  User currentUser = (User) session.getAttribute("loggedInUser");

  if (currentUser == null) {
      response.sendRedirect("login.jsp");
      return;
  }

  // 사용자 이름에서 `user_id` 조회
  String username = currentUser.getUsername();
  String productId = request.getParameter("productId");
  int quantity = Integer.parseInt(request.getParameter("quantity"));

  Connection conn = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
      String dbUser = "root";
      String dbPassword = "root";
      conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

      // `users` 테이블에서 `user_id` 조회
      String userQuery = "SELECT user_id FROM users WHERE username = ?";
      pstmt = conn.prepareStatement(userQuery);
      pstmt.setString(1, username);
      rs = pstmt.executeQuery();

      int userId = 0;
      if (rs.next()) {
          userId = rs.getInt("user_id");
      } else {
          out.println("<p>사용자 정보를 찾을 수 없습니다.</p>");
          return;
      }

      // `cart` 테이블에 데이터 삽입
      String insertQuery = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
      pstmt = conn.prepareStatement(insertQuery);
      pstmt.setInt(1, userId);
      pstmt.setString(2, productId);
      pstmt.setInt(3, quantity);

      int rows = pstmt.executeUpdate();
      if (rows > 0) {
          out.println("<p>장바구니에 상품이 추가되었습니다.</p>");
          response.sendRedirect("cart.jsp");
      } else {
          out.println("<p>장바구니 추가 실패</p>");
      }
  } catch (Exception e) {
      out.println("<p>에러 발생: " + e.getMessage() + "</p>");
  } finally {
      if (rs != null) rs.close();
      if (pstmt != null) pstmt.close();
      if (conn != null) conn.close();
  }
%>
