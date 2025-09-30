<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            color: #212529;
        }
        .card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .nav-tabs .nav-link {
            color: #495057;
        }
        .nav-tabs .nav-link.active {
            border-bottom: 2px solid #0d6efd;
            font-weight: bold;
            color: #0d6efd;
        }
        .profile-img {
            width: 150px;
            height: 150px;
            border-radius: 10px;
            object-fit: cover;
            border: 2px solid #dee2e6;
        }
    </style>
</head>
<body>

<!-- 헤더 include -->
  <%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<div style="height: 50px"></div>

<div class="container mt-5">
    <!-- 네비게이션 -->
    <ul class="nav nav-tabs mb-4">
        <li class="nav-item"><a class="nav-link active" href="#">기본 설정</a></li>
        <li class="nav-item"><a class="nav-link" href="/logout">로그아웃</a></li>
    </ul>

    <!-- 프로필 카드 -->
    <div class="card p-4">
        <div class="row">
			<!-- 프로필 이미지 -->
			<div class="col-md-3 text-center d-flex flex-column align-items-center">
			    <img src="<c:url value='/resources/profile/${user.profileImage != null ? user.profileImage : "default.png"}'/>"
			         class="profile-img mb-4" alt="프로필">
			
			     <!-- 이미지 업로드 폼 -->
			    <form id="profileForm" action="<c:url value='/memberProfile/updateImage'/>"
			          method="post" enctype="multipart/form-data">
			        <input type="file" id="fileInput" name="file" class="d-none"
			               onchange="document.getElementById('profileForm').submit();">
			        <button type="button" class="btn btn-sm btn-outline-primary"
			                onclick="document.getElementById('fileInput').click();">
			            프로필 변경
			        </button>
			    </form>
			</div>

				<!-- 내 프로필 정보 -->
            <div class="col-md-9">
                <h5>내 프로필</h5>
                <p><strong>아이디:</strong> ${user.userId}</p>
                <p><strong>이메일:</strong> ${user.email}</p>
                
                <!-- 수정 버튼 -->
                <form action="<c:url value='/memberProfile/update'/>" method="post" class="mt-3">
                    <input type="hidden" name="id" value="${user.id}" />
                    
                    <div class="mb-2">
                        <label>이메일 변경</label>
                        <input type="email" class="form-control" name="email" value="${user.email}" />
                    </div>

                    <button type="submit" class="btn btn-primary btn-sm">수정하기</button>
                </form>
            </div>
        </div>

        <hr>

        <!-- 비밀번호 변경 -->
        <h5>비밀번호 변경</h5>
        <form action="<c:url value='/memberProfile/updatePassword'/>" method="post" class="mt-2">

            <div class="mb-2">
                <label>현재 비밀번호</label>
                <input type="password" class="form-control" name="currentPassword" />
            </div>

            <div class="mb-2">
                <label>새 비밀번호</label>
                <input type="password" class="form-control" name="newPassword" />
            </div>

            <div class="mb-2">
                <label>새 비밀번호 확인</label>
                <input type="password" class="form-control" name="confirmPassword" />
            </div>

            <button type="submit" class="btn btn-warning btn-sm">비밀번호 변경</button>
        </form>
    </div>
</div>

<!-- 에러 메시지가 있으면 alert 띄우기 -->
<c:if test="${not empty errorMsg}">
    <script type="text/javascript">
        alert("${errorMsg}");
    </script>
</c:if>

<!-- 패스워드 바꾸면 성공 alert 띄우기 -->
<c:if test="${not empty successMsg}">
    <script type="text/javascript">
        alert("${successMsg}");
    </script>
</c:if>
</body>
</html>
