package com.kh.semi.aop;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.error.UnauthorizationException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//비회원 차단 인터셉터
@Service
public class MemberLoginInterceptor implements HandlerInterceptor{
	@Override
	public boolean preHandle(
			HttpServletRequest request,
			HttpServletResponse response,
			Object handler) {
		HttpSession session = request.getSession();
		
		String loginId = (String) session.getAttribute("loginId");
		
		boolean isMember = loginId != null;
		
		if(isMember) {
			return true;
		}
		else {
			throw new UnauthorizationException("로그인이 필요합니다");
		}
	}
}
