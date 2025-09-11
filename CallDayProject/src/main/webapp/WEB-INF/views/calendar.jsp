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
<title>공지사항</title>

<link rel="stylesheet" type="text/css" href="<%=cp%>/project1/css/style.css">



</head>
<body>

<div id="wrapper">
	<!--  전체 페이지 상단 헤더 -->
	<div id="topHeader">
	    <div id="headerContent">
	        <img alt="" src="<%=cp%>/project1/img/banner.jpeg" 
	        style="width: 100%; height: 150px; object-fit:fill;" >
	    </div>
	</div>
	
	
	<!--  본문 전체 컨테이너 -->
	<div id="container">
	
	    <!-- 왼쪽 메뉴 -->
	    <div id="sidebar">
	    <!-- 처음에는 숨겨진 로그인 박스 -->
	    <div id="loginBox">
	        <form>
	            <input type="text" placeholder="아이디"/>
	            <input type="password" placeholder="비밀번호"/>
	            <button type="submit">로그인</button>
	            <button type="button">회원가입</button>
	        </form>
	    </div>
	
	        <ul>
	            <li><a href="<%=cp %>/hell/main.do">메인메뉴</a></li>
	            <li><a href="<%=cp %>/hell/exersize.do">식단 및 운동정보</a></li>
	            <li><a href="<%=cp %>/hell/calendar.do">달력</a></li>
	            <li><a href="<%=cp %>/hell/board.do">운동 피드</a></li>
	            <li><a href="<%=cp %>/hell/regist.do">일정등록</a></li>
	        </ul>
	    </div>
	
	    <!-- 오른쪽 콘텐츠 -->
	    <div id="content">
	        <!-- 게시판 -->
	        <table id="bbsTable" height="800">
	        
	            <thead>
	            
	                <tr>
	                
	                    <th colspan="5">
	                    
		                    <span>
		                    
		                    <a href="?year=${preYear}&month=${preMonth}&week=${preWeek}">◀</a>
		                    &nbsp;${displayYear}년${displayMonth}월&nbsp;
		                    <a href="?year=${nextYear}&month=${nextMonth}&week=${nextWeek}">▶</a>
		                    
		                    </span>
		                    
	                    </th>
	                
	                </tr>
	                
	            </thead>
				
				<c:if test="${userId==null}">
				
				<c:forEach var="day" items="${weekDays}" varStatus="status">
				
		            <tbody>
		            
			            	<c:if test="${day==nowDay && displayYear==nowYear && displayMonth==nowMonth}">
			            	
								<td width="100"><font color="red"><b>${day}일(${dayNames[status.index]})</b></font></td>
								
								<td align="left"></td>
								
								<td></td>
							
							</c:if>
						
							<c:if test="${!(day==nowDay && displayYear==nowYear && displayMonth==nowMonth)}">
			            	
								<td width="100"><b>${day}일(${dayNames[status.index]})</b></td>
								
								<td align="left"></td>
								
								<td></td>
							
							</c:if>
						
						
		            </tbody>
	            
	            </c:forEach>
	            
	            </c:if>
	            
	        </table>
	        
	    </div>
	    
	</div>
	
</div>

</body>
</html>