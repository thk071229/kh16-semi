package com.kh.semi.aop;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//회원의 회원가입 페이지 접근 차단
	@Service
	public class MemberJoinInterceptor implements HandlerInterceptor{
		@Override
		public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
				throws Exception {
			HttpSession session = request.getSession();
			String loginId = (String) session.getAttribute("loginId");
			boolean isMember = loginId != null;
			if(isMember) {
			response.sendRedirect("/?error");
			}
			return true;
		}
}
