<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="container">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            int id = Integer.parseInt(request.getParameter("id"));

            try {
                String jdbcUrl = "jdbc:mysql://localhost:3306/essency?useSSL=false&serverTimezone=UTC";
                String dbId = "root";
                String dbPass = "rkdwlgns78?";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

                // 게시글 조회
                String sql = "SELECT * FROM board WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String title = rs.getString("title");
                    String author = rs.getString("author");
                    String content = rs.getString("content");
                    String createdAt = rs.getString("created_at");

                    out.println("<h1>" + title + "</h1>");
                    out.println("<p>작성자: " + author + "</p>");
                    out.println("<p>작성일: " + createdAt + "</p>");
                    out.println("<hr>");
                    out.println("<p>" + content + "</p>");
                }

                // 댓글 조회
                out.println("<h2>댓글</h2>");
                String commentSql = "SELECT * FROM comments WHERE board_id = ? ORDER BY created_at ASC";
                pstmt = conn.prepareStatement(commentSql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();

                out.println("<ul class='comments'>");
                while (rs.next()) {
                    String commentAuthor = rs.getString("author");
                    String commentContent = rs.getString("content");
                    String commentCreatedAt = rs.getString("created_at");

                    out.println("<li>");
                    out.println("<strong>" + commentAuthor + "</strong> (" + commentCreatedAt + "):");
                    out.println("<p>" + commentContent + "</p>");
                    out.println("</li>");
                }
                out.println("</ul>");
            } catch (Exception e) {
                out.println("<p>오류 발생: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
    // 세션에서 로그인한 사용자 정보를 가져오기
    if (loggedInUser != null) {
%>
    <form action="add_comment.jsp" method="post">
        <input type="hidden" name="board_id" value="<%= id %>">
        <label>작성자: 
            <input type="text" name="author" value="${loggedInUser.username}" readonly>
        </label><br>
        <label>내용: 
            <textarea name="content" required></textarea>
        </label><br>
        <input type="submit" value="댓글 작성">
    </form>
<%
    } else {
%>
    <p>댓글을 작성하려면 <a href="login.jsp">로그인</a>하세요.</p>
<%
    }
%>
</body>
</html>
