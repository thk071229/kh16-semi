package com.kh.semi.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubLikeDao;
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.vo.ClubLikeVO;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/rest/club")
@CrossOrigin
public class ClubRestController {

	@Autowired
	private ClubDao clubDao;
	@Autowired
	private ClubLikeDao clubLikeDao;
	
	@PostMapping("/check")
	public ClubLikeVO check(HttpSession session, @RequestParam int clubNo) {
		String loginId = (String)session.getAttribute("loginId");
		boolean like = clubLikeDao.check(loginId, clubNo);
		int count = clubLikeDao.countByClubNo(clubNo);
		
		return ClubLikeVO.builder().like(like).count(count).build();
	}
	@PostMapping("/action")
	public ClubLikeVO action(HttpSession session, @RequestParam int clubNo) {
		String loginId = (String)session.getAttribute("loginId");
		String loginLevel = (String)session.getAttribute("loginLevel");
		if(loginLevel.equals("관리자")) throw new UnauthorizationException("관리자는 이용할 수 없는 기능입니다");
		
		boolean before = clubLikeDao.check(loginId, clubNo);
		if(before) {//좋아요 한 상태면
			clubLikeDao.delete(loginId, clubNo);
		}
		else {//좋아요 안한 상태면
			clubLikeDao.insert(loginId, clubNo);
		}
		int count = clubLikeDao.countByClubNo(clubNo);
		clubDao.updateClubLike(clubNo);
		return ClubLikeVO.builder().like(!before).count(count).build();
	}
}