package com.kh.semi.restcontroller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.BoardLikeDao;
import com.kh.semi.vo.BoardLikeVO;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/board")
public class BoardRestController {
	
	
	@Autowired
	private BoardLikeDao boardLikeDao;
	
	@Autowired
	private BoardDao boardDao;
	
	//좋아요 확인
	@GetMapping("/check")
	public BoardLikeVO check(HttpSession session, @RequestParam int boardNo) {
		String loginId = (String) session.getAttribute("loginId");
		boolean result = boardLikeDao.check(loginId, boardNo);
		int count = boardLikeDao.countByBoardNo(boardNo);
		
		BoardLikeVO boardLikeVO = new BoardLikeVO();
		
		boardLikeVO.setLike(result); //좋아요 여부
		boardLikeVO.setCount(count); //좋아요 개수
		
		return boardLikeVO;
	}
	
	//좋아요 설정
	@PostMapping("/action")
	public BoardLikeVO action(HttpSession session, @RequestParam int boardNo) {
		String loginId = (String) session.getAttribute("loginId");
		BoardLikeVO boardLikeVO = new BoardLikeVO();
		//좋아요 기록이 있다면 삭제
		if(boardLikeDao.check(loginId, boardNo)) {
			boardLikeDao.delete(loginId, boardNo);
			boardLikeVO.setLike(false);
		}
		//좋아요 기록이 없으면 등록
		else {
			boardLikeDao.insert(loginId, boardNo);
			boardLikeVO.setLike(true);
		}
		//DB 처리 후 count 계산
		int count = boardLikeDao.countByBoardNo(boardNo);
		
		boardDao.updateBoardLike(count, boardNo);
		boardLikeVO.setCount(count);
		
		return boardLikeVO;
	}

}
