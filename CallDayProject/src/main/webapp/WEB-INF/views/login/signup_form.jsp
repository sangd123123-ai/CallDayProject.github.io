<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/login.css">
</head>
<body>

<!-- 헤더 -->
<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<!-- 회원가입 컨테이너 -->
<div class="signup-container">
  <div class="login-card">
    <h3>회원가입</h3>

    <!-- 전체 에러 -->
    <c:if test="${errors != null && errors.globalErrorCount > 0}">
      <div class="alert alert-danger">
        <ul class="mb-0">
          <c:forEach var="err" items="${errors.globalErrors}">
            <li><c:out value="${err.defaultMessage}"/></li>
          </c:forEach>
        </ul>
      </div>
    </c:if>

    <!-- 회원가입 폼 -->
    <form action="<c:url value='/signup'/>" method="post">

      <!-- 아이디 -->
      <div class="mb-3">
        <label for="userId" class="form-label">아이디</label>
        <input type="text" name="userId" id="userId"
               class="form-control <c:if test='${errors != null && errors.hasFieldErrors("userId")}'>is-invalid</c:if>"
               value="${userCreateForm.userId}">
        <c:if test="${errors != null && errors.hasFieldErrors('userId')}">
          <div class="invalid-feedback">
            <c:forEach var="err" items="${errors.getFieldErrors('userId')}">
              <c:out value="${err.defaultMessage}"/>
            </c:forEach>
          </div>
        </c:if>
      </div>

      <!-- 이름 -->
      <div class="mb-3">
        <label for="userName" class="form-label">이름</label>
        <input type="text" name="userName" id="userName"
               class="form-control <c:if test='${errors != null && errors.hasFieldErrors("userName")}'>is-invalid</c:if>"
               value="${userCreateForm.userName}">
        <c:if test="${errors != null && errors.hasFieldErrors('userName')}">
          <div class="invalid-feedback">
            <c:forEach var="err" items="${errors.getFieldErrors('userName')}">
              <c:out value="${err.defaultMessage}"/>
            </c:forEach>
          </div>
        </c:if>
      </div>

      <!-- 이메일 -->
      <div class="mb-3">
        <label for="email" class="form-label">이메일</label>
        <input type="email" name="email" id="email"
               class="form-control <c:if test='${errors != null && errors.hasFieldErrors("email")}'>is-invalid</c:if>"
               value="${userCreateForm.email}">
        <c:if test="${errors != null && errors.hasFieldErrors('email')}">
          <div class="invalid-feedback">
            <c:forEach var="err" items="${errors.getFieldErrors('email')}">
              <c:out value="${err.defaultMessage}"/>
            </c:forEach>
          </div>
        </c:if>
      </div>

      <!-- 성별 -->
      <div class="mb-3">
        <label for="address" class="form-label">성별</label>
        <select name="address" id="address"
                class="form-select <c:if test='${errors != null && errors.hasFieldErrors("address")}'>is-invalid</c:if>">
          <option value="">성별 선택</option>
          <option value="남" <c:if test="${userCreateForm.address eq '남'}">selected</c:if>>남</option>
          <option value="여" <c:if test="${userCreateForm.address eq '여'}">selected</c:if>>여</option>
        </select>
        <c:if test="${errors != null && errors.hasFieldErrors('address')}">
          <div class="invalid-feedback">
            <c:forEach var="err" items="${errors.getFieldErrors('address')}">
              <c:out value="${err.defaultMessage}"/>
            </c:forEach>
          </div>
        </c:if>
      </div>

      <!-- 비밀번호 -->
      <div class="mb-3">
        <label for="password1" class="form-label">비밀번호</label>
        <input type="password" name="password1" id="password1"
               class="form-control <c:if test='${errors != null && errors.hasFieldErrors("password1")}'>is-invalid</c:if>">
        <c:if test="${errors != null && errors.hasFieldErrors('password1')}">
          <div class="invalid-feedback">
            <c:forEach var="err" items="${errors.getFieldErrors('password1')}">
              <c:out value="${err.defaultMessage}"/>
            </c:forEach>
          </div>
        </c:if>
      </div>

      <!-- 비밀번호 확인 -->
      <div class="mb-3">
        <label for="password2" class="form-label">비밀번호 확인</label>
        <input type="password" name="password2" id="password2"
               class="form-control <c:if test='${errors != null && errors.hasFieldErrors("password2")}'>is-invalid</c:if>">
        <c:if test="${errors != null && errors.hasFieldErrors('password2')}">
          <div class="invalid-feedback">
            <c:forEach var="err" items="${errors.getFieldErrors('password2')}">
              <c:out value="${err.defaultMessage}"/>
            </c:forEach>
          </div>
        </c:if>
      </div>

      <button type="submit" class="btn btn-primary w-100">회원가입</button>
    </form>

    <div class="text-center mt-3">
      <a href="<c:url value='/login'/>">이미 계정이 있으신가요? 로그인</a>
    </div>
  </div>
</div>



</body>
</html>