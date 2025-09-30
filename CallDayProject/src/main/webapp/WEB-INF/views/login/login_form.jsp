<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/login.css">
</head>
<body>

<!-- 헤더 -->
<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<!-- 로그인 컨테이너 -->
<div class="login-container">
  <div class="login-card">
    <h3>CallDay 로그인</h3>
    
    <c:if test="${param.form_error eq 'true'}">
        <script>alert('아이디 또는 비밀번호가 올바르지 않습니다.');</script>
    </c:if>

    <c:if test="${param.oauth2_error eq 'true'}">
        <script>alert('소셜 로그인에 실패했습니다. 다시 시도해주세요.');</script>
    </c:if>

    <!-- 소셜 로그인 버튼 -->
    <div class="social-login mb-3">
      <a href="<c:url value='/oauth2/authorization/naver'/>"
        class="btn-naver d-flex align-items-center justify-content-center">
        <img src="<c:url value='/resources/img/네이버 로고.png'/>" alt="N"
         style="width: 20px; height: 20px; margin-right: 8px;">
        네이버로 로그인
      </a>

      <a href="<c:url value='/oauth2/authorization/kakao'/>"
        class="btn-kakao d-flex align-items-center justify-content-center">
        <img src="https://developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png"
        alt="카카오 로고" style="width: 20px; height: 20px; margin-right: 8px;">
        카카오로 로그인
      </a>
    </div>

    <div class="divider">또는</div>

    <!-- Spring Security 로그인 폼 -->
    <form action="<c:url value='/login'/>" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

      <div class="mb-3">
        <label for="userId" class="form-label">아이디</label>
        <input type="text" name="userId" id="userId" class="form-control"/>
      </div>

      <div class="mb-3">
        <label for="password" class="form-label">비밀번호</label>
        <input type="password" name="password" id="password" class="form-control"/>
      </div>

      <button type="submit" class="btn btn-primary w-100">로그인</button>
    </form>

    <div class="d-flex justify-content-between mt-3">
      <a href="<c:url value='/find-password'/>">비밀번호 찾기</a>
      <a href="<c:url value='/signup'/>">회원가입</a>
    </div>
  </div>
</div>

</body>
</html>