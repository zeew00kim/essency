<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Essency.User" %>

<%
  int productId = Integer.parseInt(request.getParameter("product_id"));
  User currentUser = (User) session.getAttribute("loggedInUser");

  if (currentUser == null) {
      response.sendRedirect("login.jsp");
      return;
  }

  String username = currentUser.getUsername();

  Connection conn = null;
  PreparedStatement pstmt = null;

  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
      String dbUser = "root";
      String dbPassword = "root";
      conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

      // 사용자 ID 가져오기
      String userQuery = "SELECT user_id FROM users WHERE username = ?";
      pstmt = conn.prepareStatement(userQuery);
      pstmt.setString(1, username);
      ResultSet userRs = pstmt.executeQuery();
      int userId = 0;

      if (userRs.next()) {
          userId = userRs.getInt("user_id");
      }

      // cart 테이블에서 항목 삭제
      String deleteQuery = "DELETE FROM cart WHERE user_id = ? AND product_id = ?";
      pstmt = conn.prepareStatement(deleteQuery);
      pstmt.setInt(1, userId);
      pstmt.setInt(2, productId);

      int rowsAffected = pstmt.executeUpdate();

      if (rowsAffected > 0) {
          out.println("<script>alert('상품이 성공적으로 삭제되었습니다.'); location.href='cart.jsp';</script>");
      } else {
          out.println("<script>alert('상품 삭제에 실패하였습니다.'); location.href='cart.jsp';</script>");
      }

  } catch (Exception e) {
      out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); location.href='cart.jsp';</script>");
  } finally {
      if (pstmt != null) pstmt.close();
      if (conn != null) conn.close();
  }
%>
