package com.cdp.health.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import lombok.RequiredArgsConstructor;

//방문자의 실제 방문 기록을 남기는 로직
//HandlerInterceptor는 Spring MVC 요청 처리 전/후에 끼어드는 "가로채기" 역할을 함.
//WebMvcConfig으로 이어짐
@RequiredArgsConstructor
public class VisitorInterceptor implements HandlerInterceptor{
	
	private final AdminService adminservice;
	
	 static {
	        System.out.println(">>> VisitorInterceptor 클래스 로딩됨!");
	    }
	 @Override
	    public boolean preHandle(
	    		HttpServletRequest request, 
	    		HttpServletResponse response, 
	    		Object handler) {
		 
		 System.out.println(">>> VisitorInterceptor preHandle 실행됨!");
	        String ip = request.getRemoteAddr();
	        String userAgent = request.getHeader("User-Agent");
	        
	        // 여기! 로그 찍는 부분
	        System.out.println(">> VisitorInterceptor 실행됨! IP=" + ip + " / UserAgent=" + userAgent);
	        adminservice.logVisit(ip, userAgent);
	        
	        return true;
	    }

}
