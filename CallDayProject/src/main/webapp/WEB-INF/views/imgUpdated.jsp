<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 업로드 하는 장소</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/css/upload.css">
<link rel="stylesheet" type="text/css" href="resources/css/navbar.css">

<script type="text/javascript">

	function sendIt() {
		
		f = document.myForm;
		//1.제목
		str = f.subject.value;
		str = str.trim();
		if(!str){
			alert("\n제목을 입력하세요.");
			f.subject.focus();
			return;
		}
		f.subject.value = str;
		
		//2.내용
		str = f.content.value;
		str = str.trim();
		if(!str){
			alert("\n내용을 입력하세요.");
			f.content.focus();
			return;
		}
		f.content.value = str;
		
		f.action = "<%=cp%>/imgUpdated_ok.action";
		f.submit();
	}

</script>
</head>
<body>

<!-- 헤더 css-->
<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<!-- ======================== 고정 ====================== -->
<div style="height: 60px;"></div>
	
<div class="upload-form">
	<h3>운동 피드 수정</h3>
	<form action="<%=cp%>/imgUpdated_ok.action" name="myForm" method="post" enctype="multipart/form-data">
		
		<label>사 용 자 ID</label>
		<input type="text" name="userId" value="${dto.userId }"/>
<%-- <input type="text" name="userId" value="${siteUserId }"/> --%>
		
		<label>제&nbsp;&nbsp;&nbsp;&nbsp;목</label>
		<input type="text" name="subject" value="${dto.subject }"/>
		<br/>
		<label>피 드 정 보 수 정</label>
		<textarea name="content">${dto.content}</textarea>
				
		<br/>
		<label>피드 이미지 수정</label>
		<input type="file" name="upload" value="${dto.saveFileName }"/>
		<small style="color: #8e8e8e;">JPG, PNG 파일을 업로드할 수 있습니다.</small>
		
		<label>현재 게시판 이미지</label>
		<div class="post-image">
		<a href="${imgPath}/${dto.saveFileName}">
		<img src="${imgPath}/${dto.saveFileName}" width="100" height="100"></a>
		</div>
		<br/>
		<button type="button" name="t2" onclick="sendIt();">수정 피드 업로드</button>
		
		<button type="button" name="t4"
		onclick="javascript:location.href='<%=cp %>/imgBoard.action?${params }';">수정 취소</button>

		<input type="hidden" name="num" value="${dto.num }">

		</form>
	</div>
	
<!-- 하단 css-->
<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>


</body>
</html>