package com.kh.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.error.TargetNotFoundException;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/clubMember")
public class ClubMemberController {

	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@GetMapping("/insert")
	public String insert(@ModelAttribute ClubMemberDto clubMemberDto, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("로그인이 필요합니다");
		
		clubMemberDao.insert(clubMemberDto);
		return "redirect:event?clubNo=" + clubMemberDto.getClubNo();
	}
	
}
