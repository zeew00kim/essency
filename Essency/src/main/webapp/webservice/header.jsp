<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Essency.User"%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>
<link href="layout1.css" rel="stylesheet" type="text/css">
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
	transition: transform 0.3s ease, background-color 0.3s ease;
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
	color: black;
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
			<p class="welcome-message"><%= loggedInUser.getUsername() %>님
				반갑습니다 😊
			</p>
			<form action="index.jsp" method="post" style="float: right;">
    			<button type="submit" name="logout" class="button">로그아웃</button>
			</form>
			<form action="cart.jsp" method="get" style="float: right; margin-right: 10px;">
    			<button type="submit" class="button">장바구니</button>
			</form>
			<div style="clear: both;"></div> <!-- float 해제 -->

			<% } else { %>
			<!-- 로그인하지 않은 경우 -->
			<a href="/Essency/jsp/signUp.jsp" class="button" style="color: #2c3e50">회원가입</a> <a
				href="/Essency/jsp/login.jsp" class="button" style="color: #2c3e50">로그인</a>
			<% } %>
		</div>
		<div class="h2">
			<a href="index.jsp"> <img src="../webservice/image/logo.png"
				width="289" height="103" alt="로고" style="border: none">
			</a>
		</div>
		<nav class="h3">
			<div class="h3_center">
				<a href="all_item.jsp">전체상품</a>&nbsp; <a href="lotion.jsp">로션/크림</a>&nbsp;
				<a href="cleansing.jsp">클렌징</a>&nbsp; <a href="ampoule.jsp">앰플/세럼</a>&nbsp;
				<a href="board_list.jsp">Q&A 게시판</a>
			</div>
			<!-- 특정 URI에서만 삽입 -->
			<% 
           // 현재 요청된 URI 가져오기
           String currentUri = request.getRequestURI();
           // 특정 페이지에만 이미지 삽입
           if (currentUri.contains("/Essency/webservice/board_list.jsp")) { 
        %>
			<div class="h3_right">
				<a href="/Essency/webservice/search.jsp"> <img
					src="../webservice/image/free-icon-font-search-17767794.png"
					width="24" height="24" alt="검색">
				</a> <img src="../webservice/image/free-icon-font-user-17766671.png"
					width="24" height="24" alt="사용자">
			</div>
			<% } %>
		</nav>
	</header>
</body>
</html>
