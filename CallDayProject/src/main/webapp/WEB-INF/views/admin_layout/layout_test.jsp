<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>AdminLTE Layout</title>
  <jsp:include page="/WEB-INF/views/admin_layout/head_meta.jsp" />
</head>

<body class="layout-fixed sidebar-expand-lg sidebar-open bg-body-tertiary">

  <div class="app-wrapper">
    
    <!-- Header -->
    <jsp:include page="/WEB-INF/views/admin_layout/header.jsp" />

    <!-- Sidebar -->
    <jsp:include page="/WEB-INF/views/admin_layout/sidebar.jsp" />
    


    <!-- Content -->
    <main class="app-main">
	      <div class="card mb-4">
			  <div class="card-header">
			    <h3 class="card-title">최근 7일 방문자 수</h3>
			  </div>
			  <div class="card-body">
			    <div id="visitorsChart"></div>
			  </div>
			</div>
			
			<!-- 최근 7일 좋아요 수 -->
		  <div class="card mb-4">
		    <div class="card-header">
		      <h3 class="card-title">최근 7일 좋아요 수</h3>
		    </div>
		    <div class="card-body">
		      <div id="likesChart"></div>
		    </div>
		  </div>
		</main>
		
		<c:forEach var="l" items="${likeStats}">
  ${l.likeDate} / ${l.cnt}<br>
</c:forEach>
			


    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/admin_layout/footer.jsp" />
  </div>

  <!-- JS -->
  <script src="https://cdn.jsdelivr.net/npm/overlayscrollbars@2.11.0/browser/overlayscrollbars.browser.es6.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="${cp}/resources/admin.js/adminlte.min.js"></script>
  <!-- 그래프 API -->
  <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>	

<script>


  const visitorStats = [
    <c:forEach var="v" items="${visitorStats}" varStatus="st">
      { VISIT_DATE: "${v.VISIT_DATE}", CNT: ${v.CNT} }<c:if test="${!st.last}">,</c:if>
    </c:forEach>
  ];

  const dates = visitorStats.map(v => v.VISIT_DATE);
  const counts = visitorStats.map(v => v.CNT);

  const options = {
    chart: { type: 'line', height: 300 },
    series: [{ name: '방문자 수', data: counts }],
    xaxis: { categories: dates },
    colors: ['#0d6efd']
  };

  new ApexCharts(document.querySelector("#visitorsChart"), options).render();
  
  //  좋아요 데이터
  const likeStats = [
  <c:forEach var="l" items="${likeStats}" varStatus="st">
    { likeDate: "${l.likeDate}", cnt: ${l.cnt} }<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

const likeDates = likeStats.map(l => l.likeDate);
const likeCounts = likeStats.map(l => l.cnt);


  new ApexCharts(document.querySelector("#likesChart"), {
    chart: { type: 'line', height: 300 },
    series: [{ name: '좋아요 수', data: likeCounts }],
    xaxis: { categories: likeDates },
    colors: ['#e83e8c'] // 분홍/레드 계열
  }).render();
</script>

  
  
  
</body>   

</html>
