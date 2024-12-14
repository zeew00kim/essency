<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String content = request.getParameter("content");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
        String dbUser = "root";
        String dbPassword = "root";
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        String query = "INSERT INTO board (title, author, content, created_at) VALUES (?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, title);
        pstmt.setString(2, author);
        pstmt.setString(3, content);
        pstmt.executeUpdate();

        response.sendRedirect("board_list.jsp"); // 게시판 목록으로 리다이렉트
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
