<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Essency.User" %>
<%
    // 로그인된 사용자 확인
    User currentUser = (User) session.getAttribute("loggedInUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 파라미터 가져오기
    String productId = request.getParameter("productId");
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
    String username = currentUser.getUsername();

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String jdbcURL = "jdbc:mysql://localhost:3306/team_project";
        String dbUser = "root";
        String dbPassword = "root";
        conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // 사용자 ID 가져오기
        String getUserIdQuery = "SELECT user_id FROM users WHERE username = ?";
        pstmt = conn.prepareStatement(getUserIdQuery);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        int userId = 0;
        if (rs.next()) {
            userId = rs.getInt("user_id");
        }
        rs.close();
        pstmt.close();

        // orders 테이블에 새로운 주문 추가
        String insertOrderQuery = "INSERT INTO orders (user_id, total_price) VALUES (?, ?)";
        pstmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, totalPrice);
        pstmt.executeUpdate();

        // 생성된 order_id 가져오기
        rs = pstmt.getGeneratedKeys();
        int orderId = 0;
        if (rs.next()) {
            orderId = rs.getInt(1);
        }
        rs.close();
        pstmt.close();

        // order_items 테이블에 상품 추가
        String insertOrderItemQuery = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertOrderItemQuery);
        pstmt.setInt(1, orderId);
        pstmt.setInt(2, Integer.parseInt(productId));
        pstmt.setInt(3, quantity);
        pstmt.setInt(4, totalPrice); // 수량 포함 총 가격
        pstmt.executeUpdate();

        // 구매 완료 메시지 출력
        out.println("<script>alert('감사합니다. 구매가 완료되었습니다! 🥰'); location.href='buyList.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('구매 처리 중 오류가 발생했습니다. 다시 시도해주세요.'); history.back();</script>");
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
