<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
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
            width: 30%;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        }
        h2 {
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
            transition: background-color 0.3s ease;
        }
        .edit-button button {
            background-color: #B8D0FA;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin: 0 auto;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .edit-button button:hover {
            background-color: skyblue;
            transform: scale(1.05);
            color: purple;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container">
    <h2>마이 페이지</h2>
    <%
        if (loggedInUser == null) { 
    %>
        <p>로그인이 필요합니다. <a href="/Essency/jsp/login.jsp">로그인 페이지로 이동</a></p>
    <%
        } else {            
            String username = loggedInUser.getUsername();
            String email = loggedInUser.getEmail();
            String phone = loggedInUser.getPhone() != null ? loggedInUser.getPhone() : "등록되지 않음";
    %>
            <div class="user-info">
                <p><label>사용자 이름:</label> <%= username %></p>
                <p><label>이메일:</label> <%= email %></p>
                <p><label>전화번호:</label> <%= phone %></p>
            </div>
    <%
        }
    %>

    <% if (loggedInUser != null) { %>
    <div class="edit-button">
        <button onclick="confirmEdit()" style="font-weight: bold">수정하기</button>
    </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>

<script>
    function confirmEdit() {
        const userConfirmed = confirm("정보를 수정하시겠습니까?");
        if (userConfirmed) {
            window.location.href = "editProfile.jsp";
        }
    }
</script>
</body>
</html>