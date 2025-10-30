package com.kh.semi.aop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.dto.EventDto;
import com.kh.semi.error.NeedClubJoinException;
import com.kh.semi.error.NeedPermissionException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class ClubJoinCheckInterceptor implements HandlerInterceptor {
 
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) {
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		String loginLevel = (String) session.getAttribute("loginLevel");
		

		//본인이 가입한 클럽인지 확인
		int clubNo = Integer.parseInt(request.getParameter("clubNo"));
		// 특정 모임에 특정회원이 있는지 확인
		ClubMemberDto clubMemberDto = clubMemberDao.selectByClubMember(clubNo,loginId);
		if(clubMemberDto==null) {
			throw new NeedClubJoinException("가입한 소모임만 등록이 가능합니다");
		};
		
		// 위에서 차단되지 않았다면 통과
		return true;
	}
}
