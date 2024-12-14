<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 목록</title>
    <link rel="stylesheet" href="style.css">
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
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .button:hover {
            background-color: Skyblue;
            color: purple;
            transform: scale(1.05);
        }

        .comment-table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            border: solid silver 2px;
        }

        .comment-table th, .comment-table td {
            border: solid silver 2px;
            padding: 10px;
            text-align: center;
            font-size: 18px;
        }

        .comment-table th {
            background-color: #B8D0FA;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <!-- Header 포함 -->
    <%@ include file="header.jsp" %>

    <%
        // Header.jsp에서 세션에 저장한 로그인 사용자 정보 가져오기
        Object currentUser = session.getAttribute("loggedInUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }
    %>
    <main class="main">
        <h1>게시판에 오신 것을 환영합니다!</h1>
        <table class="comment-table">
            <thead>
                <tr>
                    <th>댓글 ID</th>
                    <th>작성자</th>
                    <th>댓글 내용</th>
                    <th>작성 시간</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        // 데이터베이스 연결
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String jdbcUrl = "jdbc:mysql://localhost:3306/team_project";
                        String dbUser = "root";
                        String dbPass = "root";

                        conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

                        // 댓글 데이터 조회 쿼리
                        String query = "SELECT c.comment_id, u.username AS author, c.content, c.created_at " +
                                       "FROM comments c " +
                                       "JOIN users u ON c.user_id = u.user_id " +
                                       "WHERE u.username = ?";
                        pstmt = conn.prepareStatement(query);

                        // 현재 사용자 이름을 파라미터로 설정
                        pstmt.setString(1, currentUser.toString());
                        rs = pstmt.executeQuery();

                        boolean hasComments = false;

                        while (rs.next()) {
                            hasComments = true;
                            int commentId = rs.getInt("comment_id");
                            String author = rs.getString("author");
                            String content = rs.getString("content");
                            String createdAt = rs.getString("created_at");
                            %>
                            <tr>
                                <td><%= commentId %></td>
                                <td><%= author %></td>
                                <td><%= content %></td>
                                <td><%= createdAt %></td>
                            </tr>
                            <%
                        }

                        if (!hasComments) {
                            %>
                            <tr>
                                <td colspan="4">작성한 댓글이 없습니다.</td>
                            </tr>
                            <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='4'>오류 발생: " + e.getMessage() + "</td></tr>");
                        e.printStackTrace();
                    } finally {
                        // 자원 해제
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </tbody>
        </table>
        <div style="text-align: center; margin-top: 20px;">
            <button class="button" onclick="location.href='write.jsp'">글 작성하기</button>
        </div>
    </main>
</body>
</html>
