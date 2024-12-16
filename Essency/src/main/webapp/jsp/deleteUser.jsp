<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사용자 삭제</title>
</head>
<body>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    int userId = Integer.parseInt(request.getParameter("user_id"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        String sql = "DELETE FROM users WHERE user_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);

        int rowsDeleted = pstmt.executeUpdate();
        if (rowsDeleted > 0) {
            out.println("<div>사용자가 성공적으로 삭제되었습니다.</div>");
        } else {
            out.println("<div>사용자 삭제에 실패했습니다.</div>");
        }
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>에러: " + e.getMessage() + "</div>");
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("userManage.jsp");
%>
</body>
</html>
