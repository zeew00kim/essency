<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DB 연결 테스트</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <h1>DB 연결 테스트</h1>
    <%
        String jdbcUrl = "jdbc:mysql://localhost:3306/webprogramming";
        String jdbcUser = "root";
        String jdbcPassword = "root";
        java.sql.Connection conn = null;
        java.sql.Statement stmt = null;
        java.sql.ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection(jdbcUrl, jdbcUser, jdbcPassword);
            out.println("<p class='success'>[성공] 데이터베이스 연결 성공!</p>");            
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SHOW TABLES");
            out.println("<h2>테이블 목록:</h2>");
            out.println("<ul>");
            while (rs.next()) {
                out.println("<li>" + rs.getString(1) + "</li>");
            }
            out.println("</ul>");
        } catch (Exception e) {
            out.println("<p class='error'>[실패] 데이터베이스 연결 실패: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                out.println("<p class='error'>[경고] 리소스 해제 중 오류 발생: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
