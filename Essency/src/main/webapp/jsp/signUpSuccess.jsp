<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 성공</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card shadow text-center" style="width: 25rem;">
        <div class="card-body">
            <h2 class="card-title text-success mb-4">회원가입 성공!</h2>
            <p class="card-text">축하합니다, <strong>${username}</strong>님!</p>
            <p>회원가입이 완료되었습니다. 로그인 버튼을 클릭하여 로그인 페이지로 이동하세요.</p>
            <a href="/Essency/jsp/login.jsp" class="btn btn-primary mt-3">로그인하기</a>
        </div>
    </div>
</div>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
