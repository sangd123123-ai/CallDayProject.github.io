<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%	
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
<title>배너</title>
<jsp:include page="/WEB-INF/views/admin_layout/head_meta.jsp" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
  /* 텍스트에어리아 크기 조절 비활성화 및 고정 높이 - 우선순위 강화 */
  textarea.form-control.edit-mode,
  .edit-mode textarea.form-control {
    height: 180px !important;
    resize: none !important;
    overflow-y: auto;
  }
  
  /* 제목 input 확장 */
  .edit-mode input[name="title"] {
    width: 400px !important;
  }
  
  /* 테이블 반응형 */
  .table-hover tbody tr:hover {
    background-color: #f8f9fa;
  }
  
  /* 버튼 간격 */
  .btn-sm {
    margin: 2px;
  }
  
  /* 링크 스타일 */
  .view-mode a {
    color: #0d6efd;
    text-decoration: none;
  }
  
  .view-mode a:hover {
    text-decoration: underline;
  }
</style>
</head>
<body class="layout-fixed sidebar-expand-lg sidebar-open bg-body-tertiary">

	<div class="app-wrapper">

		<!-- Header -->
		<jsp:include page="/WEB-INF/views/admin_layout/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/admin_layout/sidebar.jsp" />

		<!-- Content -->
		<main class="container my-4">

			<div class="card shadow-sm">
				<div class="card-header  bg-secondary text-white">
					<h5 class="mb-0">배너 등록</h5>
				</div>
				<div class="card-body">
					<form  method="post" enctype="multipart/form-data" class="row g-3">

						<div class="col-12">
							<label class="form-label fw-semibold">제목</label> 
							<input type="text" name="title" class="form-control" required>
						</div>

						<div class="col-12">
							<label class="form-label fw-semibold">설명</label>
							<textarea name="content" class="form-control" rows="3"></textarea>
						</div>

						<div class="col-12">
							<label class="form-label fw-semibold">링크</label> 
							<input type="text" name="linkUrl" class="form-control">
						</div>

						<div class="col-12">
							<label class="form-label fw-semibold">이미지</label> 
							<input type="file" name="imageFile" class="form-control" required>
						</div>

						<div class="col-12 text-end">
							<button type="submit" class="btn btn-success">등록</button>
						</div>
					</form>
				</div>
			</div>

<!-- 배너 리스트 카드 -->
<div class="card shadow-sm" style="margin-top: 50px">
    <div class="card-header bg-secondary text-white">
        <h5 class="mb-0">배너 목록</h5>
    </div>
    <div class="card-body">
        <table class="table table-hover align-middle">
            <thead class="table-light">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>설명</th>
                    <th>이미지</th>
                    <th>링크</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
			      <c:forEach var="slider" items="${lists}">
			    <form action="${cp}/admin/updateSlider" method="post" enctype="multipart/form-data">
			        <tr>
			            <td>
			                <input type="hidden" name="id" value="${slider.id}"/>
			                ${slider.id}
			            </td>
			            <td>
			                <span class="view-mode">${slider.title}</span>
			                <input type="text" name="title" value="${slider.title}" class="form-control edit-mode d-none" maxlength="100" required/>
			            </td>
			            <td>
			                <span class="view-mode">${slider.content}</span>
			                <textarea name="content" class="form-control edit-mode d-none">${slider.content}</textarea>
			            </td>
			            <td>
			                <span class="view-mode">
			                    <img src="${cp}/resources/main/slider/${slider.saveFileName}" width="80"/>
			                </span>
			                <input type="file" name="imageFile" class="form-control edit-mode d-none"/>
			            </td>
			            <td>
			                <span class="view-mode">${slider.linkUrl}</span>
			                <input type="text" name="linkUrl" value="${slider.linkUrl}" class="form-control edit-mode d-none"/>
			            </td>
			            <td>
			                <button type="button" class="btn btn-warning btn-sm toggle-edit view-mode">수정</button>
			                <button type="submit" class="btn btn-success btn-sm edit-mode d-none">저장</button>
			                <button type="button" class="btn btn-secondary btn-sm edit-mode d-none cancel-edit">취소</button>
			                <button type="button" class="btn btn-danger btn-sm delete-btn"
			                        data-id="${slider.id}" data-type="slider">삭제</button>
			            </td>
			        </tr>
			    </form>
			</c:forEach>

            </tbody>
        </table>
    </div>
</div>


		</main>

		<!-- Footer -->
		<jsp:include page="/WEB-INF/views/admin_layout/footer.jsp" />
	</div>


	<!-- 공통 JS -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/browser/overlayscrollbars.browser.es6.min.js"></script>
	<script src="${cp}/resources/admin.js/adminlte.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
<script type="text/javascript">
$(document).ready(function() {
  // 수정 버튼 클릭 → 수정 모드 전환
  $(document).on("click", ".toggle-edit", function() {
    let row = $(this).closest("tr");
    row.find(".view-mode").addClass("d-none");
    row.find(".edit-mode").removeClass("d-none");
  });

  // 취소 버튼 클릭 → 다시 보기 모드로
  $(document).on("click", ".cancel-edit", function() {
    let row = $(this).closest("tr");
    row.find(".edit-mode").addClass("d-none");
    row.find(".view-mode").removeClass("d-none");
  });

  // 삭제 버튼 클릭 → 확인창
  $(document).on("click", ".delete-btn", function() {
    let sliderId = $(this).data("id");
    if (confirm("정말 삭제하시겠습니까?")) {
      window.location.href = "${cp}/admin/deleteSlider?id=" + sliderId;
    }
  });
});

// 이미지 파일 선택 시 미리보기
$(document).on("change", "input[type='file'][name='imageFile']", function(e) {
  let file = e.target.files[0];
  if (file) {
    let reader = new FileReader();
    reader.onload = function(event) {
      let row = $(e.target).closest("tr");
      let img = row.find("img");
      img.attr("src", event.target.result);
    };
    reader.readAsDataURL(file);
  }
});
</script>
	
</body>
</html>
