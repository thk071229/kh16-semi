package com.kh.semi.aop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.semi.dao.CountDao;
import com.kh.semi.vo.MemberActiveVO;

import jakarta.servlet.http.HttpSession;

@ControllerAdvice
public class SidebarControllerAdvice {

	@Autowired
	private CountDao countDao;
	
	// 로그인 아이디로 사이드바에 전달할 정보 전달
	@ModelAttribute("sidebarData")
	public MemberActiveVO sidebarData(HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId==null) {
			return null;
		}
		return countDao.selectOneWithActive(loginId);
	}

	
}
