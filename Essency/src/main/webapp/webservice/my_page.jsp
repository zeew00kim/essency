<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이 페이지</title>
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
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .user-info {
            margin: 20px 0;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .user-info label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
            color: #555;
        }
        .user-info p {
            margin: 10px 0;
            font-size: 16px;
            color: #333;
        }
        .edit-button {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }
        .edit-button a {
            text-decoration: none;
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        .edit-button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container">
    <h1>마이 페이지</h1>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 로그인된 사용자의 ID (예: 세션에서 가져오기)
        int userId = 1; // 예시: 1번 사용자

        try {
            // 데이터베이스 연결 정보
            String jdbcUrl = "jdbc:mysql://localhost:3306/essency?useSSL=false&serverTimezone=UTC";
            String dbId = "root";
            String dbPass = "rkdwlgns78?";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

            // 사용자 정보 가져오기
            String sql = "SELECT * FROM users WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String username = rs.getString("username");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String role = rs.getString("role");

                out.println("<div class='user-info'>");
                out.println("<p><label>사용자 이름:</label> " + username + "</p>");
                out.println("<p><label>이메일:</label> " + email + "</p>");
                out.println("<p><label>전화번호:</label> " + phone + "</p>");
                out.println("<p><label>역할:</label> " + role + "</p>");
                out.println("</div>");
            } else {
                out.println("<p>사용자 정보를 찾을 수 없습니다.</p>");
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

    <div class="edit-button">
        <a href="edit_user.jsp?id=<%= userId %>">수정하기</a>
    </div>
</div>
<%@ include file="footer.jsp" %>

</body>
</html>
