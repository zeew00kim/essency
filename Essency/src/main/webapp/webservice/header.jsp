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

.header {
    position: relative;
}

.h2 {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100px; /* 헤더 높이 설정 */
    margin: 0;
    padding: 0;
    margin-bottom: -25px;
}

.h2 img {
    width: 265px;
    height: 85px;
    border: none;
}

.h1 {
    margin-top: 20px; /* 로고 아래로 여백 추가 */
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
    height: 50px;
}

.h1 .welcome-message {
    margin-right: auto;
    margin-left: 10px;
    margin-bottom: 0;
}

.h3 {
    margin-top: 5px;
    background-color: #B8D0FA;
    padding: 10px 0;
    text-align: center;
}

.h3_center a {
    margin: 0 15px;
    color: black;
    text-decoration: none;
    font-weight: bold;
}

.h3_center a:hover {
    color: purple;
    transform: scale(1.05);
}
</style>
</head>
<body>
    <header class="header">
        <div class="h2">
            <a href="index.jsp">
                <img src="../webservice/image/logo.png" alt="로고">
            </a>
        </div>
        <div class="h1">
            <% 
            // 세션에서 로그인 사용자 정보 가져오기
            User loggedInUser = (User) session.getAttribute("loggedInUser");
            if (loggedInUser != null && loggedInUser.getUsername() != null) {
            %>
            <!-- 로그인한 경우 -->
            <p class="welcome-message"><%= loggedInUser.getUsername() %>님 반갑습니다 😊</p>
            
            <!-- 장바구니 버튼 -->
            <form action="cart.jsp" method="get">
                <button type="submit" class="button">장바구니</button>
            </form>
            
            <!-- 구매 목록 버튼 -->
            <form action="buyList.jsp" method="get">
                <button type="submit" class="button">구매 목록</button>
            </form>
            
            <!-- 내 정보 버튼 -->
            <form action="my_page.jsp" method="get">
                <button type="submit" class="button">마이 페이지</button>
            </form>
            
            <!-- 로그아웃 버튼 -->
            <form action="index.jsp" method="post">
                <button type="submit" name="logout" class="button">로그아웃</button>
            </form>

            <% } else { %>
            <!-- 로그인하지 않은 경우 -->
            <a href="/Essency/jsp/signUp.jsp" class="button" style="margin-right: -15px; color: black; text-decoration: none;">회원가입</a>
            <a href="/Essency/jsp/login.jsp" class="button" style="color: black; text-decoration: none;">로그인</a>
            <% } %>
        </div>
        <nav class="h3">
            <div class="h3_center">
                <a href="all_item.jsp">전체상품</a>&nbsp; 
                <a href="lotion.jsp">로션/크림</a>&nbsp;
                <a href="cleansing.jsp">클렌징</a>&nbsp; 
                <a href="ampoule.jsp">앰플/세럼</a>&nbsp;
                <a href="board_list.jsp">게시판</a>
            </div>
        </nav>
    </header>
</body>
</html>
