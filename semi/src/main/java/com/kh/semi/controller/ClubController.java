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
import com.kh.semi.dto.ClubDto;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/club")
public class ClubController {

	@Autowired
	private ClubDao clubDao;
	
	//소모임 등록
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/club/add.jsp";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute ClubDto clubDto) {
		clubDao.insert(clubDto);
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
//		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 2. 모임 존재 확인
		ClubDto clubDto = clubDao.selectOne(clubNo);
//		if(clubDto == null) throw new TartgetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
//		if(loginId.equals(clubDto.getClubFounder()) == false) throw new unauthorizationException("권한 부족");
		model.addAttribute("clubDto", clubDto);
		return "/WEB-INF/views/club/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute ClubDto clubDto, HttpSession session) {
		// 1. 로그인 확인
				String loginId = (String)session.getAttribute("loginId");
//				if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
				
				// 2. 모임 존재 확인
				ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
//				if(origin == null) throw new TartgetNotFoundException("존재하지 않는 모임");
				
				// 3. 권한 확인
//				if(loginId.equals(clubDto.getClubFounder()) == false) throw new unauthorizationException("권한 부족");
		clubDao.update(clubDto);
		return "redirect:detail?clubNo=" + clubDto.getClubNo();
	}
	
	//삭제
	@GetMapping("/delete")
	public String delete(@ModelAttribute ClubDto clubDto, HttpSession session) {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
//		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 2. 모임 존재 확인
		ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
//		if(origin == null) throw new TartgetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
//		if(loginId.equals(origin.getClubFounder()) == false) throw new unauthorizationException("권한 부족");
		clubDao.delete(clubDto.getClubNo());
		return "redirect:list";
	}
	
	// 조회
	@GetMapping("/list")
	public String list(Model model, @ModelAttribute ClubDto clubDto) {
		List<ClubDto> clubList = clubDao.selectList();
		model.addAttribute("clubList", clubList);
		return "/WEB-INF/views/club/list.jsp";
	}
	
	// 상세
	@GetMapping("/detail")
	public String detail(@RequestParam int clubNo, Model model) {
		ClubDto clubDto = clubDao.selectOne(clubNo);
//		if(clubDto == null) throw TargetNotFoundException("존재하지 않는 소모임");
		
		model.addAttribute("clubDto", clubDto);
		return "/WEB-INF/views/club/detail.jsp";
	}
}
