<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, Essency.User" %>
<%
    User currentUser = (User) session.getAttribute("loggedInUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
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

        String insertOrderQuery = "INSERT INTO orders (user_id, total_price) VALUES (?, ?)";
        pstmt = conn.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
        pstmt.setInt(1, userId);
        pstmt.setInt(2, totalPrice);
        pstmt.executeUpdate();

        rs = pstmt.getGeneratedKeys();
        int orderId = 0;
        if (rs.next()) {
            orderId = rs.getInt(1);
        }
        rs.close();
        pstmt.close();

        String insertOrderItemQuery = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(insertOrderItemQuery);
        pstmt.setInt(1, orderId);
        pstmt.setInt(2, Integer.parseInt(productId));
        pstmt.setInt(3, quantity);
        pstmt.setInt(4, totalPrice); 
        pstmt.executeUpdate();

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
