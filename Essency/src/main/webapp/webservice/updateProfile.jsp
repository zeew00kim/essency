<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, java.sql.*, Essency.User"%>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/team_project", "root", "root");

        String sql = "UPDATE users SET email = ?, phone = ?, password = ? WHERE username = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, phone);
        pstmt.setString(3, password);
        pstmt.setString(4, loggedInUser.getUsername());

        int rowsUpdated = pstmt.executeUpdate();
        if (rowsUpdated > 0) {
            loggedInUser.setEmail(email);
            loggedInUser.setPhone(phone);
            session.setAttribute("loggedInUser", loggedInUser);
            response.sendRedirect("my_page.jsp");
        } else {
            out.println("<p>프로필 업데이트에 실패했습니다.</p>");
        }
    } catch (Exception e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
