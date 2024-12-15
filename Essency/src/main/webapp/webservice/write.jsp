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
    <title>게시판 페이지</title>
    <link rel="stylesheet" href="layout1.css"> <!-- 헤더 관련 CSS -->
    <style>
        /* 페이지에만 영향을 미치는 스타일 */
        .write-container {
            font-family: Arial, sans-serif;
            margin: 20px auto;
            padding: 20px;
            width: 40%;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .write-container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        .write-container form {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
        }
        .write-container label {
            display: block;
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }
        .write-container input[type="text"], .write-container textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 20px;
            box-sizing: border-box;
        }
        .write-container textarea {
            resize: none;
        }
        .write-container input[type="submit"] {
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
        .write-container input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .btn1 {
        	padding: 10px 20px !important;
    		background-color: #B8D0FA !important;
    		border: none !important;
    		cursor: pointer !important;
    		color: black !important;
    		font-weight: bold !important;
    		border-radius: 5px !important;
    		transition: transform 0.3s ease, background-color 0.3s ease !important;
    		width: 20% !important;
    		margin: 0 auto;
        }
        .btn1:hover {
    		background-color: Skyblue !important;
    		color: purple !important;
    		transform: scale(1.05) !important;
		}       
    </style>
    <script>
        function confirmSubmit() {
            return confirm("글을 작성하시겠습니까?");
        }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="write-container">
        <h2>자유롭게 글을 작성해주세요 😁</h2>
        <form action="write_process.jsp" method="post" onsubmit="return confirmSubmit();">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>

            <label for="author">작성자:</label>
            <input type="text" id="author" name="author" value="<%= ((Essency.User)session.getAttribute("loggedInUser")).getUsername() %>" readonly>

            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="10" placeholder="내용을 입력하세요" required></textarea>

            <input type="submit" class="btn1" value="등 록">
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
