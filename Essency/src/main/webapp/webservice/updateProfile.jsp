<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.*, java.sql.*, Essency.User"%>

<%
    // 세션에서 사용자 정보 가져오기
    User loggedInUser = (User) session.getAttribute("loggedInUser");

    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 클라이언트에서 전달받은 데이터
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");

    // 데이터베이스 업데이트 로직
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
            // 세션 정보 업데이트
            loggedInUser.setEmail(email);
            loggedInUser.setPhone(phone);
            session.setAttribute("loggedInUser", loggedInUser);

            // 성공적으로 업데이트 후 이동
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
