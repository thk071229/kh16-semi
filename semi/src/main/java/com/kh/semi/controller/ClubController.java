package com.kh.semi.controller;

import java.util.List;

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
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/club")
public class ClubController {

	@Autowired
	private ClubDao clubDao;
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	//소모임 등록
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/club/add.jsp";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute ClubDto clubDto, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {//로그인중이 아니면 로그인 페이지로 이동
			return "/WEB-INF/views/member/login.jsp";
		}
		clubDto.setClubFounder(loginId);
		
		clubDao.insert(clubDto);
		
		//소모임 개설 시 club_member_role에 '모임장'으로 등록
		int newClubNo = clubDto.getClubNo();
		ClubMemberDto clubMemberDto = new ClubMemberDto();
		clubMemberDto.setClubNo(newClubNo);
		clubMemberDto.setClubMember(loginId);
		clubMemberDto.setClubMemberRole("모임장");
		clubMemberDao.insert(clubMemberDto);
		return "redirect:addFinish";
	}
	@GetMapping("/addFinish")
	public String addFinish() {
		return "/WEB-INF/views/club/addFinish.jsp";
	}
	
	//수정
	@GetMapping("/edit")
	public String edit(Model model, HttpSession session, @RequestParam int clubNo) {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 2. 모임 존재 확인
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
		if(loginId.equals(clubDto.getClubFounder()) == false) throw new UnauthorizationException("권한 부족");
		model.addAttribute("clubDto", clubDto);
		return "/WEB-INF/views/club/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute ClubDto clubDto, HttpSession session) {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
				
		// 2. 모임 존재 확인
		ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
		if(origin == null) throw new TargetNotFoundException("존재하지 않는 모임");
				
		// 3. 권한 확인
		if(loginId.equals(clubDto.getClubFounder()) == false) throw new UnauthorizationException("권한 부족");
		clubDao.update(clubDto);
		return "redirect:detail?clubNo=" + clubDto.getClubNo();
	}
	
	//삭제 --> 삭제는 관리자 및 소모임장만 가능
	@GetMapping("/delete")
	public String delete(@ModelAttribute ClubDto clubDto, HttpSession session) {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 2. 모임 존재 확인
		ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
		if(origin == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
		if(loginId.equals(origin.getClubFounder()) == false) throw new UnauthorizationException("권한 부족");
		clubDao.delete(clubDto.getClubNo());
		return "redirect:list";
	}
	//탈퇴 --> 탈퇴는 회원만 가능
	@GetMapping("/drop")
	public String drop(HttpSession session, Model model, @ModelAttribute ClubDto clubDto) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		clubDao.delete(clubDto.getClubNo());
		return "redirect:list";
	}
	
	// 상세
	@GetMapping("/detail")
	public String detail(@RequestParam int clubNo, Model model) {
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 소모임");
		
		model.addAttribute("clubDto", clubDto);
		return "/WEB-INF/views/club/detail.jsp";
	}
	@GetMapping("/list")
		public String list(Model model, @ModelAttribute PageVO pageVO) {
			List<ClubListVO> clubList = clubDao.selectList(pageVO);
			model.addAttribute("clubList", clubList);
			return "/WEB-INF/views/club/list.jsp";
		}
}
