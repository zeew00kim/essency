<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판 목록</title>
    <link rel="stylesheet" href="style.css">

<style>
    .board-table {
        border: 1px solid gray;
        background-color: #B8D0FA;
    }

    .board-table th {
        border: 1px solid gray;
    }

    .confirm-banner {
        display: none;
        position: fixed;
        top: 30%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        border: 2px solid #B8D0FA;
        border-radius: 10px;
        padding: 20px;
        width: 300px;
        text-align: center;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        z-index: 1000;
    }

    .confirm-banner button {
        margin: 10px;
        padding: 10px 20px;
        font-weight: bold;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .confirm-banner .confirm {
        background-color: #B8D0FA;
        color: black;
        transition: transform 0.3s ease, background-color 0.3s ease;
    }

    .confirm-banner .confirm:hover {
        background-color: Skyblue;
        color: purple;
        transform: scale(1.05);
    }

    .confirm-banner .cancel {
        background-color: #ccc;
        color: black;
        transition: transform 0.3s ease, background-color 0.3s ease;
    }

    .confirm-banner .cancel:hover {
        background-color: #999;
        color: purple;
        transform: scale(1.05);
    }

    .overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 999;
    }
</style>

</head>
<body>
<%@ include file="header.jsp" %>
    <div class="container">
        <h1>게시판</h1>
        <table class="board-table">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Created At</th>
                <th>Comments</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    String jdbcUrl = "jdbc:mysql://localhost:3306/essency?useSSL=false&serverTimezone=UTC";
                    String dbId = "root";
                    String dbPass = "rkdwlgns78?";

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);

                    String sql = "SELECT b.id, b.title, b.author, b.created_at, " +
                                 "       COUNT(c.id) AS comment_count " +
                                 "FROM board b LEFT JOIN comments c ON b.id = c.board_id " +
                                 "GROUP BY b.id ORDER BY b.created_at DESC";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        String createdAt = rs.getString("created_at");
                        int commentCount = rs.getInt("comment_count");

                        out.println("<tr>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td><a href='view.jsp?id=" + id + "'>" + title + "</a></td>");
                        out.println("<td>" + author + "</td>");
                        out.println("<td>" + createdAt + "</td>");
                        out.println("<td>" + commentCount + "</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    out.println("<p>오류 발생: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
        <!-- 글 작성하기 버튼 -->
        <button class="button" onclick="checkLogin()">글 작성하기</button>
    </div>

    <!-- 로그인 배너 -->
    <div class="overlay" id="overlay"></div>
    <div class="confirm-banner" id="confirmBanner">
        <p id="bannerMessage">로그인이 필요합니다!</p>
        <button class="confirm" onclick="redirectToLogin()">확인</button>
        <button class="cancel" onclick="hideBanner()">취소</button>
    </div>

    <%@ include file="footer.jsp" %>

    <script>
        // 로그인 확인용 변수 (JSP 세션 변수 전달)
        const userName = '<%= (String) session.getAttribute("userName") %>';

        // 글 작성하기 버튼 클릭 시
        function checkLogin() {
            if (!userName || userName === 'null') {
                // 로그인이 되어 있지 않으면 로그인 배너 표시
                document.getElementById('overlay').style.display = 'block';
                document.getElementById('confirmBanner').style.display = 'block';
            } else {
                // 로그인이 되어 있으면 글 작성 페이지로 이동
                window.location.href = 'write.jsp';
            }
        }

        // 배너 숨기기
        function hideBanner() {
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('confirmBanner').style.display = 'none';
        }

        // 로그인 페이지로 이동
        function redirectToLogin() {
            window.location.href = '<%= request.getContextPath() %>/jsp/login.jsp';
        }
    </script>
</body>
</html>
