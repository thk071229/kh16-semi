package com.kh.semi.aop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dto.BoardDto;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.error.NeedPermissionException;
import com.kh.semi.error.TargetNotFoundException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//본인 글에만 수정/삭제 접근 가능하도록 처리
@Service
public class BoardOwnerInterceptor implements HandlerInterceptor{
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private ClubDao clubDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) {
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		String loginLevel = (String) session.getAttribute("loginLevel");
		
		//1. 관리자는 삭제 가능하도록 처리
		String uri = request.getRequestURI();
		if(loginLevel.equals("관리자") && uri.equals("/board/delete")){
			return true;
		}
		//2. 자기자신이 작성한 글이 아니라면 차단
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDto boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null) throw new TargetNotFoundException("존재하지 않는 게시글");
		//loginId != boardWriter
		if(loginId.equals(boardDto.getBoardWriter()) == false) {
			throw new NeedPermissionException("본인의 글만 수정 및 삭제가 가능합니다");
		}
		//3. 모임장은 삭제 가능하도록 처리
		ClubDto clubDto = clubDao.selectOne(boardDto.getBoardClub());
		String clubLeader = clubDto.getClubLeader();
		if(loginId.equals(clubLeader) == false) {
			throw new NeedPermissionException("본인의 글만 수정 및 삭제가 가능합니다");
		}
		//위에서 차단되지 않았다면 통과
		return true;
	}
}
