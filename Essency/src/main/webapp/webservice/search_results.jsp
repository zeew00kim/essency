<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>검색 결과</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #f4f4f4;
        }
        a {
            text-decoration: none;
            color: #007bff;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h1>검색 결과</h1>
        <table>
            <tr>
                <th>ID</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                String search = request.getParameter("search"); 
                String filter = request.getParameter("filter"); 

                try {
                    String jdbcUrl = "jdbc:mysql://localhost:3306/essency?useSSL=false&serverTimezone=UTC";
                    String dbId = "root";
                    String dbPass = "rkdwlgns78?";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

                    String sql = "";
                    if ("title".equals(filter)) {
                        sql = "SELECT * FROM board WHERE title LIKE ?";
                    } else if ("author".equals(filter)) {
                        sql = "SELECT * FROM board WHERE author LIKE ?";
                    } else if ("title_author".equals(filter)) {
                        sql = "SELECT * FROM board WHERE title LIKE ? OR author LIKE ?";
                    }

                    pstmt = conn.prepareStatement(sql);
                    if ("title_author".equals(filter)) {
                        pstmt.setString(1, "%" + search + "%");
                        pstmt.setString(2, "%" + search + "%");
                    } else {
                        pstmt.setString(1, "%" + search + "%");
                    }

                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String createdAt = rs.getString("created_at");

                        out.println("<tr>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td><a href='view.jsp?id=" + id + "'>" + title + "</a></td>");
                        out.println("<td>" + author + "</td>");
                        out.println("<td>" + createdAt + "</td>");
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
        <p><a href="search.jsp">다시 검색하기</a></p>
    </div>
        <%@ include file="footer.jsp" %>
    
</body>
</html>
