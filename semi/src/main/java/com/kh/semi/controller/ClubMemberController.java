package com.kh.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;import org.springframework.data.annotation.ReadOnlyProperty;
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
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.service.ClubService;
import com.kh.semi.vo.ClubMemberListVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/clubMember")
public class ClubMemberController {

	@Autowired
	private ClubMemberDao clubMemberDao;
	@Autowired
	private ClubDao clubDao;
	@Autowired
	private ClubService clubService;
	
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
	//탈퇴 - 가입중인 회원의 탈퇴
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
	//회원 제명 기능
	@PostMapping("/delete")
	public String delete(HttpSession session, @RequestParam int clubNo, @RequestParam String memberId) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("로그인이 필요합니다");
		
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 소모임입니다");
		
		String leaderId = clubDto.getClubLeader();
		
		if(loginId.equals(leaderId) == false) throw new UnauthorizationException("모임장만 가능합니다");
		if(memberId.equals(leaderId)) throw new UnauthorizationException("모임장은 자신을 제명할 수 없습니다");
		
		clubMemberDao.delete(clubNo, memberId);
		return "redirect:list?clubNo=" + clubNo;
	}
	// 모임장 변경 기능
	@PostMapping("/changeLeader")
	public String changeLeader(@RequestParam int clubNo, 
			@RequestParam String newLeader, 
			HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		clubService.changeClubLeader(clubNo, newLeader, loginId);
		return "redirect:/club/home?clubNo=" + clubNo;
	}
	
	@GetMapping("/list")
	public String list(@RequestParam int clubNo,  Model model) {
		//1. 모임 정보 조회
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 소모임");
		model.addAttribute("clubDto", clubDto);
		
		//2. 회원 전체 목록 조회
		List<ClubMemberListVO> memberList = clubMemberDao.selectListWithNickname(clubNo);
		model.addAttribute("memberList", memberList);
		
		return "/WEB-INF/views/clubMember/list.jsp";
	}
	
}
