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
	        <table id="bbsTable">
	            <thead>
	                <tr>
	                    <th colspan="5" class="sectionTitle"><span> 운동 정보 공유 게시판 </span></th>
	                </tr>
	            </thead>
	
	            <tbody>
	            
	            
	            
                <!-- 첫 번째 행 -->
                <tr>
                    <td style="padding: 10px; align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/vvv.jpg">
                        <br>
                        <strong>이미지</strong>
                        <br>
                        
                    </td>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/다이어트.jpg">
                        <br>
                        <strong>이미지</strong>
                        <br>
                       
                    </td>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/ssss.jpg">
                        <br>
                        <strong>이미지</strong>
                        <br>
                        
                    </td>
                </tr>
                
                <!-- 두 번째 행 -->
                <tr>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/딥슬립.jpg">
                        <br>
                        <strong>이미지1</strong>
                        <br>
                        <small>2024.08.28</small>
                    </td>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/g.jpg">
                        <br>
                        <strong>이미지2</strong>
                        <br>
                        <small>2024.08.30</small>
                    </td>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/a.jpg">
                        <br>
                        <strong>이미지3</strong>
                        <br>
                    </td>
                </tr>
                
                <!-- 세 번째 행 -->
                <tr>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/b.jpg">
                        <br>
                        <strong>이미지</strong>
                        <br>
                    </td>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/ccc.jpg">
                        <br>
                        <strong>이미지</strong>
                        <br>
                    </td>
                    <td style="padding: 10px; text-align: center; border: 1px solid #ddd;">
                        <img src="<%=cp%>/project1/img/aaa.jpg">
                        <br>
                        <strong>이미지</strong>
                        <br>
                    </td>
                </tr>
            </tbody>
	        </table>
	    </div>
	    
	    <!--  -->
	</div>
</div>

</body>
</html>