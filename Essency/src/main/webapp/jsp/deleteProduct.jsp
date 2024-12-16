<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    String productId = request.getParameter("product_id");

    if (productId != null && !productId.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "DELETE FROM products WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(productId));

            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                out.println("<script>alert('상품이 성공적으로 삭제되었습니다.'); location.href='productManage.jsp';</script>");
            } else {
                out.println("<script>alert('상품 삭제에 실패하였습니다.'); location.href='productManage.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('오류가 발생하였습니다: " + e.getMessage() + "'); location.href='productManage.jsp';</script>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.println("<script>alert('삭제할 상품이 지정되지 않았습니다.'); location.href='productManage.jsp';</script>");
    }
%>
