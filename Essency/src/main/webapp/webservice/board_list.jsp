<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>게시판 목록</title>
  <link rel="stylesheet" href="layout1.css">
  <style>
    html, body {
      margin: 0;
      padding: 0;
      overflow-x: hidden;
      width: 100%;
      box-sizing: border-box;
    }

    a {
      text-decoration: none;
      font-weight: bold;
      color: black;
    }

    a:hover {
      text-decoration: underline;
      color: purple !important;
      transform: scale(1.05);
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

    .board-table {
      width: 80%;
      margin: 20px auto;
      border-collapse: collapse;
      border: solid silver 2px;
    }

    .board-table th, .board-table td {
      border: solid silver 2px;
      padding: 10px;
      text-align: center;
      font-size: 18px;
    }

    .board-table th {
      background-color: #B8D0FA;
      font-weight: bold;
    }

    .main-header {
      text-align: center;
      font-weight: bold;
      font-size: 28px;
    }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %> 

  <%
    Object currentUser = session.getAttribute("loggedInUser");

    if (currentUser == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
  %>

  <main class="main">
    <p class="main-header">게시판 목록</p>
    <table class="board-table" style="width: 60%">
      <thead>
        <tr>
          <th>제목</th>
          <th>작성자</th>
          <th>작성 일자</th>
        </tr>
      </thead>
      <tbody>
        <%
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              String jdbcUrl = "jdbc:mysql://localhost:3306/team_project";
              String dbUser = "root";
              String dbPass = "root";
              conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);
              String query = 
                  "SELECT id, title, author, created_at " +
                  "FROM board " +
                  "ORDER BY CASE WHEN author = '관리자' THEN 1 ELSE 2 END, created_at DESC";
              pstmt = conn.prepareStatement(query);
              rs = pstmt.executeQuery();

              boolean hasPosts = false;

              while (rs.next()) {
                  hasPosts = true;
                  int postId = rs.getInt("id");
                  String title = rs.getString("title");
                  String author = rs.getString("author");
                  String createdAt = rs.getString("created_at");
        %>
        <tr style="background-color: <%= author.equals("관리자") ? "#D3D3D3" : "#f8f8f8" %>">
          <td><a href="view.jsp?id=<%= postId %>"><%= title %></a></td>
          <td><%= author %></td>
          <td><%= createdAt %></td>
        </tr>
        <%
              }

              if (!hasPosts) {
        %>
        <tr style="background-color: #f8f8f8">
          <td colspan="3">작성된 게시글이 없습니다.</td>
        </tr>
        <%
              }
          } catch (Exception e) {
              out.println("<tr><td colspan='3'>오류 발생: " + e.getMessage() + "</td></tr>");
              e.printStackTrace();
          } finally {
              if (rs != null) rs.close();
              if (pstmt != null) pstmt.close();
              if (conn != null) conn.close();
          }
        %>
      </tbody>
    </table>
    <div style="text-align: center; margin-top: 20px;">
      <button class="button" onclick="location.href='write.jsp'" style="margin: 10px;">글 작성하기</button>
    </div>
  </main>

  <%@ include file="footer.jsp" %>
</body>
</html>
