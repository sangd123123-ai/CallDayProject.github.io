<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%	
	String cp = request.getContextPath();
	request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
    <title>회원 관리</title>
    <jsp:include page="/WEB-INF/views/admin_layout/head_meta.jsp" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
      /* 텍스트에어리아 크기 조절 비활성화 및 고정 높이 */
      textarea.form-control.edit-mode,
      .edit-mode textarea.form-control {
        height: 180px !important;
        resize: none !important;
        overflow-y: auto;
      }
      
      /* 제목 input 확장 */
      .edit-mode input[name="title"] {
        min-width: 200px;
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
<body
	class="layout-fixed sidebar-expand-lg sidebar-open bg-body-tertiary">

	<div class="app-wrapper">

		<!-- Header -->
		<jsp:include page="/WEB-INF/views/admin_layout/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/WEB-INF/views/admin_layout/sidebar.jsp" />



		<!-- Content -->
		<main class="container my-4">
			<div class="card shadow-sm border-0">
				<div class="card-header bg-light">
					<h5 class="mb-0 fw-bold">스토어 상품 등록</h5>
				</div>
				<div class="card-body">
					<!-- required는 혁신이다 -->
					<!-- 상품 등록 폼 -->
					<form action="${cp}/admin/mainstore" method="post"
						enctype="multipart/form-data" class="row g-3">

						<div class="col-12">
							<label class="form-label fw-semibold">상품명</label> 
							<input type="text" name="title" class="form-control" required>
						</div>

						<div class="col-12">
							<label class="form-label fw-semibold">설명</label>
							<textarea name="content" class="form-control" rows="3"></textarea>
						</div>

						<div class="col-md-6">
							<label class="form-label fw-semibold">가격</label> 
							<input type="number" name="price" class="form-control" required>
						</div>

						<div class="col-md-6">
							<label class="form-label fw-semibold">링크</label> 
							<input type="text" name="linkUrl" class="form-control">
						</div>

						<div class="col-12">
							<label class="form-label fw-semibold">이미지</label> 
							<input type="file" name="imageFile" class="form-control" required>
						</div>

						<div class="col-12 text-end">
							<button type="submit" class="btn btn-success px-4">등록</button>
						</div>

					 </form>
				</div>
			</div>

			<!-- 등록된 상품 목록 (조회/수정/삭제용) -->
			<div class="card mt-4 shadow-sm border-0">
				<div class="card-header bg-light">
					<h6 class="mb-0 fw-bold">등록된 상품 목록</h6>
				</div>
				<div class="card-body">
					<table class="table table-hover align-middle">
						<thead class="table-light">
							<tr>
								<th>번호</th>
								<th>이미지</th>
								<th>상품명</th>
								<th>설명</th>
								<th>가격</th>
								<th>링크</th>
								<th>관리</th>
							</tr>
						</thead>
						
						<tbody>
						  <c:forEach var="product" items="${products}">
						    <tr>
						      <!-- 각 행마다 form 감싸기 -->
						      <form action="${cp}/admin/updateStore" method="post" enctype="multipart/form-data">
						        <td>
						          ${product.id}
						          <input type="hidden" name="id" value="${product.id}" />
						        </td>
						
						        <td>
						          <span class="view-mode">
						            <img src="${cp}/resources/main/store/${product.saveFileName}" width="80" />
						          </span>
						          <input type="file" name="imageFile" class="form-control edit-mode d-none" />
						        </td>
						
						        <td>
						          <span class="view-mode">${product.title}</span>
						          <input type="text" name="title" value="${product.title}" class="form-control edit-mode d-none" />
						        </td>
						
						        <td>
						          <span class="view-mode">${product.content}</span>
						          <textarea name="content" class="form-control edit-mode d-none">${product.content}</textarea>
						        </td>
						
						        <td>
						          <span class="view-mode">
						            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩" />
						          </span>
						          <input type="number" name="price" value="${product.price}" class="form-control edit-mode d-none" />
						        </td>
						
						        <td>
						          <span class="view-mode">
						            <a href="${product.linkUrl}" target="_blank">바로가기</a>
						          </span>
						          <input type="text" name="linkUrl" value="${product.linkUrl}" class="form-control edit-mode d-none" />
						        </td>
						
						        <td>
						          <button type="button" class="btn btn-warning btn-sm toggle-edit view-mode">수정</button>
						          <button type="submit" class="btn btn-success btn-sm edit-mode d-none">저장</button>
						          <button type="button" class="btn btn-secondary btn-sm edit-mode d-none cancel-edit">취소</button>
						          <button type="button" class="btn btn-danger btn-sm delete-btn" data-id="${product.id}">삭제</button>
						        </td>
						      </form>
						    </tr>
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
	    row.find(".view-mode").addClass("d-none");   // 보기 숨김
	    row.find(".edit-mode").removeClass("d-none"); // 수정 보임
	  });
	
	  // 취소 버튼 클릭 → 다시 보기 모드로
	  $(document).on("click", ".cancel-edit", function() {
	    let row = $(this).closest("tr");
	    row.find(".edit-mode").addClass("d-none");
	    row.find(".view-mode").removeClass("d-none");
	  });
	
	  // 삭제 버튼 클릭 → 확인창
	  $(document).on("click", ".delete-btn", function() {
	    let productId = $(this).data("id");
	    if (confirm("정말 삭제하시겠습니까?")) {
	      window.location.href = "${cp}/admin/deleteStore?id=" + productId;
	    }
	  });
	});
</script>

</body>
</html>
