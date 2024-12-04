<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // 세션에서 로그인된 사용자 확인
    if (session == null || session.getAttribute("loggedInUser") == null) {
        // 로그인되어 있지 않으면 로그인 페이지로 리다이렉트
        response.sendRedirect("/Essency/jsp/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 작성하기</title>
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
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        form {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }
        label {
            display: block;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }
        textarea {
            resize: none;
        }
        input[type="submit"] {
            display: block;
            width: 100%;
            padding: 10px 0;
            font-size: 16px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h2>글 작성하기</h2>
        <form action="write_process.jsp" method="post">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>

            <label for="author">작성자:</label>
            <input type="text" id="author" name="author" value="<%= ((Essency.User)session.getAttribute("loggedInUser")).getUsername() %>" readonly>

            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="10" placeholder="내용을 입력하세요" required></textarea>

            <input type="submit" value="글 작성">
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
