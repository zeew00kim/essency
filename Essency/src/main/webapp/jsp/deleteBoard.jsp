<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        int id = Integer.parseInt(request.getParameter("id"));

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        String query = "DELETE FROM board WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, id);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("boardManage.jsp");
        } else {
            out.println("<script>alert('삭제에 실패했습니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('에러 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
