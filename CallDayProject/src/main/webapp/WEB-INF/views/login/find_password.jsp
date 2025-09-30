<%@ page contentType="text/html; charset=UTF-8"%>
<%	
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>비밀번호 찾기</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/login.css">
</head>
<body>

<!-- 헤더 -->
<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<!-- 비밀번호 찾기 컨테이너 -->
<div class="password-container">
  <div class="login-card">
    <h3>비밀번호 초기화</h3>
 
    <!-- 아이디 입력 폼 -->
    <form action="<%=cp%>/find-password" method="post">
      <div class="mb-3">
        <label for="username" class="form-label">아이디 입력</label>
        <input type="text" name="username" id="username" class="form-control" placeholder="아이디 입력" required>
      </div>
      <button type="submit" class="btn btn-primary w-100">초기화 요청</button>
    </form>

    <!-- 에러 메시지 -->
    <c:if test="${not empty errorMsg}">
      <div class="alert alert-danger mt-3" role="alert">
        ${errorMsg}
      </div>
    </c:if>

    <!-- 임시 비밀번호 출력 -->
    <c:if test="${not empty tempPassword}">
      <div class="alert alert-success mt-3" role="alert">
        <h5>임시 비밀번호가 발급되었습니다</h5>
        <p class="mb-2"><strong>${tempPassword}</strong></p>
        <p class="mb-0">로그인 후 반드시 비밀번호를 변경하세요.</p>
      </div>
      <div class="text-center mt-3">
        <a href="<%=cp%>/login">로그인하기</a>
      </div>
    </c:if>
  </div>
</div>

</body>
</html>