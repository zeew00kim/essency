<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Essency.User, java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <title>메인 페이지</title>
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

    .items {
      display: flex;
      justify-content: space-around;
      flex-wrap: wrap;
      gap: 30px;
      margin: 20px;
    }

    .item {
      text-align: center;
      width: 250px;
    }

    .item img {
      width: 250px;
      height: 250px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .item img:hover {
      transform: scale(1.05);
      box-shadow: 0 8px 12px rgba(0, 0, 0, 0.2);
    }

    .item a {
      display: block;
      text-align: center;
      margin-top: 10px;
      font-size: 16px;
      font-weight: bold;
      color: black;
    }

    .item a:hover {
      text-decoration: none;
    }
    
    /* 이미지 스타일 */
    img {
      border-radius: 5px;
      border: 2px solid gray;
    }

    /* Best Review 스타일 */
    .reviewImg {
      display: flex;
      justify-content: space-around;
      gap: 20px;
    }

    .reviewImg .item {
      position: relative;
      width: 250px;
      height: 250px;
    }

    .reviewImg .item img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 5px;
      border: 2px solid gray;
      transition: filter 0.3s ease;
    }

    .reviewImg .item p {
      position: absolute;
      width: 91%;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      color: white;
      font-size: 1em;
      font-weight: bold;
      text-align: center;
      opacity: 0;
      transition: opacity 0.3s ease, background-color 0.3s ease;
      background-color: rgba(0, 0, 0, 0.7);
      padding: 10px;
      border-radius: 5px;
    }

    .reviewImg .item:hover img {
      filter: blur(2px) brightness(70%);
    }

    .reviewImg .item:hover p {
      opacity: 1;
    }
  </style>
</head>
<body>
  <!-- Header 포함 -->
  <%@ include file="header.jsp" %>
  
  <div class="wrap">
    <main class="main">
      <div class="main-image">
        <img src="../webservice/image/KakaoTalk_20241128_200009300_03.jpg" width="962" height="400" alt="메인 이미지">
      </div>

      <section class="best-items">
        <h2>Best Items</h2>
        <div class="items">
          <%
            // JDBC 연결 설정
            String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
            String dbUser = "root";
            String dbPassword = "root";

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                // products 테이블에서 특정 아이템 가져오기
                String query = "SELECT product_id, product_name, sale_price FROM products WHERE product_name IN ('lotion_1', 'cream_1', 'cleansing_1', 'ampoule_1')";
                pstmt = conn.prepareStatement(query);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int productId = rs.getInt("product_id");
                    String productName = rs.getString("product_name");
                    int salePrice = rs.getInt("sale_price");
                    String imagePath = request.getContextPath() + "/webservice/image/" + productName + ".jpg";
          %>
          <div class="item">
            <a href="<%= request.getContextPath() %>/webservice/itemdetail.jsp?productId=<%= productId %>">
              <img src="<%= imagePath %>" alt="<%= productName %>">
              <p><%= productName %><br><%= salePrice %>원</p>
            </a>
          </div>
          <%
                }
            } catch (Exception e) {
                out.println("<p>에러 발생: " + e.getMessage() + "</p>");
            } finally {
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

      <section class="best-review">
        <h2>Best Review</h2>
        <div class="reviewImg">
          <div class="item">
            <img src="../webservice/image/KakaoTalk_20241127_111509868_22.jpg" width="250" height="250" alt="보습 크림">
            <p>보습 크림 리뷰<br>벌써 n통째 구매중 입니다! 겨울에 쓰기 좋아요~</p>
          </div>
          <div class="item">
            <img src="../webservice/image/7cffd09ef5d100fe440dfdab11082b81.jpg" width="250" height="250" alt="촉촉 수분크림">
            <p>촉촉 수분크림 리뷰<br>여름에도 쓰기 부담없어서<br>좋아요!!</p>
          </div>
          <div class="item">
            <img src="../webservice/image/634f9d163ecaf278cefeb5058e2c0bd4.jpg" width="250" height="250" alt="마일드 썬크림">
            <p>마일드 썬크림 리뷰<br>톤업버전과 수분 버전 비교 발색샷 입니다~</p>
          </div>
          <div class="item">
            <img src="../webservice/image/Mid Day Blue UV Shield SPF50+ PA++++.jpg" width="250" height="250" alt="CICA 크림">
            <p>CICA 크림 리뷰<br>여드름이 많이 개선되었어요!</p>
          </div>
        </div>
      </section>
    </main>

    <!-- Footer 포함 -->
    <%@ include file="footer.jsp" %>
  </div>

  <% 
    // 로그아웃 처리
    if (request.getParameter("logout") != null) {
        session.invalidate();  // 세션 종료
        response.sendRedirect("index.jsp");  // 로그아웃 후 index.jsp로 리다이렉트
    }
  %>
</body>
</html>
