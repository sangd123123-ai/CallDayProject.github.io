<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%	
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
    <title>회원 관리</title>
    <jsp:include page="/WEB-INF/views/admin_layout/head_meta.jsp" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="layout-fixed sidebar-expand-lg sidebar-open bg-body-tertiary">

  <div class="app-wrapper">

    <!-- Header -->
    <jsp:include page="/WEB-INF/views/admin_layout/header.jsp" />

    <!-- Sidebar -->
    <jsp:include page="/WEB-INF/views/admin_layout/sidebar.jsp" />


 <!-- Content -->
    <main class="container my-4">
      <h2 class="mb-4">회원 관리</h2>

    <table class="table table-bordered table-striped align-middle text-center">
        <thead class="table-secondary">
            <tr>
                <th>ID</th>
                <th>아이디</th>
                <th>이름</th>
                <th>이메일</th>
                <th>성별</th>
                <th>권한</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${users}">
			    <tr>
			        <td>${u.id}</td>
					<!-- readonly 값은 보여주지만 수정은 못하게 -->
			        <!-- 아이디 -->
			        <td>
			            <input type="text" class="form-control-plaintext text-center" value="${u.userId}" readonly />
			        </td>
			
			        <!-- 이름 -->
			        <td>
			            <input type="text" class="form-control-plaintext text-center" value="${u.userName}" readonly />
			        </td>
			
			        <!-- 이메일 -->
			        <td>
			            <input type="text" class="form-control-plaintext text-center" value="${u.email}" readonly />
			        </td>
			
			        <!-- 성별 -->
			        <td>
			            <input type="text" class="form-control-plaintext text-center" value="${u.address}" readonly />
			        </td>
			
			        <!-- 권한 -->
			        <td>
				        <select class="form-select" name="role">
								<option value="USER" ${u.role == 'USER' ? 'selected' : ''}>USER</option>
								<option value="ADMIN" ${u.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
						</select>
					</td>
			
			        <!-- 버튼 -->
			        <td>
			            <form action="<%=cp %>/admin/users/${u.id}/update" method="post" class="d-inline">
			             <!-- role 값을 담을 hidden input -->
      						<input type="hidden" name="role" value="${u.role}">
			                <button type="submit" class="btn btn-sm btn-outline-secondary">수정</button>
			            </form>
			            <form action="<%=cp %>/admin/users/${u.id}/delete" method="post" class="d-inline">
			                <button type="submit" class="btn btn-sm btn-secondary">삭제</button>
			            </form>
			        </td>
			    </tr>
			</c:forEach>
        </tbody>
    </table>
    </main>
    
       <!-- Footer -->
    <jsp:include page="/WEB-INF/views/admin_layout/footer.jsp" />
  </div>


 <!-- 공통 JS -->
  <script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/browser/overlayscrollbars.browser.es6.min.js"></script>
  <script src="${cp}/resources/admin.js/adminlte.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
