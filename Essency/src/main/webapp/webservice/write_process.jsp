<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    if (session == null || session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("/Essency/jsp/login.jsp");
        return;
    }

    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String content = request.getParameter("content");
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "INSERT INTO board (title, author, content, created_at) VALUES (?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, author);
        pstmt.setString(3, content);

        int rowsInserted = pstmt.executeUpdate();

        if (rowsInserted > 0) {
            response.sendRedirect("board_list.jsp");
        } else {
            out.println("<script>alert('글 작성에 실패했습니다.'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
