package com.kh.semi.aop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.ClubDao;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class ClubAdminInterceptor implements HandlerInterceptor{

	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) throws Exception{
		HttpSession session = request.getSession();
        String loginLevel = (String) session.getAttribute("loginLevel");

        // "관리자" 레벨인지 확인
        if ("관리자".equals(loginLevel)) {
            // 관리자라면, 에러 페이지로 보내거나 관리자 홈으로 리다이렉트
            response.sendRedirect("/?error"); // (경로 예시)
            return false; // 컨트롤러 진행 차단
        }

        // 관리자가 아니면(일반 회원이거나 비회원이면) 통과
        // (비회원은 어차피 MemberLoginInterceptor가 차단할 것임)
        return true; 
    }
}
