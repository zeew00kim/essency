<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // 데이터베이스 연결 정보
    String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
    String dbUser = "root";
    String dbPassword = "root";

    // 삭제할 상품 ID 가져오기
    String productId = request.getParameter("product_id");

    if (productId != null && !productId.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // JDBC 드라이버 로드 및 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL 삭제 쿼리
            String sql = "DELETE FROM products WHERE product_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(productId));

            // 삭제 실행
            int rowsAffected = pstmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // 삭제 성공 메시지 출력
                out.println("<script>alert('상품이 성공적으로 삭제되었습니다.'); location.href='productManage.jsp';</script>");
            } else {
                // 삭제 실패 메시지 출력
                out.println("<script>alert('상품 삭제에 실패하였습니다.'); location.href='productManage.jsp';</script>");
            }

        } catch (Exception e) {
            // 오류 메시지 출력
            e.printStackTrace();
            out.println("<script>alert('오류가 발생하였습니다: " + e.getMessage() + "'); location.href='productManage.jsp';</script>");
        } finally {
            // 리소스 정리
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        // product_id가 없을 경우
        out.println("<script>alert('삭제할 상품이 지정되지 않았습니다.'); location.href='productManage.jsp';</script>");
    }
%>
