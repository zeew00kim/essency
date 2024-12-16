<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>상품 추가</title>
</head>
<body>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    Connection conn = null;
    PreparedStatement pstmt = null;

    String productName = request.getParameter("product_name");
    String salePrice = request.getParameter("sale_price");
    String shippingCharge = request.getParameter("shipping_charge");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
        String sql = "INSERT INTO products (product_name, sale_price, shipping_charge) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productName);
        pstmt.setInt(2, Integer.parseInt(salePrice));
        pstmt.setInt(3, Integer.parseInt(shippingCharge));

        int result = pstmt.executeUpdate(); 

        if (result > 0) {
%>
            <script>
                alert("상품이 성공적으로 등록되었습니다.");
                window.location.href = "productManage.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("상품 등록에 실패했습니다.");
                window.history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("에러가 발생했습니다: <%= e.getMessage() %>");
            window.history.back();
        </script>
<%
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
