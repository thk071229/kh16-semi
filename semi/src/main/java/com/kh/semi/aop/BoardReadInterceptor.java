package com.kh.semi.aop;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dto.BoardDto;
import com.kh.semi.error.TargetNotFoundException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class BoardReadInterceptor implements HandlerInterceptor{
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler) {
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		//1. 작성자 본인의 조회 수 증가 처리 차단
		BoardDto boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null) throw new TargetNotFoundException("존재하지 않는 게시글");
		//비회원의 조회 수 증가 차단
		//- 현재 detail 페이지 주소로 들어가면 interceptor로 차단은 되지만 조회수는 증가됨
		if(loginId == null) {
			return true; //조회 수 증가x
		}
		//로그인이 되어있고, 게시글 작성자가 탈퇴하지 않았을때
		if(loginId != null && boardDto.getBoardWriter() != null) {
			//본인 글 이라면 (작성자 = 사용자)
			if(loginId.equals(boardDto.getBoardWriter())) {
				return true; //조회 수 증가 없이 통과
			}
		}
		//2. 관리자의 조회 수 증가 처리 차단
		String loginLevel = (String) session.getAttribute("loginLevel");
		if(loginLevel != null && loginLevel.equals("관리자")) {
			return true;
		}
		//3. 한번 읽은 게시글은 다시 조회 수가 증가하지 않도록 처리
		Set<Integer> history = (Set<Integer>) session.getAttribute("history");
		
		if(history == null) { //읽은 게시글 목록이 비어있다면
			history = new HashSet<>();
		}
		
		if(history.contains(boardNo)) { //저장소에 게시글 번호가 있다면(읽은 적 있다면)
			return true;
		}
		else {//읽은 적 없다면
			history.add(boardNo);
			session.setAttribute("history", history); //세션 갱신
			
			//위에서 차단되지 않았다면 조회수 증가
			boardDao.updateBoardRead(boardNo);
			return true;
		}
	}
	
}
