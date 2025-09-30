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
<title>운동 피드 리스트</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/css/board.css">
<link rel="stylesheet" type="text/css" href="resources/css/navbar.css">
<script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

<script type="text/javascript">
  // CSRF 토큰 가져오기
  function getCsrf() {
    const token = document.querySelector('meta[name="_csrf"]')?.content;
    const header = document.querySelector('meta[name="_csrf_header"]')?.content;
    return { token, header };
  }

  // 좋아요 토글 함수
  async function toggleLike(heartElement, boardNum) {
    const { token, header } = getCsrf();

    // 좋아요 상태를 토글하는 요청
    const res = await fetch('<%=cp%>/board/voter/' + boardNum, {
      method: 'POST',
      headers: {
        ...(header && token ? { [header]: token } : {}),
        'Accept': 'application/json'
      }
    });
    if (!res.ok) {
      alert('좋아요는 한번만 가능합니다.');
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

    // 좋아요 수 업데이트
    const likeCountElement = heartElement.closest('.post-actions').querySelector('.like-number');
    if (likeCountElement && typeof data.likeCount === 'number') {
      likeCountElement.textContent = data.likeCount;
    }
  }
</script>

</head>
<body>

<!-- 헤더 css-->
<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<!-- ======================== 고정 ====================== -->

<div style="height: 60px;"></div>
<br/>
<br/>
<div id="content">
<div class="board-header">
<div id = "leftHeader">
    <form action="<%=cp %>/imgBoard.action" name="searchForm" method="get">
    <select name="searchKey">
		<option value="subject">제목</option>
		<option value="userId">이름</option>
		<option value="content">내용</option>
    </select>
    <input type="text" name="searchValue" class="textFiled"placeholder="검색어 입력"/>
    <input type="submit" value=" 검 색 " class="btn2"/>
    </form>
</div>

<div class="article-actions">
<button type="button" class="btn ${isLiked ? 'btn-danger' : 'btn-outline-danger'} like-btn" 
onclick="javascript:location.href='<%=cp %>/imgCreated.action';">게시물 등록
    </button>
</div>
</div>

<!-- ============== 이미지 게시판 시작점 ============== -->

<table width="900" border="0" cellpadding="0" cellspacing="0" style="margin: auto;">
<tr><td height="3" bgcolor="#DBDBDB" align="center"></td></tr>
</table>

<br/>
<table width="960" border="0" cellspacing="30" cellpadding="0"
   bgColor="#FFFFFF" style="margin: 30px auto 50px auto;">

<!-- 이미지가 몇 번째 출력되는지 세기 위한 변수 (n초기화) -->

<c:set var="n" value="0"/>
<c:forEach var="dto" items="${lists}">      
<c:if test="${n==0}">
    <tr bgcolor="#FFFFFF" >
  </c:if>

  <c:if test="${n!=0&&n%3==0 }">
    </tr><tr bgcolor="#FFFFFF" >
  </c:if>

<!-- 사진 디자인 설정 + 이미지 저장 경로 -->

<td width="300" align="center" style="padding: 0; vertical-align: top;">
  <a href="<%=cp %>/imgArticle.action?num=${dto.num}&pageNum=${pageNum}" 
    style="text-decoration: none; color: inherit;">
    
    <div class="card-item" style="width: 300px; margin: 0;"> 
          
      <div class="card-image-container">
        <c:choose>
          <c:when test="${not empty dto.saveFileName}">
            <img src="${imgPath}/${dto.saveFileName}" alt="${dto.subject} 이미지"/>
          </c:when>
          <c:otherwise>
            <span class="no-image-icon">&#128444;</span>
          </c:otherwise>
        </c:choose>
      </div>
      
<!-- 좋아요 버튼 클릭 시 toggleLike 함수 호출 -->
<div class="card-content">
  <div class="card-heading">
    <span class="board-subject">${dto.subject}</span>
            
    <div class="post-actions">
      <c:set var="isItemLiked" value="${likedMap[dto.num]}"/>
      <c:choose>
        <c:when test="${isItemLiked}">
          <span class="heart liked" onclick="toggleLike(this, ${dto.num}); event.preventDefault(); event.stopPropagation();">❤️</span>
        </c:when>
        <c:otherwise>
          <span class="heart" onclick="toggleLike(this, ${dto.num}); event.preventDefault(); event.stopPropagation();">🤍</span>
        </c:otherwise>
      </c:choose>
      <span class="like-number" data-num="${dto.num}">${likeCountMap[dto.num]}</span>
    </div>
  </div>
</div>
    </div>
  </a>
  </td>
<c:set var="n" value="${n+1}"/>
</c:forEach>  

<c:if test="${n > 0}">
    <c:forEach begin="${n % 3}" end="${2}">
        <c:if test="${n % 3 != 0}">
            <td width="300" style="padding: 0;">&nbsp;</td>
        </c:if>
    </c:forEach>
</c:if>

<!-- 페이징 처리 (데이터가 있을 때 & 없을 때) -->
<c:if test="${dataCount != 0}">
  <tr bgcolor="#FFFFFF">
    <td align="center" height="30" colspan="3" style="padding-top: 20px;">${pageIndexList}</td>
  </tr>
</c:if>

<c:if test="${dataCount == 0}">
  <tr bgcolor="#FFFFFF">
    <td align="center" colspan="3" height="30">등록된 자료가 없습니다.</td>
  </tr>
</c:if>
</table>

</div>
<!-- 하단 css-->
<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>

</body>
</html>