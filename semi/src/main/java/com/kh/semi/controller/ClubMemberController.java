package com.kh.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.error.TargetNotFoundException;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/clubMember")
public class ClubMemberController {

	@Autowired
	private ClubMemberDao clubMemberDao;
	@Autowired
	private ClubDao clubDao;
	
	@PostMapping("/join")
	public String insert(@ModelAttribute ClubMemberDto clubMemberDto, 
			HttpSession session, @RequestParam int clubNo, Model model) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("로그인이 필요합니다");
		
		ClubDto findDto = clubDao.selectOne(clubNo);
		// 1. 모임이 존재하는지 확인
		if(findDto == null) throw new TargetNotFoundException("존재하지 않는 소모임입니다");
		
		// 2. (추가) 이미 가입했는지 확인
		ClubMemberDto memberDto = clubMemberDao.selectByClubMember(clubNo, loginId);
		if(memberDto != null) {
			// 이미 가입한 경우, 그냥 모임 홈으로 보냄
			return "redirect:/club/home?clubNo=" + clubNo;
		}

		// 3. 가입 처리
		clubMemberDto.setClubNo(findDto.getClubNo());
		clubMemberDto.setClubMember(loginId);
		clubMemberDto.setClubMemberRole("일반회원");
		clubMemberDao.insert(clubMemberDto);
		
		// 가입했으면 모임 목록이 아닌, 해당 모임 홈으로 이동
		return "redirect:/club/home?clubNo=" + clubNo;
	}
		//탈퇴
	@PostMapping("/drop")
	public String drop(HttpSession session, @RequestParam int clubNo) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 모임 탈퇴 처리
		boolean success = clubMemberDao.delete(clubNo, loginId);
		if(!success) throw new TargetNotFoundException("탈퇴에 실패하였습니다");
		
		// 탈퇴했으면 모임 목록 페이지로 이동
		return "redirect:/club/list";
	}
	
	@GetMapping("/list")
	public String list() {
		return "/WEB-INF/clubMember/list.jsp";
	}
	
}
