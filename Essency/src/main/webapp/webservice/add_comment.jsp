<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 세션에서 userId 가져오기
    Integer userId = (Integer) session.getAttribute("userId"); // 세션에 저장된 사용자 ID
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 파라미터 값 가져오기
    request.setCharacterEncoding("UTF-8");
    int boardId = Integer.parseInt(request.getParameter("board_id")); // 게시글 ID
    String content = request.getParameter("content"); // 댓글 내용

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 데이터베이스 연결 정보
        String jdbcUrl = "jdbc:mysql://localhost:3306/team_project";
        String dbUser = "root";
        String dbPass = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

        // 댓글 삽입 SQL 쿼리
        String sql = "INSERT INTO comments (user_id, board_id, content, created_at) VALUES (?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId); // 세션에서 가져온 사용자 ID
        pstmt.setInt(2, boardId); // 게시글 ID
        pstmt.setString(3, content); // 댓글 내용

        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.sendRedirect("view.jsp?id=" + boardId); // 댓글 등록 후 게시글 페이지로 이동
        } else {
            out.println("<p>댓글 등록에 실패했습니다.</p>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
    } finally {
        // 자원 해제
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
