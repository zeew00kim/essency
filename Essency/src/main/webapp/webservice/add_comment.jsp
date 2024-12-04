<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String jdbcUrl = "jdbc:mysql://localhost:3306/essency?useSSL=false&serverTimezone=UTC";
        String dbId = "root";
        String dbPass = "rkdwlgns78?";

        int boardId = Integer.parseInt(request.getParameter("board_id"));
        String author = request.getParameter("author");
        String content = request.getParameter("content");

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

        String sql = "INSERT INTO comments (board_id, author, content) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, boardId);
        pstmt.setString(2, author);
        pstmt.setString(3, content);
        pstmt.executeUpdate();

        response.sendRedirect("view.jsp?id=" + boardId);
    } catch (Exception e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
