<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp"%>
	<div
		class="container d-flex justify-content-center align-items-center vh-100">
		<div class="card shadow" style="width: 25rem;">
			<div class="card-body">
				<h3 class="card-title text-center mb-4">로그인</h3>
				<!-- 에러 메시지 표시 -->
				<% String errorMessage = (String) request.getAttribute("errorMessage"); %>
				<% if (errorMessage != null) { %>
				<div class="alert alert-danger text-center">
					<%= errorMessage %>
				</div>
				<% } %>
				<!-- 로그인 폼 -->
				<form action="/Essency/loginControl" method="POST">
					<!-- 아이디 입력 -->
					<div class="mb-3">
						<label for="username" class="form-label">아이디</label> <input
							type="text" class="form-control" id="username" name="username"
							placeholder="아이디를 입력하세요" required>
					</div>

					<!-- 비밀번호 입력 -->
					<div class="mb-3">
						<label for="password" class="form-label">비밀번호</label> <input
							type="password" class="form-control" id="password"
							name="password" placeholder="비밀번호를 입력하세요" required>
					</div>

					<!-- 로그인 버튼 -->
					<button type="submit" class="btn btn-primary w-100">로그인</button>
				</form>
				<div class="text-center mt-3">
					<p>
						계정이 없으신가요? <a href="/Essency/jsp/signUp.jsp" class="text-decoration-none">회원가입</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js">
    </script>
</body>
</html>
