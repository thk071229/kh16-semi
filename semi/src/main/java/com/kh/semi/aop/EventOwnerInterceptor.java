package com.kh.semi.aop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.EventDao;
import com.kh.semi.dto.EventDto;
import com.kh.semi.error.NeedPermissionException;
import com.kh.semi.error.TargetNotFoundException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class EventOwnerInterceptor implements HandlerInterceptor {

	@Autowired
	private EventDao eventDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) {
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		String loginLevel = (String) session.getAttribute("loginLevel");
		
		// 전체 관리자는 글삭제 가능
		String uri = request.getRequestURI();
		if(loginLevel.equals("관리자") && uri.equals("/event/delete")){
			return true;
		}

		// 자기자신이 작성한 글이 아니라면 차단
		int eventNo = Integer.parseInt(request.getParameter("eventNo"));
		EventDto eventDto = eventDao.selectOne(eventNo);
		if(eventDto == null) throw new TargetNotFoundException("존재하지 않는 정모내역");
		if(loginId.equals(eventDto.getEventWriter())==false) {
			throw new NeedPermissionException("본인이 작성한 정모내역만 수정/삭제가 가능합니다");
		}
		// 위에서 차단되지 않았다면 통과
		return true;
		}
	}

