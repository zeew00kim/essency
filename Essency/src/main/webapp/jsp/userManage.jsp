<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>사용자 관리</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
        font-family: 'Roboto', sans-serif;
        background-color: white;
    }
    .container {
        margin-top: 50px;
    }
    .table-container {
        border-radius: 15px;
        border: 2px solid silver;
        padding: 20px;
        background-color: #ffffff;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    }
    table {
        width: 100%;       
        text-align: center;
        border-collapse: collapse;
    }
    table th, table td {
        padding: 10px;
        border: 1px solid silver;
        text-align: center;
        vertical-align: middle;
    }
    
    .btn {
        margin: 0 5px;
    }
    .submit-btn {
        padding: 10px 20px;
        background-color: #B8D0FA;
        border: none;
        cursor: pointer;
        font-weight: bold;
        border-radius: 5px;
        transition: transform 0.3s ease, background-color 0.3s ease;
        display: block; /* 버튼을 블록 요소로 변경 */
  		margin: 0 auto; /* 수평 중앙 정렬 */
        margin-bottom: 10px;
        width: 20%;
    }
    .submit-btn:hover {
        background-color: Skyblue;
        color: purple;
        transform: scale(1.05);
    }
    .delete-btn {
        padding: 10px 20px;
        background-color: Silver;
        border: none;
        cursor: pointer;
        font-weight: bold;
        border-radius: 5px;
        transition: transform 0.3s ease, background-color 0.3s ease;
    }
    .delete-btn:hover {
        background-color: #f05252;
        color: purple;
        transform: scale(1.05);
    }
    .form-label {
        font-weight: bold;
    }
    .footer {
        text-align: center;
        background-color: #B8D0FA;
        padding: 10px;
    }
    .wrap {
  		background-color: rgba(255, 255, 255, 0.9);
  		border-radius: 15px;
  		box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); 
  		border: 2px solid transparent; 
  		background-image: linear-gradient(white, white), linear-gradient(to right, silver, silver);
  		background-origin: border-box; 
  		background-clip: padding-box, border-box; 
  		padding: 20px;
  		margin: 0 auto; 
  		margin-bottom: 15px; 
  		width: 50%;
    }
    .mb-3 {
  		display: flex; 
  		flex-direction: column; 
  		align-items: center;
  		margin-bottom: 20px;
  		width: 100%; 
	}

	.mb-3 .form-label {
  		width: 80%;
 		text-align: left;
  		margin-bottom: 5px;
	}

	.mb-3 .form-control {
  		width: 80%; 
  		border-radius: 10px; 
	}
</style>
<script>
  // 등록 버튼 클릭 시 확인 배너
  function confirmAdd() {
    return confirm("새로운 회원 정보를 등록하시겠습니까?");
  }

  // 삭제 버튼 클릭 시 확인 배너
  function confirmDelete() {
    return confirm("등록된 회원 정보를 삭제하시겠습니까?");
  }
</script>
</head>
<body>

<%@ include file="adminHeader.jsp" %>

  <div class="container">
    <h3 class="text-center mb-4" style="font-weight: bold">등록된 계정 정보</h3>
    
    <% 
      // 데이터베이스 연결
      String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
      String dbUser = "root";
      String dbPassword = "root";

      Connection conn = null;
      Statement stmt = null;
      ResultSet rs = null;
      
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        stmt = conn.createStatement();
        
        // 사용자 데이터 조회
        String query = "SELECT * FROM users"; // 테이블 이름 users
        rs = stmt.executeQuery(query);
    %>
    <table class="table table-bordered" style="border: 2px solid silver; width: 80%; margin:0 auto; margin-bottom: 20px;">
      <thead style="background-color: #B8D0FA;">
        <tr style="font-size: 18px;">
          <!-- <th>ID</th> -->
          <th>아이디</th>
          <th>비밀번호</th>
          <th>이메일</th>
          <th>전화번호</th>
          <th>가입일</th>
          <th>계정 삭제</th>
        </tr>
      </thead>
      <tbody>
        <% while (rs.next()) { %>
        <tr style="background-color: #f8f8f8">
          <!-- <td><%= rs.getInt("user_id") %></td> -->
          <td><%= rs.getString("username") %></td>
          <td><%= rs.getString("password") %></td>
          <td><%= rs.getString("email") %></td>
          <td><%= rs.getString("phone") %></td>
          <td><%= rs.getTimestamp("created_at") %></td>
          <td>
            <form action="deleteUser.jsp" method="POST" style="display:inline;" onsubmit="return confirmDelete()">
  				<input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
  				<button type="submit" class="delete-btn">삭제</button>
			</form>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
    <% 
      } catch (Exception e) {
        out.println("<div class='alert alert-danger'>에러: " + e.getMessage() + "</div>");
      } finally {
        try {
          if (rs != null) rs.close();
          if (stmt != null) stmt.close();
          if (conn != null) conn.close();
        } catch (SQLException e) {
          e.printStackTrace();
        }
      }
    %>

    <div class="wrap">
    	<h3 class="mt-4" style="font-weight: bold; text-align: center;">새로운 계정 등록</h3>
    	<br>
    	<form action="addUser.jsp" method="POST" onsubmit="return confirmAdd()">
  			<div class="mb-3">
    			<label for="username" class="form-label">아이디</label>
    			<input type="text" class="form-control" id="username" name="username" required style="width: 80%;">
  			</div>
  			<div class="mb-3">
    			<label for="password" class="form-label">비밀번호</label>
    			<input type="password" class="form-control" id="password" name="password" required style="width: 80%;">
  			</div>
  			<div class="mb-3">
    			<label for="email" class="form-label">이메일</label>
    			<input type="email" class="form-control" id="email" name="email" required style="width: 80%;">
  			</div>
 			<div class="mb-3">
    			<label for="phone" class="form-label">전화번호</label>
    			<input type="text" class="form-control" id="phone" name="phone" style="width: 80%;">
  			</div>
  			<button type="submit" class="submit-btn">등록</button>
		</form>
	 </div>
  </div>

  <footer class="footer">
      <span style="font-weight: bold">Essency 화장품 쇼핑몰</span>
    </footer>
</body>
</html>
