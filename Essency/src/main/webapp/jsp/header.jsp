<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Essency.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link href="/Essency/css/layout1.css" rel="stylesheet" type="text/css">
  <style>
    html, body {
      margin: 0;
      padding: 0;
      overflow-x: hidden;
      width: 100%;
      box-sizing: border-box;
    }

    * {
      box-sizing: inherit;
    }
    a {
      text-decoration: none;
      font-weight: bold; 
      color: black;
    }
    a:hover {
      text-decoration: underline;
      color: purple !important;
      transform: scale(1.05);
    }
    .welcome-message {
      color: black;
      font-weight: bold;
    }
    .button {
      padding: 10px 20px;
      background-color: #B8D0FA;
      border: none;
      cursor: pointer;
      font-weight: bold;
      border-radius: 5px;
      transition: transform 0.3s ease, background-color 0.3s ease;
    }
    .button:hover {
      background-color: Skyblue;
      color: purple;
      transform: scale(1.05);
    }
  </style>
</head>
<body>
    <header class="header">
      <div class="h1">
        <% 
        // 세션에서 로그인 사용자 정보 가져오기
        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser != null && loggedInUser.getUsername() != null) {
        %>
          <!-- 로그인한 경우 -->
          <p class="welcome-message"><%= loggedInUser.getUsername() %>님 반갑습니다 😊</p>
          <form action="/Essency/webservice/index.jsp" method="post">
            <button type="submit" name="logout" class="button" style="color: #2c3e50">로그아웃</button>
          </form>
       	  <a href="/Essency/jsp/login.jsp" class="button" style="color: #2c3e50">로그인</a>
        <% } %>
      </div>
      <div class="h2">
        <a href="/Essency/webservice/index.jsp">
          <img src="/Essency/images/logo.png" width="289" height="103" alt="로고">
        </a>
      </div>
    </header>
</body>
</html>
