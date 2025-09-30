<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

  <!-- 네비게이션 -->
  <nav class="navbar navbar-expand-lg fixed-top shadow-sm">
    <div class="container">
      <a class="navbar-brand fw-bold" href="<c:url value='/'/>">CallDay</a>
      
      <span class="text-white mx-2">|</span>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item"><a class="nav-link" href="<c:url value='/exercise/recommend'/>">운동 가이드</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/calendar/week'/>">일정관리</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/imgBoard.action'/>">운동 피드</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/ai/diet'/>">AI 식단 추천</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/exercise/ex_create'/>">운동 플래너</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/weight/wt'/>">체중 관리</a></li>
          <li class="nav-item"><a class="nav-link" href="<c:url value='/calendar/check'/>">캘린더</a></li>
        </ul>

        <div class="d-flex">
          <sec:authorize access="isAuthenticated()">
            <form action="<c:url value='/logout'/>" method="post" class="me-2 mb-0">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <button type="submit" class="btn btn-outline-danger">로그아웃</button>
            </form>
            <a href="<c:url value='/memberProfile'/>" class="btn btn-secondary">내 정보</a>
          </sec:authorize>

          <sec:authorize access="!isAuthenticated()">
            <a href="<c:url value='/login'/>" class="btn btn-login me-2">로그인</a>
            <a href="<c:url value='/signup'/>" class="btn btn-signup">회원가입</a>
          </sec:authorize>
        </div>
      </div>
    </div>
  </nav>
