package com.dorothy.railway999.annotation;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebArgumentResolver;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import com.dorothy.railway999.vo.MemberVo;



public class AuthMemberHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver {
	@Override
	public Object resolveArgument(
			MethodParameter paramter,
			ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest,
			WebDataBinderFactory binderFactory) throws Exception {
		
		if( supportsParameter( paramter ) == false ) {
			return WebArgumentResolver.UNRESOLVED;
		}
		
		HttpServletRequest request = webRequest.getNativeRequest( HttpServletRequest.class );
		HttpSession session = request.getSession();
		if( session == null ) {
			return null;
		}
		
		MemberVo authUser = (MemberVo)session.getAttribute( "authMember" );
		return authUser;
	}

	@Override
	public boolean supportsParameter( MethodParameter parameter ) {
		return	parameter.getParameterAnnotation( AuthMember.class ) != null &&
				parameter.getParameterType().equals( MemberVo.class );
	}
}
