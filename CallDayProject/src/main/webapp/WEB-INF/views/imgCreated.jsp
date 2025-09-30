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
<link rel="stylesheet" type="text/css" href="resources/css/upload.css">
<link rel="stylesheet" type="text/css" href="resources/css/navbar.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<script type="text/javascript">

function sendIt() {
	
	var f = document.myForm;
	
	//1.제목
	var str = f.subject.value.trim();
	
	if(!str){
		alert("\n제목을 입력하세요.");
		f.subject.focus();
		return;
	}
	
	//2.피드 정보
	str = f.content.value.trim();
	if(!str){
		alert("\n내용을 입력하세요.");
		f.content.focus();
		return;
	}
	
	//3.이미지
	str = f.upload.value.trim();
	if(!str){
	    alert("\n파일을 등록해주세요.");
	    f.upload.focus();
	    return;
	}
	
	f.submit();

}
</script>
</head>
<body>
<!-- 헤더 css-->
<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<!-- ======================== 고정 ====================== -->
<div style="height: 60px;"></div>
	<!-- 오른쪽 콘텐츠 -->
	<div id="content">
<div>
	
<div class="upload-form">
	<h2>새 게시물 만들기</h2>
	<form action="<%=cp%>/imgCreated.action" name="myForm" method="post" enctype="multipart/form-data">
		
		<label>사 용 자 ID</label>
		<input type="text" name="userId" value="${siteUserId}"/>
		
		<label>제&nbsp;&nbsp;&nbsp;&nbsp;목</label>
		<input type="text" name="subject" placeholder="피드 제목을 입력하세요.">
		
		<label>피 드 정 보</label>
		<textarea name="content" placeholder="내용을 입력하세요."></textarea>
				
		<br/>
		<label>피드 이미지</label>
		<input type="file" name="upload">
		<small style="color: #8e8e8e;">JPG, PNG 파일을 업로드할 수 있습니다.</small>
		
		<br/>
		<br/>
		<button type="button" name="t1" onclick="sendIt();">피드 업로드</button>
		
		<button type="button" name="t4"
		onclick="javascript:location.href='<%=cp %>/imgBoard.action${params }';">업로드 취소</button>
			 
		</form>
	</div>
		
</div>
  
</div>
	
<!-- 하단 css-->
<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>

</body>
</html>