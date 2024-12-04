<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 확인</title>
<!-- Bootstrap CSS -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container mt-5">
    <h2 class="text-center mb-4">비밀번호 확인</h2>
    <form action="/Essency/verifyPasswordControl" method="POST">
        <!-- 비밀번호 입력 -->
        <div class="mb-3">
            <label for="password" class="form-label">비밀번호</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <!-- 확인 버튼 -->
        <button type="submit" class="btn btn-primary w-100">확인</button>
    </form>

    <% 
    // 에러 메시지가 있을 경우 표시
    String error = (String) request.getAttribute("error");
    if (error != null) {
    %>
    <div class="alert alert-danger mt-3">
        <%= error %>
    </div>
    <% } %>
</div>

<!-- Bootstrap JS -->
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
