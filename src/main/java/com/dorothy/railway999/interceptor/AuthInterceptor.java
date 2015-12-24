package com.dorothy.railway999.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dorothy.railway999.annotation.Auth;
import com.dorothy.railway999.vo.MemberVo;



public class AuthInterceptor extends HandlerInterceptorAdapter {

	
	@Override
	public boolean preHandle(HttpServletRequest request, 
		HttpServletResponse response, Object handler) throws Exception {
		Auth auth = ( ( HandlerMethod ) handler ).getMethodAnnotation( Auth.class );
		if( auth == null ) {
			return true;
		}
		
		HttpSession session = request.getSession();
		if( session == null ) {
			
			response.sendRedirect("/railway999/");
			return false;
		}
		
		MemberVo authMember = (MemberVo)session.getAttribute( "AuthMember" );
		if( authMember == null ) {
			response.sendRedirect( "/railway999/");
			return false;
		}
		
		if( auth.role().equals("Admin") && !"admin".equals(authMember.getRole())){
			response.sendRedirect( "/railway999/");
			return false;
		}
		
		return true;
	}
}