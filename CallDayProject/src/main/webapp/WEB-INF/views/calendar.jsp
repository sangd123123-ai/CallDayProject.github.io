<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>캘린더</title>
	
	<!-- Bootstrap CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/navbar.css">
	
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/calendar.css">
	
</head>

<body class="d-flex flex-column min-vh-100">

<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

<div style="height: 60px;"></div>

<div class="calendar-page">

<main class="container">

   <div id="content">
       
	<div class="calendar-header">

		<div class="title">

			<span>${baseDate}</span>

		</div>
		
		<div class="welcome">
		
			<span class="username"><c:out value="${user.userName}"/></span>님 캘린더
			
		</div>
	
		<div class="controls">

			<div class="btn-group">
			  <a class="link-btn btn-nav" href="<%=cp%>/calendar/week/shift?date=${baseDate}&offset=-1"><span class="ico ico--left">«</span>이전주</a>
			  <a class="link-btn btn-compact" href="<%=cp%>/calendar/week/today">오늘</a>
			  <a class="link-btn btn-nav" href="<%=cp%>/calendar/week/shift?date=${baseDate}&offset=1">다음주<span class="ico ico--right">»</span></a>
			</div>

			<form class="jump-form" method="post" action="<%=cp%>/calendar/week/jump">
		
				<input type="date" name="targetDate" value="${baseDate}">
		
				<button type="submit" class="btn-compact">이동</button>
		
			</form>
		
		</div>
	
	</div>
	
	<div class="meta">

		주 날짜: ${week.monday} ~ ${week.sunday}

	</div>
	
	<form id="calendarForm" action="/calendar/week" method="post">

		<input type="hidden" name="targetDate" id="targetDate"/>

		<input type="hidden" name="calNum" id="calNum" />
		
		<div class="container">
	
			<div class="week-vertical">
				
				<c:forEach var="d" items="${week.days}">

					<details class="day-card ${d.today ? 'today' : ''}" <c:if test="${d.isoYmd == selectedDate}">open</c:if>>

						<summary class="day-summary" onclick="setDate('${d.isoYmd}')">
				
							<span class="day-title">${d.labelE} <span class="muted">(${d.labelMd})</span></span>
					
							<span class="muted">${d.isoYmd}</span>
						
						</summary>
						
						<div class="day-body">

							<c:choose>

								<c:when test="${not empty byDate[d.isoYmd]}">

									<ul class="schedule-list">

										<c:forEach var="it" items="${byDate[d.isoYmd]}">
	
											<li class="event" style="cursor:pointer;" onclick="showDetail('${d.isoYmd}', '${it.calNum}')">
												
												<span class="chip ${it.calPart}">
												  <c:choose>
												    <c:when test="${it.calPart == 'cardio'}">유산소</c:when>
												    <c:when test="${it.calPart == 'strength'}">근력운동</c:when>
												    <c:when test="${it.calPart == 'combat'}">격투기</c:when>
												    <c:when test="${it.calPart == 'outdoor'}">야외활동</c:when>
												    <c:when test="${it.calPart == 'sports'}">구기스포츠</c:when>
												    <c:when test="${it.calPart == 'bodymind'}">바디마인드</c:when>
												    <c:otherwise>${it.calPart}</c:otherwise>
												  </c:choose>
												</span>
									
												<span class="subject">${it.calSubject}</span>
	
												<span class="meta">${it.calDate}</span>
									
											</li>
	
										</c:forEach>

									</ul>
									
								</c:when>

								<c:otherwise>

									<div class="empty">일정 없음</div>

								</c:otherwise>

							</c:choose>

						</div>

					</details>

				</c:forEach>

			</div>
		
			<div class="schedule" id="scheduleArea">
			    
				<c:choose>

					<c:when test="${not empty selectedEvent}">

						<div class="cdp-note">
						  <div class="cdp-note__head">
						    <div class="cdp-note__title">
						      <span class="cdp-pin" aria-hidden="true">📌</span>
						      <h3>${selectedEvent.calSubject}</h3>
						      <c:if test="${selectedEvent.calCheck}"> <!-- boolean이면 그대로, 'Y'면 == 'Y' -->
						        <span class="cdp-badge cdp-badge--done">완료됨</span>
						      </c:if>
						    </div>
						  </div>
						
							  <dl class="cdp-meta">
							    <div class="cdp-meta__row">
							      <dt><i class="i i-part" aria-hidden="true"></i>운동카테고리</dt>
							      <dd class="chip ${selectedEvent.calPart}">
									  <c:choose>
									    <c:when test="${selectedEvent.calPart == 'cardio'}">유산소</c:when>
									    <c:when test="${selectedEvent.calPart == 'strength'}">근력운동</c:when>
									    <c:when test="${selectedEvent.calPart == 'combat'}">격투기</c:when>
									    <c:when test="${selectedEvent.calPart == 'outdoor'}">야외활동</c:when>
									    <c:when test="${selectedEvent.calPart == 'sports'}">구기스포츠</c:when>
									    <c:when test="${selectedEvent.calPart == 'bodymind'}">바디마인드</c:when>
									    <c:otherwise>${selectedEvent.calPart}</c:otherwise>
									  </c:choose>
									</dd>
							    </div>
							    <div class="cdp-meta__row">
							      <dt><i class="i i-cat" aria-hidden="true"></i>운동종목</dt>
							      <dd>${selectedEvent.calName}</dd>
							    </div>
							    <div class="cdp-meta__row">
							      <dt><i class="i i-time" aria-hidden="true"></i>소요시간</dt>
							      <dd>${selectedEvent.leadTime}</dd>
							    </div>
							    <div class="cdp-meta__row">
							      <dt><i class="i i-date" aria-hidden="true"></i>운동날짜</dt>
							      <dd>${selectedEvent.calDate}</dd>
							    </div>
							  </dl>
							
							  <div class="cdp-note__body">
							    <div class="cdp-note__label">내용</div>
							    <p class="cdp-note__content">${selectedEvent.calContent}</p>
							  </div>
							
							<div class="article-actions">
								<c:url var="editUrl" value="/calendar/edit">
								  <c:param name="calNum" value="${selectedEvent.calNum}"/>
								</c:url>
								
								<button type="button" class="btn btn-edit"
									onclick="location.href='${editUrl}'">
									
									수정
									
								</button>
							
								<button type="submit" class="btn btn-delete"
									form="deleteForm" onclick="return confirmDelete()">
									
									삭제
									
								</button>
								
							</div>
							
						</div>
			
					</c:when>
			
					  <c:when test="${empty selectedEvent and empty schedules}">
					    <div class="schedule-empty">
							<div class="schedule-empty__icon">📭</div>
							<div class="schedule-empty__title">일정이 없어요</div>
							<div class="schedule-empty__sub">일정을 추가해보세요</div>
							<a href="${CP}/exercise/ex_create"
							   class="cal_add_btn cal_add_btn--primary cal_add_btn--lg cal_add_btn--elevated">
							  <span class="i plus">＋</span> 일정추가
							</a>
					    </div>
					  </c:when>
					
					<c:otherwise>
						
						<h3 class="title">📅 ${selectedDate} 일정</h3>
						
						<ul class="schedule-list">
								
							<c:forEach var="it" items="${schedules}">

								<li class="event">
								
									<span class="chip ${it.calPart}">
									  <c:choose>
									    <c:when test="${it.calPart == 'cardio'}">유산소</c:when>
									    <c:when test="${it.calPart == 'strength'}">근력운동</c:when>
									    <c:when test="${it.calPart == 'combat'}">격투기</c:when>
									    <c:when test="${it.calPart == 'outdoor'}">야외활동</c:when>
									    <c:when test="${it.calPart == 'sports'}">구기스포츠</c:when>
									    <c:when test="${it.calPart == 'bodymind'}">바디마인드</c:when>
									  </c:choose>
									</span>
									
									<span class="name" style="font-size: 9pt;">${it.calName}</span>
									
									<span class="subject">${it.calSubject}</span>
									
									<span class="meta">${it.calDate}</span>
									
									<c:url var="toggleUrl" value="/calendar/${it.calNum}/toggle"/>
									<button type="button"
									        class="app-complete app-sm"
									        data-url="${pageContext.request.contextPath}/calendar/${it.calNum}/complete"
									        data-done="${it.calCheck}" ${it.calCheck ? "disabled" : ""}>
											<span class="app-complete__label">${it.calCheck ? "완료됨" : "완료하기"}</span>
									</button>
									
								</li>
								
							</c:forEach>
							
						</ul>
						
					</c:otherwise>
					
				</c:choose>
				
			</div>
			
		</div>
		
	</form>
       
   </div>
   
</main>  

<form id="deleteForm" method="post" action="<c:url value='/calendar/delete'/>" style="display:none">
	
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	
	<input type="hidden" name="calNum" id="delCalNum"/>
	
	<input type="hidden" name="date" id="delDate" value="${selectedDate}"/>

</form>

<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>

</div>

  <!-- JS -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript">
	
	const isMobile = window.matchMedia('(max-width: 640px)').matches;
	if (isMobile) {
	  hc.style.left = '12px';
	  hc.style.right = '12px';
	  hc.style.top = (r.bottom + gap) + 'px';
	}
	
	function showDetail(date, calNum) {
		
	    console.log("submit start", date, calNum);
	    document.getElementById("targetDate").value = date;
	    document.getElementById("calNum").value = calNum;
	    document.getElementById("calendarForm").submit();
	    
	}

	function setDate(date) {
		
	    console.log("setDate", date);
	    document.getElementById("targetDate").value = date;
	    document.getElementById("calendarForm").submit();
	    
	}
	
	function confirmDelete(){
		
		document.getElementById('delCalNum').value='${selectedEvent.calNum}';
		
		var d = (document.getElementById('targetDate')||{}).value || '${selectedDate}';
		
		document.getElementById('delDate').value = d;
		
		return confirm('정말 삭제할까요?');
	  
	}
	
	document.addEventListener('DOMContentLoaded', function () {
		  // ── 공통 값
		  var CP = '<c:out value="${pageContext.request.contextPath}"/>' || '';
		  var CSRF_HEADER = '${_csrf.headerName}' || (document.querySelector('meta[name="_csrf_header"]')?.content || '');
		  var CSRF_TOKEN  = '${_csrf.token}'      || (document.querySelector('meta[name="_csrf"]')?.content || '');

		  // 초기 상태: 서버가 Y(또는 true) 내려준 애는 잠궈두기
		  document.querySelectorAll('.app-complete').forEach(function(btn){
		    var done = (btn.dataset.done === 'true') || (btn.dataset.done === 'Y');
		    if (done) {
		      btn.disabled = true;
		      btn.classList.add('is-done');
		      var label = btn.querySelector('.app-complete__label') || btn.querySelector('span:last-child');
		      if (label) label.textContent = '완료됨';
		    }
		  });

		  document.addEventListener('click', async function (e) {
		    var btn = e.target.closest('.app-complete');
		    if (!btn) return;

		    if (btn.disabled || btn.dataset.done === 'true' || btn.dataset.done === 'Y') {
		      console.debug('[done-btn] skip: already disabled/done');
		      return;
		    }

		    var calNum = btn.dataset.calnum || btn.dataset.calNum;
		    var explicitUrl = btn.dataset.url;
		    var url = explicitUrl
		      || (calNum ? (CP + '/calendar/' + encodeURIComponent(calNum) + '/complete') : '')
		      || (CP + '/calendar/done');

		    var body = '';
		    if (!explicitUrl && url.endsWith('/calendar/done')) {
		      if (!calNum) { console.error('[done-btn] calNum missing'); alert('식별자 누락'); return; }
		      body = 'calNum=' + encodeURIComponent(calNum);
		    }

		    btn.disabled = true;

		    var headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
		    if (CSRF_HEADER && CSRF_TOKEN) headers[CSRF_HEADER] = CSRF_TOKEN;

		    console.debug('[done-btn] POST', url, { calNum: calNum, headers: headers, body: body });

		    try {
		      var res  = await fetch(url, { method:'POST', headers: headers, body: body, credentials:'same-origin' });
		      var text = await res.text();

		      console.debug('[done-btn] response', res.status, text);

		      if (!res.ok) {
		        btn.disabled = false;
		        alert('완료 처리 실패 (HTTP ' + res.status + ')');
		        return;
		      }

		      var data = {};
		      try { data = JSON.parse(text); } catch (e) { }

		      var nowDone =
		        data.status === 'done' || data.status === 'already_done' ||
		        data.calCheck === true || data.cal_check === true ||
		        data.calCheck === 'Y'  || data.cal_check === 'Y';

		      if (nowDone) {
		        btn.dataset.done = 'true';
		        btn.classList.add('is-done');
		        var label = btn.querySelector('.app-complete__label') || btn.querySelector('span:last-child');
		        if (label) label.textContent = '완료됨';
		      } else {
		        btn.disabled = false;
		        var label2 = btn.querySelector('.app-complete__label') || btn.querySelector('span:last-child');
		        if (label2) label2.textContent = '완료하기';
		      }
		    } catch (err) {
		      btn.disabled = false;
		      console.error('[done-btn] fetch error', err);
		      alert('네트워크 오류');
		    }
		  });
		});
	
	document.addEventListener('DOMContentLoaded', function(){
		  var selected = document.querySelector('.week-day[data-date="${selectedDate}"]');
		  if (selected) {
		    selected.classList.add('is-active');
		    if (typeof openDay === 'function') {
		      openDay(selected.dataset.date);
		    } else {
		      selected.click();
		    }
		  }

		  var dateInput = document.querySelector('#datePicker');
		  if (dateInput && !dateInput.value) dateInput.value = "${selectedDate}";
		});
	
</script>

</body>
</html>