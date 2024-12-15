<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // 세션에서 로그인된 사용자 확인
    if (session == null || session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("/Essency/jsp/login.jsp");
        return;
    }

    // 사용자 입력 값 가져오기
    String title = request.getParameter("title");
    String author = request.getParameter("author");
    String content = request.getParameter("content");

    // 데이터베이스 연결 설정
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // 글 작성 SQL 실행
        String sql = "INSERT INTO board (title, author, content, created_at) VALUES (?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, author);
        pstmt.setString(3, content);

        int rowsInserted = pstmt.executeUpdate();

        if (rowsInserted > 0) {
            // 성공 시 게시판 목록으로 이동
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
