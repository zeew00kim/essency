<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>개인정보 수정</title>
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
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
            color: #555;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-group input:focus {
            border-color: #B8D0FA;
            outline: none;
            box-shadow: 0 0 5px rgba(184, 208, 250, 0.5);
        }
        .submit-btn {
            display: block; 
            width: 30%;
            padding: 10px;
            background-color: #B8D0FA;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin: 0 auto; 
        }
        .submit-btn:hover {
            background-color: skyblue;
            transform: scale(1.05);
            color: purple;
        }
    </style>
    <script>
        let isFormChanged = false;

        function markFormAsChanged() {
            isFormChanged = true;
        }

        function validateForm() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;

            if (password !== confirmPassword) {
                alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
                return false;
            }

            isFormChanged = false;
            return true;
        }

        window.addEventListener("beforeunload", function(event) {
            if (isFormChanged) {
                event.preventDefault();
                event.returnValue = "이 페이지를 벗어나면 수정 중인 내용이 적용되지 않을 수 있습니다.";
            }
        });
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>

    <%
        if (loggedInUser == null) { 
            response.sendRedirect("login.jsp");
            return;
        }
        String username = loggedInUser.getUsername();
        String email = loggedInUser.getEmail();
        String phone = loggedInUser.getPhone() != null ? loggedInUser.getPhone() : "등록되지 않음";
    %>

    <div class="container">
        <h2>내 정보 수정</h2>
        <form action="updateProfile.jsp" method="POST" onsubmit="return validateForm();">
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="username" value="<%= username %>" readonly>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" value="<%= email %>" required onchange="markFormAsChanged();">
            </div>
            <div class="form-group">
                <label for="phone">핸드폰 번호</label>
                <input type="tel" id="phone" name="phone" value="<%= phone %>" placeholder="01012345678 형식으로 입력하세요" required onchange="markFormAsChanged();">
            </div>
            <div class="form-group">
                <label for="password">새 비밀번호</label>
                <input type="password" id="password" name="password" placeholder="변경할 비밀번호를 입력하세요" required onchange="markFormAsChanged();">
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required onchange="markFormAsChanged();">
            </div>
            <button type="submit" class="submit-btn">수정하기</button>
        </form>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
