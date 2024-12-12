<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>앰플/세럼 페이지</title>
  <link href="layout1.css" rel="stylesheet" type="text/css">
  <style>
    html, body {
      margin: 0;
      padding: 0;
      overflow-x: hidden;
      width: 100%;
      box-sizing: border-box;
    }

    * {
      box-sizing: inherit;
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
    .welcome-message {
      color: black;
      font-weight: bold;
    }
    .button {
      padding: 10px 20px;
      background-color: #B8D0FA;
      border: none;
      cursor: pointer;
      color: black;
      font-weight: bold;
      border-radius: 5px;
    }
    .button:hover {
      background-color: Skyblue;
      color: purple;
      transform: scale(1.05);
    }
    .product_image {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
      justify-content: center;
      align-items: center;
    }
    .product img {
      width: 300px;
      height: 300px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .product img:hover {
      transform: scale(1.05);
      box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
    }
  </style>
</head>
<body>
  <%@ include file="header.jsp" %>

  <div class="main">
    <h1 class="m1">앰플/세럼</h1>
    <section class="m2">
      <div class="product_image">
        <%
          // 데이터베이스 연결 설정
          String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
          String dbUser = "root";
          String dbPassword = "root";

          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;

          try {
              // 데이터베이스 연결
              Class.forName("com.mysql.cj.jdbc.Driver");
              conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

              // 상품 정보 조회
              String query = "SELECT product_id, product_name FROM products WHERE product_name LIKE ?";
              pstmt = conn.prepareStatement(query);
              pstmt.setString(1, "ampoule%");
              rs = pstmt.executeQuery();

              while (rs.next()) {
                  int productId = rs.getInt("product_id");
                  String productName = rs.getString("product_name");
                  String imagePath = request.getContextPath() + "/webservice/image/" + productName + ".jpg";
        %>
        <div class="product">
          <a href="<%= request.getContextPath() %>/webservice/itemdetail.jsp?productId=<%= productId %>">
            <img src="<%= imagePath %>" alt="<%= productName %>">
          </a>
        </div>
        <%
              }
          } catch (Exception e) {
              out.println("<p>에러 발생: " + e.getMessage() + "</p>");
          } finally {
              // 리소스 정리
              try {
                  if (rs != null) rs.close();
                  if (pstmt != null) pstmt.close();
                  if (conn != null) conn.close();
              } catch (SQLException e) {
                  e.printStackTrace();
              }
          }
        %>
      </div>
    </section>
  </div>

  <%@ include file="footer.jsp" %>
</body>
</html>
