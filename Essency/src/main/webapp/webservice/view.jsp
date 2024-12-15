<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Essency.User"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }
        .post-container {
            width: 45%;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin: 80px auto;
        }
        .post-container h1 {
            font-size: 1.8em;
            margin-bottom: 10px;
            color: #333;
            text-align: center;
        }
        .post-container .info {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        .post-container p {
            margin: 5px 0;
            font-size: 1em;
            color: #666;
        }
        .btn-container {
            margin-top: 20px;
            text-align: right;
        }
        .btn-edit {
            display: inline-block;
            padding: 8px 12px;
            background-color: #B8D0FA;
    		border: none;
    		cursor: pointer;
    		font-size: 14px;
    		font-weight: bold;
    		border-radius: 5px;
    		transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .btn-edit:hover {
            background-color: skyblue;
            color: black;
            transform: scale(1.05);
            text-decoration: none;
        }
        .btn-delete {
            display: inline-block;
            padding: 8px 12px;
            margin-left: 5px;
            background-color: #B8D0FA;
    		border: none;
    		cursor: pointer;
    		font-size: 14px;
    		font-weight: bold;
    		border-radius: 5px;
    		transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .btn-delete:hover {
            background-color: #a71d2a;
            color: white !important;
            transform: scale(1.05);
            text-decoration: none;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
    <%-- 게시글 내용 --%>
    <div class="post-container">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            loggedInUser = (User) session.getAttribute("loggedInUser");
            if (loggedInUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int id = Integer.parseInt(request.getParameter("id"));
            String postAuthor = "";

            try {
                String jdbcUrl = "jdbc:mysql://localhost:3306/team_project";
                String dbId = "root";
                String dbPass = "root";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

                String sql = "SELECT * FROM board WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    postAuthor = rs.getString("author");
        %>
        <h1><%= rs.getString("title") %></h1>
        <br>
        <div class="info">
            <p style="color: #444444">작성자 : <strong><%= postAuthor %></strong></p>
            <p style="color: #444444">작성일 : <strong><%= rs.getString("created_at") %></strong></p>
        </div>
        <p style="color: #444444; margin-bottom: 30px;"><%= rs.getString("content") %></p>

        <%-- 수정 및 삭제 버튼: 로그인한 사용자와 작성자 일치 시 표시 --%>
        <% if (loggedInUser.getUsername().equals(postAuthor)) { %>
        <div class="btn-container">
            <a href="edit_post.jsp?id=<%= id %>" class="btn-edit">수정</a>
            <a href="delete_post.jsp?id=<%= id %>" class="btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        </div>
        <% } %>
        <%
                }
            } catch (Exception e) {
        %>
        <p style="color: red;">오류 발생: <%= e.getMessage() %></p>
        <%
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
<%@ include file="footer.jsp" %>
</body>
</html>
