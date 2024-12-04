<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 검색</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        input[type="text"] {
            width: 50%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        table th {
            background-color: #f4f4f4;
        }
        .search-options {
            margin-top: 10px;
        }
        .search-options label {
            margin-right: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h1>게시판 검색</h1>
        <form action="search_results.jsp" method="get">
            <input type="text" name="search" placeholder="검색어를 입력하세요" required>
            <div class="search-options">
                <label><input type="radio" name="filter" value="title" checked> 제목</label>
                <label><input type="radio" name="filter" value="author"> 작성자</label>
                <label><input type="radio" name="filter" value="title_author"> 제목 + 작성자</label>
            </div>
            <button type="submit">검색</button>
        </form>
    </div>
    
    <%@ include file="footer.jsp" %>
</body>
</html>
