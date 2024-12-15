<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Essency.User"%>
<%
    Connection conn = null;
    PreparedStatement pstmt = null;

    int postId = Integer.parseInt(request.getParameter("id"));
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        String jdbcUrl = "jdbc:mysql://localhost:3306/team_project";
        String dbId = "root";
        String dbPass = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

        // 작성자 확인 및 삭제 쿼리
        String sql = "DELETE FROM board WHERE id = ? AND author = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, postId);
        pstmt.setString(2, loggedInUser.getUsername());

        int result = pstmt.executeUpdate();
        if (result > 0) {
            response.sendRedirect("board_list.jsp"); // 삭제 후 게시판 목록으로 이동
        } else {
            out.println("<script>alert('삭제 권한이 없거나 이미 삭제된 게시글입니다.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
