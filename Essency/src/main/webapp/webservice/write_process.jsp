<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*"%>

<%
  Connection conn = null;
  PreparedStatement pstmt = null;

  try {
    String jdbcUrl = "jdbc:mysql://localhost:3306/essency?useSSL=false&serverTimezone=UTC";
    String dbId = "root";
    String dbPass = "rkdwlgns78?";

    // 사용자 입력값 받기
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String content = request.getParameter("content");

    // DB 연결 및 쿼리 실행
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
    String sql = "INSERT INTO board (title, author, content) VALUES (?, ?, ?)";
    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, title);
    pstmt.setString(2, author);
    pstmt.setString(3, content);
    pstmt.executeUpdate();

    // 글 목록으로 리다이렉트
    response.sendRedirect("board_list.jsp");

  } catch (Exception e) {
    out.println("<p>글 작성 중 오류 발생: " + e.getMessage() + "</p>");
    e.printStackTrace();
  } finally {
    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
  }
%>
