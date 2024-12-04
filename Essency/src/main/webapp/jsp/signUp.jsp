<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 페이지</title>
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
				<h3 class="card-title text-center mb-4">회원가입</h3>
				<%
				String error = (String) request.getAttribute("error");
				if (error != null) {
				%>
				<div class="alert alert-danger" role="alert">
					<strong>오류:</strong>
					<%=error%>
				</div>
				<%
				}
				%>
				<form action="/Essency/signUpControl" method="POST">
					<!-- 아이디 입력 -->
					<div class="mb-3">
						<label for="username" class="form-label">아이디</label>
						<div class="input-group">
							<input type="text" class="form-control" id="username"
								name="username" placeholder="ID를 입력하세요" />
							<button type="button" class="btn btn-secondary"
								id="check-username-btn">중복확인</button>

						</div>
						<p id="username-feedback"></p>
						<!-- 중복 확인 결과 표시 -->
					</div>
					<!-- 비밀번호 입력 -->
					<div class="mb-3">
						<label for="password" class="form-label">비밀번호</label> <input
							type="password" class="form-control" id="password"
							name="password" placeholder="비밀번호를 입력하세요" required>
					</div>

					<!-- 비밀번호 확인 -->
					<div class="mb-3">
						<label for="confirmPassword" class="form-label">비밀번호 확인</label> <input
							type="password" class="form-control" id="confirmPassword"
							name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
					</div>

					<!-- 이메일 입력 -->
					<div class="mb-3">
						<label for="email" class="form-label">이메일</label> <input
							type="email" class="form-control" id="email" name="email"
							placeholder="이메일을 입력하세요" required>
					</div>

					<!-- 핸드폰 번호 입력 -->
					<div class="mb-3">
						<label for="phone" class="form-label">핸드폰 번호</label> <input
							type="tel" class="form-control" id="phone"
							name="phone" placeholder="핸드폰 번호를 입력하세요"
							pattern="\d{10,11}" required> <small
							class="form-text text-muted">'-' 제외하고 입력
					</div>


					<!-- 회원가입 버튼 -->
					<button type="submit" class="btn btn-primary w-100">회원가입</button>
				</form>
				<div class="text-center mt-3">
					<p>
						이미 계정이 있으신가요? <a href="/Essency/jsp/login.jsp"
							class="text-decoration-none">로그인</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	let isUsernameAvailable = false; // 아이디 중복 확인 상태 저장

	document.getElementById("check-username-btn").addEventListener("click", function () {
	    const username = document.getElementById("username").value;

	    if (!username) {
	        document.getElementById("username-feedback").innerText = "아이디를 입력해주세요.";
	        document.getElementById("username-feedback").style.color = "red";
	        isUsernameAvailable = false; // 상태 초기화
	        return;
	    }

	    fetch("/Essency/checkUsername", {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/json",
	        },
	        body: JSON.stringify({ username: username }),
	    })
	    .then(response => response.json())
	    .then(data => {
	        const feedback = document.getElementById("username-feedback");
	        if (data.available) {
	            feedback.innerText = "사용 가능한 아이디입니다.";
	            feedback.style.color = "green";
	            isUsernameAvailable = true; // 상태 업데이트
	        } else {
	            feedback.innerText = "이미 사용 중인 아이디입니다.";
	            feedback.style.color = "red";
	            isUsernameAvailable = false; // 상태 업데이트
	        }
	    })
	    .catch(error => {
	        console.error("Error:", error);
	        document.getElementById("username-feedback").innerText = "오류가 발생했습니다. 다시 시도해주세요.";
	        document.getElementById("username-feedback").style.color = "red";
	        isUsernameAvailable = false; // 상태 초기화
	    });
	});

	// 회원가입 버튼 클릭 시 검증
	document.querySelector("form").addEventListener("submit", function (event) {
	    const password = document.getElementById("password").value;
	    const confirmPassword = document.getElementById("confirmPassword").value;

	    // 아이디 중복 확인 여부 체크
	    if (!isUsernameAvailable) {
	        event.preventDefault(); // 폼 제출 방지
	        alert("아이디 중복 확인을 진행해주세요.");
	        return;
	    }

	    // 비밀번호 일치 여부 체크
	    if (password !== confirmPassword) {
	        event.preventDefault(); // 폼 제출 방지
	        alert("비밀번호가 일치하지 않습니다.");
	        return;
	    }
	});
	document.getElementById("phone").addEventListener("input", function (event) {
	    const input = event.target;
	    input.value = input.value.replace(/[^0-9]/g, ""); // 숫자 외 제거
	});
	document.getElementById("confirmPassword").addEventListener("input", function () {
	    const password = document.getElementById("password").value;
	    const confirmPassword = document.getElementById("confirmPassword").value;
	    const feedback = document.getElementById("confirmPassword").nextElementSibling;

	    if (password !== confirmPassword) {
	        feedback.innerText = "비밀번호가 일치하지 않습니다.";
	        feedback.style.color = "red";
	    } else {
	        feedback.innerText = "비밀번호가 일치합니다.";
	        feedback.style.color = "green";
	    }
	});
</script>
</body>

</html>