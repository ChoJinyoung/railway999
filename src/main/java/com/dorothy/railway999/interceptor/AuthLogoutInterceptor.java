package com.dorothy.railway999.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthLogoutInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(
		HttpServletRequest request,
		HttpServletResponse response,
		Object handler ) throws Exception {
		
		HttpSession session = request.getSession();
		if( session != null ) {
			session.removeAttribute( "AuthMember" );
			session.invalidate();
		}
		
		response.sendRedirect( "/railway999/" );
		return false;
	}
}

