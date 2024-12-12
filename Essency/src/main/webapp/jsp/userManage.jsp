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
    table {
      width: 100%;
      text-align: center;
      border-collapse: collapse;
    }
    table th, table td {
      padding: 10px;
    }
    .btn {
      margin: 0 5px;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1 class="text-center mb-4">사용자 관리</h1>
    
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
    <table class="table table-bordered" style="border: 2px solid black;">
      <thead style="background-color: #B8D0FA;">
        <tr>
          <th>ID</th>
          <th>아이디</th>
          <th>비밀번호</th>
          <th>이메일</th>
          <th>전화번호</th>
          <th>가입일</th>
          <th>액션</th>
        </tr>
      </thead>
      <tbody>
        <% while (rs.next()) { %>
        <tr>
          <td><%= rs.getInt("user_id") %></td>
          <td><%= rs.getString("username") %></td>
          <td><%= rs.getString("password") %></td>
          <td><%= rs.getString("email") %></td>
          <td><%= rs.getString("phone") %></td>
          <td><%= rs.getTimestamp("created_at") %></td>
          <td>
            <form action="deleteUser.jsp" method="POST" style="display:inline;">
              <input type="hidden" name="user_id" value="<%= rs.getInt("user_id") %>">
              <button type="submit" class="btn btn-danger btn-sm">삭제</button>
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

    <!-- 사용자 추가 폼 -->
    <h2 class="mt-4">사용자 추가</h2>
    <form action="addUser.jsp" method="POST">
      <div class="mb-3">
        <label for="username" class="form-label">아이디</label>
        <input type="text" class="form-control" id="username" name="username" required>
      </div>
      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" class="form-control" id="password" name="password" required>
      </div>
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" class="form-control" id="email" name="email" required>
      </div>
      <div class="mb-3">
        <label for="phone" class="form-label">전화번호</label>
        <input type="text" class="form-control" id="phone" name="phone">
      </div>
      <button type="submit" class="btn btn-primary">추가</button>
    </form>
  </div>
</body>
</html>
