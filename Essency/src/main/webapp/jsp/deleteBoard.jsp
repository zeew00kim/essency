<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 게시글 ID 가져오기
        int id = Integer.parseInt(request.getParameter("id"));

        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // 게시글 삭제 쿼리
        String query = "DELETE FROM board WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, id);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("boardManage.jsp"); // 삭제 후 관리 페이지로 이동
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
