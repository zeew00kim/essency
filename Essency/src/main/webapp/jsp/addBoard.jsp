<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        String query = "INSERT INTO board (title, author, content, created_at) VALUES (?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, title);
        pstmt.setString(2, author);
        pstmt.setString(3, content);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("boardManage.jsp"); 
        } else {
            out.println("<script>alert('등록에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('에러 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
