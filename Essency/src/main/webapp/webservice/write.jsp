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
    <link rel="stylesheet" href="layout1.css"> <!-- 헤더 관련 CSS -->
    <style>
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
        .write-container input[type="button"] {
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
        .write-container input[type="button"]:hover {
            background-color: #0056b3;
        }
        /* 배너 스타일 */
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        .confirm-banner {
            display: none;
            position: fixed;
            top: 30%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            border: 2px solid #B8D0FA;
            border-radius: 10px;
            padding: 20px;
            width: 300px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
        .confirm-banner button {
            margin: 10px;
            padding: 10px 20px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .confirm-banner .confirm {
            background-color: #B8D0FA;
            color: black;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .confirm-banner .confirm:hover {
            background-color: Skyblue;
            color: purple;
            transform: scale(1.05);
        }
        .confirm-banner .cancel {
            background-color: #ccc;
            color: black;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }
        .confirm-banner .cancel:hover {
            background-color: #999;
            color: purple;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="write-container">
        <h2>글 작성하기</h2>
        <form id="writeForm" action="write_process.jsp" method="post">
            <label for="title">제목:</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력하세요" required>

            <label for="author">작성자:</label>
            <input type="text" id="author" name="author" value="<%= ((Essency.User)session.getAttribute("loggedInUser")).getUsername() %>" readonly>

            <label for="content">내용:</label>
            <textarea id="content" name="content" rows="10" placeholder="내용을 입력하세요" required></textarea>

            <input type="button" value="글 작성" onclick="showConfirmBanner()">
        </form>
    </div>

    <!-- 배너 -->
    <div class="overlay" id="overlay"></div>
    <div class="confirm-banner" id="confirmBanner">
        <p>글을 등록하시겠습니까?</p>
        <button class="confirm" onclick="submitForm()">확인</button>
        <button class="cancel" onclick="hideConfirmBanner()">취소</button>
    </div>

    <%@ include file="footer.jsp" %>

    <script>
        // 배너 보이기
        function showConfirmBanner() {
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('confirmBanner').style.display = 'block';
        }

        // 배너 숨기기
        function hideConfirmBanner() {
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('confirmBanner').style.display = 'none';
        }

        // 폼 제출
        function submitForm() {
            document.getElementById('writeForm').submit(); // write_process.jsp로 이동
        }
    </script>
</body>
</html>
