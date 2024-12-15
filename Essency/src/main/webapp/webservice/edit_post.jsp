<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="Essency.User"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 수정</title>
    <style>
        /* 전체 페이지 스타일 */
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            background-color: #f9f9f9;
        }
        /* 메인 컨테이너 */
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        /* 제목 스타일 */
        .container h2 {
            text-align: center;
            font-size: 1.8em;
            color: #333;
            margin-bottom: 20px;
        }
        /* 라벨과 입력 필드 */
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        textarea {
            resize: none;
        }
        /* 버튼 스타일 */
        .btn-submit {
            display: inline-block;
            padding: 10px 20px;
            background-color: #B8D0FA;
    		border: none;
    		cursor: pointer;
    		color: black;
    		font-weight: bold;
    		border-radius: 5px;
    		transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: skyblue;
    		color: purple !important;
    		transform: scale(1.05);
    		text-decoration: none;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    int postId = Integer.parseInt(request.getParameter("id"));
    loggedInUser = (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String title = "";
    String content = "";

    try {
        // 데이터베이스 연결
        String jdbcUrl = "jdbc:mysql://localhost:3306/team_project";
        String dbId = "root";
        String dbPass = "root";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

        // 기존 게시글 조회
        String sql = "SELECT title, content, author FROM board WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, postId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            if (!loggedInUser.getUsername().equals(rs.getString("author"))) {
                response.sendRedirect("view.jsp?id=" + postId);
                return;
            }
            title = rs.getString("title");
            content = rs.getString("content");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<div class="container">
    <h2>게시글 수정</h2>
    <form action="update_post.jsp" method="post">
        <input type="hidden" name="id" value="<%= postId %>">

        <!-- 제목 입력 -->
        <label for="title">제목:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required>

        <!-- 내용 입력 -->
        <label for="content">내용:</label>
        <textarea id="content" name="content" rows="10" required><%= content %></textarea>

        <!-- 수정 완료 버튼 -->
        <div style="text-align: right;">
            <input type="submit" value="수정 완료" class="btn-submit">
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
