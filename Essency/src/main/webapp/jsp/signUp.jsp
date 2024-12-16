<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<style>
    body {
      margin: 0;
      padding: 0;
      background: url('<%= request.getContextPath() %>/webservice/image/login-bg.jpg') no-repeat center center fixed;
      background-size: cover;
      font-family: 'Roboto', sans-serif;
    }
    .card { 
      background-color: rgba(255, 255, 255, 0.9); /* 카드 배경을 약간 투명하게 */
      border-radius: 15px;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    .container {
      padding-top: 20px;
    }
    .card-title {
      font-weight: bold;
      color: #2c3e50; /* 진한 네이비 */
    }
    .form-control {
      border-radius: 10px;
    }
    .btn-primary {
      background-color: #B8D0FA;
      border: none;
      color: #2c3e50;
      font-weight: bold;
    }
    .btn-primary:hover {
      background-color: skyblue;
      color: purple;
    }
    .text-decoration-none {
      color: #2c3e50 !important;
    }
    .text-decoration-none:hover {
      color: purple !important;
      text-decoration: underline;
    }
    .mb-3 {
      font-weight: bold;
      color: #2c3e50; 
    }
</style>
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
					<div class="mb-3">
						<label for="username" class="form-label">아이디</label>
						<div class="input-group">
							<input type="text" class="form-control" id="username"
								name="username" placeholder="ID를 입력하세요" />
							<button type="button" class="btn btn-secondary"
								id="check-username-btn">중복확인</button>

						</div>
						<p id="username-feedback"></p>
					</div>
					<div class="mb-3">
						<label for="password" class="form-label">비밀번호</label> <input
							type="password" class="form-control" id="password"
							name="password" placeholder="비밀번호를 입력하세요" required>
					</div>
					<div class="mb-3">
						<label for="confirmPassword" class="form-label">비밀번호 확인</label> <input
							type="password" class="form-control" id="confirmPassword"
							name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
					</div>
					<div class="mb-3">
						<label for="email" class="form-label">이메일</label> <input
							type="email" class="form-control" id="email" name="email"
							placeholder="이메일을 입력하세요" required>
					</div>
					<div class="mb-3">
						<label for="phone" class="form-label">핸드폰 번호</label> <input
							type="tel" class="form-control" id="phone"
							name="phone" placeholder="핸드폰 번호를 입력하세요"
							pattern="\d{10,11}" required> 
							<small class="form-text text-muted">'-' 제외하고 입력
					</div>
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
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	let isUsernameAvailable = false; 

	document.getElementById("check-username-btn").addEventListener("click", function () {
	    const username = document.getElementById("username").value;

	    if (!username) {
	        document.getElementById("username-feedback").innerText = "아이디를 입력해주세요.";
	        document.getElementById("username-feedback").style.color = "red";
	        isUsernameAvailable = false; 
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
	            isUsernameAvailable = true; 
	        } else {
	            feedback.innerText = "이미 사용 중인 아이디입니다.";
	            feedback.style.color = "red";
	            isUsernameAvailable = false; 
	        }
	    })
	    .catch(error => {
	        console.error("Error:", error);
	        document.getElementById("username-feedback").innerText = "오류가 발생했습니다. 다시 시도해주세요.";
	        document.getElementById("username-feedback").style.color = "red";
	        isUsernameAvailable = false; 
	    });
	});

	document.querySelector("form").addEventListener("submit", function (event) {
	    const password = document.getElementById("password").value;
	    const confirmPassword = document.getElementById("confirmPassword").value;
	    if (!isUsernameAvailable) {
	        event.preventDefault(); 
	        alert("아이디 중복 확인을 진행해주세요.");
	        return;
	    }
	    if (password !== confirmPassword) {
	        event.preventDefault(); 
	        alert("비밀번호가 일치하지 않습니다.");
	        return;
	    }
	});
	document.getElementById("phone").addEventListener("input", function (event) {
	    const input = event.target;
	    input.value = input.value.replace(/[^0-9]/g, ""); 
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

<%@ include file="footer.jsp" %>

</html>