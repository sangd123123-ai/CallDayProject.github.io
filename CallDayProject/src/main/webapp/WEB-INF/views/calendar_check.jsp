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
<title>공지사항</title>

	<!-- Bootstrap CSS -->
	<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/bootstrap.min.css">
	
	<link rel="stylesheet" type="text/css" href="<%=cp %>/resources/css/navbar.css">
	
	<link rel="stylesheet" type="text/css" href="<%=cp%>/resources/css/check.css">

</head>

<body>
<%@ include file="/WEB-INF/views/main_part/header.jsp" %>

  <!-- 캘린더 루트: 헤더/푸터가 fixed여도 겹치지 않게 오프셋 적용 -->
  <section class="cdp-cal"
           style="--cdp-header-h:72px; --cdp-footer-h:60px;">
    <div style="height: 50px;"></div>
    <div class="cdp-card">
      <h1 class="cdp-title">오.운.완 캘린더</h1>

      <!-- 툴바: 월 라벨(왼쪽) + 이전/이번달/다음 -->
      <div class="cdp-toolbar" id="cdp-toolbar">
        <div class="cdp-month" id="monthLabel" aria-live="polite">YYYY.MM</div>
        <div class="cdp-btns">
          <button type="button" class="cdp-btn cdp-btn--ghost" id="btnPrev">◀ 이전</button>
          <button type="button" class="cdp-btn cdp-btn--primary" id="btnToday">이번달</button>
          <button type="button" class="cdp-btn cdp-btn--ghost" id="btnNext">다음 ▶</button>
        </div>
      </div>
      
      <div class="cdp-legend" aria-hidden="true">
		  <span class="lg lg--done"></span> 완료
		  <span class="lg lg--today"></span> 오늘
		</div>

		<div class="cdp-weekdays" id="cdp-weekdayRow"></div>
		<ol class="cdp-grid" id="cdp-grid">
		  <c:forEach var="d" items="${days}">
		    <li class="cdp-day ${d.outOfMonth ? 'is-out' : ''}" data-date="${d.isoDate}">
		      <div class="cdp-daynum
		                  ${d.today ? ' is-today' : ''}
		                  ${completedDateMap[d.isoDate] ? ' is-done' : ''}">
		        ${d.dayNum}
		      </div>
		    </li>
		  </c:forEach>
		</ol>
		
    </div>
  </section>

<%@ include file="/WEB-INF/views/main_part/footer.jsp" %>

  <!-- JS -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  /* 1) 전역값: 반드시 최상단에서 한 번만 정의 */
  var CP = '${pageContext.request.contextPath}';
  var CAL_YEAR  = ${calendarYear != null ? calendarYear : java.time.LocalDate.now().getYear()};
  var CAL_MONTH = ${calendarMonth != null ? calendarMonth : java.time.LocalDate.now().getMonthValue()}; // 1~12

  /* 2) 완료 마킹 (문자열 템플릿 대신 문자열 연결로 안전하게) */
  (async function loadCompleted(){
    var year  = CAL_YEAR;
    var month = CAL_MONTH;
    if (year == null || month == null) return;

    try {
      var url = (CP || '') + '/calendar/api/completed?year=' + year + '&month=' + month;
      var res = await fetch(url, { headers: { 'Accept': 'application/json' }, credentials: 'same-origin' });
      if (!res.ok) return;
      var list = await res.json(); // [{date:'yyyy-MM-dd', calCheck:true}, ...]
      list.forEach(function (item) {
        if (!item.calCheck) return;
        var el = document.querySelector('.cdp-grid [data-date="' + item.date + '"] .cdp-daynum');
        if (el) el.classList.add('is-done');
      });
    } catch (e) {
      // 네트워크 실패 시 무시
    }
  })();

  /* 3) 툴바: 라벨 세팅 + 네비게이션 */
  (function initToolbar(){
    var $label = document.getElementById('monthLabel');
    var $prev  = document.getElementById('btnPrev');
    var $next  = document.getElementById('btnNext');
    var $today = document.getElementById('btnToday');

    if (!$label || !$prev || !$next || !$today) return;

    function pad2(n){ return (n<10 ? '0'+n : ''+n); }
    function setLabel(y, m){
      $label.textContent = y + '.' + pad2(m);
      $label.dataset.year  = '' + y;
      $label.dataset.month = '' + m; // 1~12
    }
    function go(y, m){
      window.location.href = (CP || '') + '/calendar/check?year=' + y + '&month=' + m;
    }
    function move(deltaMonths){
      var y = parseInt($label.dataset.year  || CAL_YEAR, 10);
      var m = parseInt($label.dataset.month || CAL_MONTH, 10);
      var d = new Date(y, (m - 1) + deltaMonths, 1);
      go(d.getFullYear(), d.getMonth() + 1);
    }

    // 초기 라벨 표시
    setLabel(CAL_YEAR, CAL_MONTH);

    // 버튼 바인딩
    $prev.addEventListener('click',  function(){ move(-1); });
    $next.addEventListener('click',  function(){ move(+1); });
    $today.addEventListener('click', function(){
      var now = new Date();
      go(now.getFullYear(), now.getMonth() + 1);
    });
  })();
</script>

</body>
</html>