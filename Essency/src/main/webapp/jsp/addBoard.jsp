<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 요청으로부터 데이터 가져오기
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");

        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // 게시글 추가 쿼리
        String query = "INSERT INTO board (title, author, content, created_at) VALUES (?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, title);
        pstmt.setString(2, author);
        pstmt.setString(3, content);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("boardManage.jsp"); // 등록 후 관리 페이지로 이동
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
