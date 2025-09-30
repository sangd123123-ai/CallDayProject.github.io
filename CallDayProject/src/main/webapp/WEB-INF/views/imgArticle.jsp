<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jstl문법을 사용하기 위한 태그라이브러리(예:for:each) -->
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이미지 게시판 내용 상세보기</title>
<link rel="stylesheet" type="text/css" href="resources/css/board.css">
<link rel="stylesheet" type="text/css" href="resources/css/article.css">
<link rel="stylesheet" type="text/css" href="resources/css/navbar.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<script type="text/javascript">

function getCsrf() {
	  const token = document.querySelector('meta[name="_csrf"]')?.content;
	  const header = document.querySelector('meta[name="_csrf_header"]')?.content;
	  return { token, header };
	}

//+1 토글
async function toggleLike(heartElement) {
  const boardNum = "${dto.num}";
  const { token, header } = getCsrf();

  const res = await fetch('<%=cp%>/board/voter/' + boardNum, {
    method: 'POST',
    headers: {
      ...(header && token ? { [header]: token } : {}),
      'Accept': 'application/json'
      // body가 없으면 Content-Type 굳이 지정 안 해도 됨
    }
  });

  if (res.status === 401 || res.status === 403) {
    alert('로그인이 필요해! 로그인 페이지로 이동할게.');
    location.href = '<%=cp%>/login';
    return;
  }
  if (!res.ok) {
    alert('좋아요는 한번만 가능합니다. ');
    return;
  }

  const data = await res.json();

  // UI 토글
  if (data.liked) {
    heartElement.classList.add('liked');
    heartElement.textContent = '❤️';
  } else {
    heartElement.classList.remove('liked');
    heartElement.textContent = '🤍';
  }

  // 카운트 반영
  const likeCountElement = document.querySelector('.like-number');
  if (likeCountElement && typeof data.likeCount === 'number') {
    likeCountElement.textContent = data.likeCount;
  }
}
// ================= 댓글기능 ====================

function toggleCommentBtn(input) {
  const btn = input.nextElementSibling;
  const has = input.value.trim().length > 0;
  btn.classList.toggle('active', has);
  btn.disabled = !has; // 실제 클릭 비활성화까지
}

	
//댓글 추가
function addComment(button) {
  const input = button.previousElementSibling;
  const commentText = input.value.trim();
  if (!commentText) return;

  const boardNum = "${dto.num}";
  const pageNum = "${pageNum}";
  const csrfParam = document.querySelector('meta[name="_csrf_parameter"]')?.content;
  const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;

  const form = document.createElement('form');
  form.method = 'POST';
  form.action = '<%=cp%>/answer/create/' + boardNum;

  // content
  const contentInput = document.createElement('input');
  contentInput.type = 'hidden';
  contentInput.name = 'content';
  contentInput.value = commentText;
  form.appendChild(contentInput);

  // pageNum (컨트롤러 기본값 1이지만 유지하면 좋아)
  if (pageNum) {
    const p = document.createElement('input');
    p.type = 'hidden';
    p.name = 'pageNum';
    p.value = pageNum;
    form.appendChild(p);
  }

  // CSRF 필드 추가 (중요!!)
  if (csrfParam && csrfToken) {
    const csrf = document.createElement('input');
    csrf.type = 'hidden';
    csrf.name = csrfParam;
    csrf.value = csrfToken;
    form.appendChild(csrf);
  }

  document.body.appendChild(form);
  form.submit();
}

//게시물 HTML 요소 생성
function createPostElement(imageSrc, caption) {
  const post = document.createElement('div');
  post.className = 'post';
  post.innerHTML = `
    <div class="post-header">
      <div class="profile-pic">나</div>
      <div class="username">my_account</div>
    </div>
    <img src="${imageSrc}" class="post-image">
    <div class="post-actions">
      <div class="action-buttons">
        <span class="heart" onclick="toggleLike(this)">🤍</span>
        <span class="comment-icon">💬</span>
        <span class="share-icon">📤</span>
      </div>
      <div class="like-count"><span class="like-number">0</span>명이 좋아합니다</div>
      <div class="caption">
        <span class="username">my_account</span>
        ${caption || ''}
      </div>
      <div class="post-time">방금 전</div>
      <div class="comments"></div>
    </div>
    <div class="comment-box">
      <input type="text" class="comment-input" placeholder="댓글 달기..." onkeyup="toggleCommentBtn(this)">
      <button class="comment-btn" onclick="addComment(this)">게시</button>
    </div>
  `;              // ← 요 한 줄(닫는 백틱 + 세미콜론) 추가!!
  return post;
}

//댓글 아이콘 클릭 시 입력창으로 스크롤 + 포커스
function focusCommentInput() {
    const input = document.querySelector('.comment-box .comment-input');
    if (!input) return;

    // 스크롤 이동 (댓글 입력창 위치까지)
    input.scrollIntoView({ behavior: 'smooth', block: 'center' });

    // 포커스
    input.focus();
}

//오늘 추가함
// 버튼 활성/비활성

// 수정 모드 전환
function editComment(answerId) {
    const content = document.getElementById("content_" + answerId).innerText;
    document.getElementById("commentInput").value = content;
    document.getElementById("answerId").value = answerId;

    const form = document.getElementById("commentForm");
    form.action = "<%=cp%>/answer/modify?boardNum=${dto.num}&pageNum=${pageNum}";
    form.method = "post";
}

// 삭제
function deleteComment(answerId, boardNum) {
  if (confirm("정말 삭제하시겠습니까?")) {
    location.href = "<%=cp%>/answer/delete/" + answerId + "?boardNum=" + boardNum + "&pageNum=${pageNum}";
  }
}

//===================작동 가능!!!===================
//엔터 키로 댓글 작성 - 수정 xx
document.addEventListener('keypress', function(e) {
    if (e.target.classList.contains('comment-input') && e.key === 'Enter') {
        const button = e.target.nextElementSibling;
        if (button.classList.contains('active')) {
            addComment(button);
        }
    }
});

// 파일 다운로드 함수 - 수정 xx
function downloadFile(num) {
    window.location.href = '<%=cp%>/download.action?num=' + num;
}

</script>

<!-- head 안에 추가 -->
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<meta name="_csrf_parameter" content="${_csrf.parameterName}">

</head>
<body>
<!-- 헤더 css-->
<%@ include file="/WEB-INF/views/main_part/header.jsp"%>

<!-- ======================== 고정 ====================== -->


<div style="height: 60px; background-color: #333;"></div>
<nav class="navbar"> 
<!-- 네비게이션 바를 호출 시킴 -->
<div class="container">

<ul class="menu">
	<li><a href="<%=cp%>/imgBoard.action">Image Board</a></li>
<li><a href="<%=cp%>/imgCreated.action">Image upload</a></li>
<li><a href="<%=cp %>/imgUpdated.action?num=${dto.num}&pageNum=${pageNum}">
	Image Update</a></li>
	</ul>
<!-- 같은 ul 안에 있으면, 오류 메시지가 수정되지 않음! -->
<c:if test="${param.error == 'unauthorizedUpdate'}">
    <script>
        alert("수정 권한이 없습니다.");
    </script>
</c:if>
	
</div>
</nav>

<div id="postsContainer">
<div class="post">
	<div class="post-header">
		<div class="user-badge">${dto.num }</div> 
		<div class="userId">${dto.userId }
		[${dto.subject }]</div>
</div>

<div class="post-image">
	<a href="${imgPath}/${dto.saveFileName}"> 
<img src="${imgPath}/${dto.saveFileName}" alt="업로드 이미지" width="400" height="400">
</a>
</div>
<div class="caption">${dto.content }</div>


<div class="post-actions">
<div class="action-button-container">
	<c:choose>
<c:when test="${isLiked==true}">
	<span class="heart liked icon" onclick="toggleLike(this);">❤️</span>
</c:when>
<c:otherwise>
	<span class="heart icon" onclick="toggleLike(this);">🤍</span> 
</c:otherwise>
</c:choose>

	<span class="comment-icon icon"onclick="focusCommentInput();";>💬</span>
	<a href="<%=cp%>/download.action?num=${dto.num}" class="share-icon icon"
		style="text-decoration: none;" title="파일 다운로드">📤</a>
	<div class="delete-icon-wrapper">
		<a href="${deletePath }?num=${dto.num}&pageNum=${pageNum}">🗑️</a>
	</div>
		<c:if test="${param.error == 'unauthorized'}">
    <script>alert("삭제 권한이 없습니다.");</script>
</c:if>
	
</div>

<div class="like-count">
	<span class="like-number">${likeCount }</span>명이 좋아합니다.
</div>

<!-- 댓글 목록 - 인라인 수정/삭제 가능 -->
<div class="comments">
  <c:forEach var="answer" items="${answerList}">
    <div class="comment" id="comment_${answer.num}">
      <div class="comment-wrapper">
        <span class="username">${answer.author.userId}</span>
        <span class="comment-content" id="content_${answer.num}">${answer.content}</span>
      </div>

        <!-- 로그인 사용자 = 댓글 작성자일 때만 버튼 보이게 -->
       <c:if test="${siteUserId eq answer.author.userId}">
        <div class="comment-actions">
          <span class="edit-icon" onclick="editComment(${answer.num})" title="수정">✏️</span>
          <span class="delete-icon" onclick="deleteComment(${answer.num}, ${answer.board.num})" title="삭제">🗑️</span>
        </div>
      </c:if>
    </div>
  </c:forEach>
</div>

<!-- 댓글 입력 박스 -->
<div class="comment-box">
  <form id="commentForm" method="post" action="<%=cp%>/answer/create/${dto.num}">
    <input type="hidden" name="answerId" id="answerId">
    <input type="hidden" name="boardNum" value="${dto.num}">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    <input type="text" class="comment-input" name="content" id="commentInput" placeholder="댓글 달기...">
    <button type="submit" class="comment-btn" id="commentBtn">게시</button>
  </form>
</div>

</div>
</div>
</div>


<!-- 하단 css-->
<%@ include file="/WEB-INF/views/main_part/footer.jsp"%>

</body>
</html>