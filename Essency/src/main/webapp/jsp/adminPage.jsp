<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>관리자 페이지</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      display: flex !important;
      flex-direction: column !important;
      min-height: 100vh !important; /* 전체 화면 높이 사용 */
      font-family: 'Roboto', sans-serif !important;
      margin: 0 !important;
      background-color: #f8f9fa !important;
    }
    .container {
      flex: 1 !important; /* 컨텐츠 영역이 남은 공간을 채우도록 설정 */
    }
    footer {
      background-color: #B8D0FA !important;
      color: #2c3e50 !important; 
      text-align: center !important;
      font-weight: bold !important; 
      padding-top: 10px !important;
      padding-bottom: 10px !important; 
    }
    .button-container {
      background-color: #ffffff !important;
      border: 2px solid #ddd !important;
      border-radius: 15px !important;
      padding: 20px !important;
      width: 30% !important;
      margin: 20px auto !important;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1) !important;
    }
    .btn-primary, .btn-secondary, .btn-success {
      font-weight: bold !important;
      width: 100% !important;
      margin: 5px 0 !important;
      border: 1px solid #ddd !important;
      border-radius: 5px !important;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1) !important;
      background-color: #B8D0FA !important;
      color: black !important;
      transition: transform 0.3s ease, background-color 0.3s ease !important;
    }
    .btn-success {
      margin-bottom: 20px !important;
    }
    .btn-primary:hover, .btn-secondary:hover, .btn-success:hover {
  		background-color: Skyblue !important; 
  		color: purple !important; 
  		transform: scale(1.05); 
}
  </style>
</head>
<body>
  <%@ include file="adminHeader.jsp" %>
  
  <div class="container mt-5">
    <div class="button-container">
      <h1 class="text-center mb-4" style="font-weight: bold; font-size: 26px;]">관리자 페이지</h1>
      <div class="row">
        <div class="col-12 mb-3">
          <a href="<%= request.getContextPath() %>/jsp/userManage.jsp" class="btn btn-primary">등록된 사용자 정보</a>
        </div>
        <div class="col-12 mb-3">
          <a href="<%= request.getContextPath() %>/jsp/commentManage.jsp" class="btn btn-secondary">등록된 댓글 정보</a>
        </div>
        <div class="col-12">
          <a href="<%= request.getContextPath() %>/jsp/productManage.jsp" class="btn btn-success">등록된 상품 관리</a>
        </div>
      </div>
    </div>
  </div>

  <footer style="font-size: 20px;">
    essency 화장품 쇼핑몰
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
