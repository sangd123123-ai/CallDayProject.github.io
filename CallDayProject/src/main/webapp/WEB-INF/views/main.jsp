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
	    
	            <li><a href="<%=cp %>/hell/main.action">메인메뉴</a></li>
	    
	            <li><a href="<%=cp %>/hell/exersize.action">식단 및 운동정보</a></li>
	    
	            <li><a href="<%=cp %>/hell/calendar.action">달력</a></li>
	    
	            <li><a href="<%=cp %>/hell/board.action">운동 피드</a></li>
	    
	            <li><a href="<%=cp %>/hell/regist.action">일정등록</a></li>
	    
	        </ul>
	    
	    </div>
	
	    <!-- 오른쪽 콘텐츠 -->
	    <div id="content">
	        
	        <!-- 게시판 -->
	        <table id="bbsTable">
	        
	            <thead>
	            
					<tr>
					
						<th colspan="5" class="sectionTitle"><span>행사정보</span></th>
					
					</tr>
					
				</thead>
	
				<tbody>
	            
					<td align="center">
						
						<a href="https://www.seoulhealthshow.com/%ED%96%89%EC%82%AC%EA%B0%9C%EC%9A%94">
						
						<img src="<%=cp%>/project1/img/서울헬스쇼 2025-08-25 171220.png" /></a>
						
						<p><b>1</b></p><br/>
						
					</td>
						
					<td align="center">
						
						<a href="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/image_audit/prod/6d308f1f-86d2-4d8f-8ed0-0d67167d12b6_fixing_v2.png">
						
						<img src="<%=cp%>/project1/img/다이어트.jpg"/></a>
						
						<p><b>1</b></p><br/>
						
					</td>
						
					<td align="center">
							
						<a href="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/image_audit/prod/6d308f1f-86d2-4d8f-8ed0-0d67167d12b6_fixing_v2.png">
							
						<img src="<%=cp%>/project1/img/a.jpg"/></a>
						
						<p><b>1</b></p><br/>
						
					</td>
						
				</tbody>
				
			</table>
	        
	        <table id="bbsTable" style="margin-top: 50px">
	        
	            <thead>
	            
	                <tr>
	                
	                    <th colspan="5"  class="sectionTitle"><span>스토어</span></th>
	                    
	                </tr>
	                
	            </thead>
	
	            <tbody>
	            
	                <tr>
	                
						<td align="center">
					     
							<a href="https://www.coupang.com/vp/products/8971065315?itemId=26256188454&vendorItemId=93234604631&sourceType=srp_product_ads&clickEventId=8ef854a0-8188-11f0-aae4-869513bfc617&korePlacement=15&koreSubPlacement=1&clickEventId=8ef854a0-8188-11f0-aae4-869513bfc617&korePlacement=15&koreSubPlacement=1">
					         
							<img src="<%=cp%>/project1/img/d2ea8075-ce96-46f7-ad0d-1d5554df31cb.jpg" /></a><br/>
					     
						</td>
					     
						<td align="center">
					     
							<a href="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/image_audit/prod/6d308f1f-86d2-4d8f-8ed0-0d67167d12b6_fixing_v2.png">
					         
							<img src="<%=cp%>/project1/img/b.jpg" /></a><br/>
					    
						</td>
			
						<td align="center">
			
							<a href="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/image_audit/prod/6d308f1f-86d2-4d8f-8ed0-0d67167d12b6_fixing_v2.png">
			
							<img src="<%=cp%>/project1/img/g.jpg" /></a><br/>
			
						</td>
			
					</tr>
					
					<tr>
			
						<td align="center">
			
							<a href="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/image_audit/prod/6d308f1f-86d2-4d8f-8ed0-0d67167d12b6_fixing_v2.png">
			
							<img src="<%=cp%>/project1/img/pngtree-motion-fitness-equipment-fitness-gym-png-image_330761.jpg" /></a><br/>
			
						</td>
			
						<td align="center">
			
							<a href="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/image_audit/prod/6d308f1f-86d2-4d8f-8ed0-0d67167d12b6_fixing_v2.png">
			
							<img src="<%=cp%>/project1/img/pngtree-motion-fitness-equipment-fitness-gym-png-image_330761.jpg" /></a><br/>
			
						</td>
			
						<td align="center">
			
							<a href="https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/image_audit/prod/6d308f1f-86d2-4d8f-8ed0-0d67167d12b6_fixing_v2.png">
			
							<img src="<%=cp%>/project1/img/pngtree-motion-fitness-equipment-fitness-gym-png-image_330761.jpg" /></a><br/>
			
						</td>
			
					</tr>
	        
				</tbody>
	        
			</table>
	    
	    </div>
	    
	</div>
	
</div>

</body>
</html>