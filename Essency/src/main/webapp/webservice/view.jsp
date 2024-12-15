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
        .container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin: 20px auto;
            width: 90%;
            max-width: 1200px;
        }
        .post-container {
            width: 65%;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .post-container h1 {
            font-size: 1.8em;
            margin-bottom: 10px;
            color: #333;
        }
        .post-container p {
            margin: 5px 0;
            font-size: 1em;
            color: #666;
        }
        .post-container hr {
            margin: 10px 0;
            border: none;
            height: 1px;
            background-color: #ddd;
        }
        .comment-container {
            width: 30%;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .comment-container textarea, .comment-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            display: inline-block;
            padding: 8px 12px;
            margin: 0;
            margin-top: 10px;
            color: white;
            font-weight: bold;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            transition: background-color 0.3s;
            float: right;
        }
        .btn-delete {
    		background-color: #B8D0FA;
    		border: none;
    		cursor: pointer;
    		color: black;
    		font-weight: bold;
    		border-radius: 5px;
    		transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .btn-delete:hover {
            background-color: #c82333;
    		color: white !important;
    		transform: scale(1.05);
    		text-decoration: none;
        }
        .btn-edit {
            background-color: #B8D0FA;
    		border: none;
    		cursor: pointer;
    		color: black;
    		font-weight: bold;
    		border-radius: 5px;
    		transition: transform 0.3s ease, background-color 0.3s ease;
    		margin-right: 10px;
        }
        .btn-edit:hover {
            background-color: #0056b3;
            color: white !important;
    		transform: scale(1.05);
    		text-decoration: none;
        }
        .btn-comment {
        	background-color: #B8D0FA;
    		border: none;
    		cursor: pointer;
    		color: black;
    		font-weight: bold;
    		border-radius: 5px;
    		transition: transform 0.3s ease, background-color 0.3s ease;
    		margin-right: 10px;
        }
        .btn-comment:hover {
        	background-color: skyblue;
            color: purple !important;
    		transform: scale(1.05);
    		text-decoration: none;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
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
        <h1 style="text-align: center; color: #333; margin-bottom: 10px;">
            <%= rs.getString("title") %>
        </h1><br>
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; border-bottom: 1px solid #ddd; padding-bottom: 10px;">
            <p style="font-weight: bold; color: #555; margin: 0;">작성자: <%= postAuthor %></p>
            <p style="font-weight: bold; color: #555; margin: 0;">작성일: <%= rs.getString("created_at") %></p>
        </div>
        <p style="margin-top: 20px; color: #333;">
            <%= rs.getString("content") %>
        </p>

        <%-- 수정 및 삭제 버튼: 로그인한 사용자와 작성자 일치 시 표시 --%>
        <% if (loggedInUser.getUsername().equals(postAuthor)) { %>
        <div style="margin-top: 20px;">
            <a href="delete_post.jsp?id=<%= id %>" class="btn btn-delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            <a href="edit_post.jsp?id=<%= id %>" class="btn btn-edit" onclick="return confirm('수정하시겠습니까?');">수정</a>
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

    <%-- 댓글 작성 폼 --%>
    <div class="comment-container">
        <h2>댓글 작성</h2>
        <form action="add_comment.jsp" method="post">
            <input type="hidden" name="board_id" value="<%= id %>">
            <label>작성자:</label>
            <input type="text" name="author" value="<%= loggedInUser.getUsername() %>" readonly>
            <label>내용:</label>
            <textarea name="content" rows="4" required></textarea>
            <input type="submit" value="댓글 작성" class="btn-comment">
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
