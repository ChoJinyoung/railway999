package com.dorothy.railway999.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.dorothy.railway999.service.MemberService;
import com.dorothy.railway999.vo.MemberVo;


public class AuthLoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		MemberVo vo = new MemberVo();
		vo.setEmail(email);
		vo.setPassword(password);
		
		ApplicationContext applicationContext = 
				WebApplicationContextUtils.getWebApplicationContext( request.getServletContext() );
		MemberService memberService = applicationContext.getBean( MemberService.class);
		MemberVo authMember = memberService.login(vo);
		
		if( authMember == null ){
			response.sendRedirect( "/railway999/member/loginform");
			return false;
		}
		
		HttpSession session = request.getSession(true);
		session.setAttribute( "AuthMember", authMember );
		
		response.sendRedirect("/railway999/");
		return false;
		
	}
}
