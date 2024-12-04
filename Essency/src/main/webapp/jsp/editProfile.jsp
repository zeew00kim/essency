<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, Essency.User"%>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = loggedInUser.getUsername();
    String email = loggedInUser.getEmail();
    String phone = loggedInUser.getPhone();
%>

<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>개인정보 수정</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script>
    function validateForm() {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;

        if (password !== confirmPassword) {
            alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
            return false; // 폼 제출 방지
        }
        return true; // 폼 제출 허용
    }
</script>
</head>
<body>
	<%@ include file="header.jsp"%>

	<div class="container mt-5">
		<h2 class="text-center mb-4">개인정보 수정</h2>
		<form action="/Essency/editProfileControl" method="POST"
			onsubmit="return validateForm();">
			<!-- 사용자명 (수정 불가) -->
			<div class="mb-3">
				<label for="username" class="form-label">아이디</label> <input
					type="text" class="form-control" id="username" name="username"
					value="<%= username %>" readonly>
			</div>
			<!-- 이메일 -->
			<div class="mb-3">
				<label for="email" class="form-label">이메일</label> <input
					type="email" class="form-control" id="email" name="email"
					value="<%= email %>" required>
			</div>
			<!-- 핸드폰 번호 -->
			<div class="mb-3">
				<label for="phone" class="form-label">핸드폰 번호</label> <input
					type="tel" class="form-control" id="phone" name="phone"
					value="<%= phone %>" pattern="\d{10,11}" required>
			</div>
			<!-- 비밀번호 -->
			<div class="mb-3">
				<label for="password" class="form-label">새 비밀번호</label> <input
					type="password" class="form-control" id="password" name="password"
					placeholder="변경할 비밀번호를 입력하세요" required>
			</div>
			<div class="mb-3">
				<label for="confirmPassword" class="form-label">비밀번호 확인</label> <input
					type="password" class="form-control" id="confirmPassword"
					name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
			</div>
			<!-- 수정 버튼 -->
			<button type="submit" class="btn btn-primary w-100">수정하기</button>
		</form>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
