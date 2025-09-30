<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%	
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
    <title>운동 가이드 관리</title>
    
    <jsp:include page="/WEB-INF/views/admin_layout/head_meta.jsp" />
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style type="text/css">
	
	.table td {
	  white-space: normal;   /* 줄바꿈 허용 */
	  word-break: break-word; /* 단어 길면 강제 줄바꿈 */
	}
	.table td, .table th {
		  vertical-align: top; /* 위 정렬 */
		}
		
		.table td:nth-of-type(1) { min-width: 60px; }   /* ID */
		.table td:nth-of-type(2) { min-width: 120px; }  /* 운동명 */
		.table td:nth-of-type(3) { min-width: 75px; }   /* 부위 */
		.table td:nth-of-type(4) { min-width: 130px; }  /* 타겟 근육 */
		.table td:nth-of-type(5) { min-width: 200px; }  /* 효과 */
		.table td:nth-of-type(6) { min-width: 250px; }  /* 방법 */
		.table td:nth-of-type(7) { min-width: 60px; }  /* 영상 */
		.table td:nth-of-type(8) { min-width: 120px; }  /* 관리 */

	
	input.form-control.edit-mode {
	  width: 100% !important;
	  height: 40px !important;
	  line-height: 1.4 !important;
	}
	
	textarea.form-control.edit-mode {
	  width: 100% !important;
	  height: 80px !important;
	  resize: none !important;
	  line-height: 1.5 !important;
	}

	
	input.form-control.edit-mode[name="youtubeUrl"] {
	  min-width: 250px !important;
	  height: 40px !important;
	}

		
</style>
    
</head>
<body class="layout-fixed sidebar-expand-lg sidebar-open bg-body-tertiary">

	<div class="app-wrapper">

		<!-- Header -->
		<jsp:include page="/WEB-INF/views/admin_layout/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/admin_layout/sidebar.jsp" />

<table class="table table-hover align-middle">
  <thead class="table-light">
    <tr>
      <th>ID</th>
      <th>운동명</th>
      <th>부위</th>
      <th>타겟 근육</th>
      <th>효과</th>
      <th>방법</th>
      <th>영상</th>
      <th>관리</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="ex" items="${exerciseList}">
    
     <!-- 부위가 바뀌었을 때 헤더 행 추가 -->
      <c:if test="${currentPart ne ex.exPart}">
        <tr class="table-primary">
          <td colspan="8" class="fw-bold text-center">${ex.exPart}</td>
        </tr>
        <c:set var="currentPart" value="${ex.exPart}" />
      </c:if>
    
    
      <tr>
        <form action="${cp}/admin/exercise/update" method="post">
          <input type="hidden" name="exId" value="${ex.exId}" />

          <!-- ID -->
          <td>${ex.exId}</td>

          <!-- 운동명 -->
          <td>
            <span class="view-mode">${ex.exName}</span>
            <span class="edit-mode d-none">${ex.exName}</span>
          </td>

          <!-- 부위 -->
          <td>
            <span class="view-mode">${ex.exPart}</span>
            <input type="text" name="exPart" value="${ex.exPart}" class="form-control edit-mode d-none"/>
          </td>

          <!-- 타겟 근육 -->
          <td>
            <span class="view-mode">${ex.targetMuscle}</span>
            <input type="text" name="targetMuscle" value="${ex.targetMuscle}" class="form-control edit-mode d-none"/>
          </td>

          <!-- 효과 -->
          <td>
            <span class="view-mode">${ex.effect}</span>
            <textarea name="effect" class="form-control edit-mode d-none">${ex.effect}</textarea>
          </td>

          <!-- 방법 -->
          <td>
            <span class="view-mode">${ex.method}</span>
            <textarea name="method" class="form-control edit-mode d-none">${ex.method}</textarea>
          </td>

          <!-- YouTube -->
          <td>
            <span class="view-mode">
              <a href="${ex.youtubeUrl}" target="_blank">링크</a>
            </span>
            <input type="text" name="youtubeUrl" value="${ex.youtubeUrl}" class="form-control edit-mode d-none"/>
          </td>

          <!-- 관리 버튼 -->
          <td>
            <button type="button" class="btn btn-warning btn-sm toggle-edit view-mode">수정</button>
            <button type="button" class="btn btn-secondary btn-sm edit-mode d-none cancel-edit">취소</button>
            <button type="submit" class="btn btn-success btn-sm edit-mode d-none">저장</button>
            <button type="button" class="btn btn-danger btn-sm delete-btn" data-id="${ex.exId}">삭제</button>
          </td>
        </form>
      </tr>
    </c:forEach>
  </tbody>
</table>

			<!-- Footer -->
		<jsp:include page="/WEB-INF/views/admin_layout/footer.jsp" />
	</div>


	<!-- 공통 JS -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/browser/overlayscrollbars.browser.es6.min.js"></script>
	<script src="${cp}/resources/admin.js/adminlte.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<script type="text/javascript">
	// 수정 버튼 → 수정 모드 전환
	$(document).on("click", ".toggle-edit", function() {
	  let row = $(this).closest("tr");
	  row.find(".view-mode").addClass("d-none");
	  row.find(".edit-mode").removeClass("d-none");
	});

	// 취소 버튼 → 원래 보기 모드로 복귀
	$(document).on("click", ".cancel-edit", function() {
	  let row = $(this).closest("tr");
	  row.find(".edit-mode").addClass("d-none");
	  row.find(".view-mode").removeClass("d-none");
	});

	// 삭제 버튼 → 확인 후 이동
	$(document).on("click", ".delete-btn", function() {
	  let id = $(this).data("id");
	  if (confirm("정말 삭제하시겠습니까?")) {
	    window.location.href = "${cp}/admin/exercise/delete?exId=" + id;
	  }
	});

	</script>

</body>
</html>
