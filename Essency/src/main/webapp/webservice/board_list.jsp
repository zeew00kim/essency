<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 목록</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="container">
        <h1>게시판</h1>
        <table class="board-table">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Created At</th>
                <th>Comments</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    String jdbcUrl = "jdbc:mysql://localhost:3306/essency?useSSL=false&serverTimezone=UTC";
                    String dbId = "root";
                    String dbPass = "rkdwlgns78?";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

                    String sql = "SELECT b.id, b.title, b.author, b.created_at, " +
                                 "       COUNT(c.id) AS comment_count " +
                                 "FROM board b LEFT JOIN comments c ON b.id = c.board_id " +
                                 "GROUP BY b.id ORDER BY b.created_at DESC";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String createdAt = rs.getString("created_at");
                        int commentCount = rs.getInt("comment_count");

                        out.println("<tr>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td><a href='view.jsp?id=" + id + "'>" + title + "</a></td>");
                        out.println("<td>" + author + "</td>");
                        out.println("<td>" + createdAt + "</td>");
                        out.println("<td>" + commentCount + "</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    out.println("<p>오류 발생: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
        <a class="button" href="write.jsp">글 작성하기</a>
    </div>
    <%@ include file="footer.jsp" %>
    
</body>
</html>
