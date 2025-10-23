package com.kh.semi.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.CategoryDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dto.CategoryDto;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.service.ClubService;
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
	@Autowired
	private ClubService clubService;
	@Autowired
	private CategoryDao categoryDao;
	
	//소모임 Home으로 이동
		@GetMapping("/home")
		public String home(HttpSession session, @RequestParam int clubNo, Model model) {
			String loginId = (String)session.getAttribute("loginId");
			
			// 1. 모임 정보 조회
			ClubDto clubDto = clubDao.selectOne(clubNo);
			if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 소모임");
			model.addAttribute("clubDto", clubDto);
			
			if(loginId != null) {
				ClubMemberDto clubMemberDto = clubMemberDao.selectByClubMember(clubNo, loginId);
				model.addAttribute("clubMemberDto", clubMemberDto); 
			}
			
			return "/WEB-INF/views/club/home.jsp";
		}
	//소모임 등록
	@GetMapping("/add")
	public String add(Model model) {
		 List<CategoryDto> categoryList = categoryDao.selectList(); 
		 model.addAttribute("categoryList", categoryList);
		return "/WEB-INF/views/club/add.jsp";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute ClubDto clubDto, HttpSession session, 
			@RequestParam String regionName, @RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {//로그인중이 아니면 로그인 페이지로 이동
			return "/WEB-INF/views/member/login.jsp";
		}
		clubDto.setClubLeader(loginId);
		clubService.createClub(clubDto, regionName, attach);
		
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
		ClubListVO clubList = clubDao.selectOneFromClubList(clubNo);
		if(clubList == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
		if(loginId.equals(clubList.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
		model.addAttribute("clubList", clubList);
		
		ClubDto clubDto = clubDao.selectOne(clubNo);
		model.addAttribute("clubDto", clubDto);
		
		List<CategoryDto> categoryList = categoryDao.selectList();
		model.addAttribute("categoryList", categoryList);
		return "/WEB-INF/views/club/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute ClubDto clubDto, HttpSession session, @RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
				
		// 2. 모임 존재 확인
		ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
		if(origin == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		clubDto.setClubLeader(origin.getClubLeader());
				
		// 3. 권한 확인
		if(loginId.equals(clubDto.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
		
		clubService.updateClub(clubDto, attach);
		
		return "redirect:home?clubNo=" + clubDto.getClubNo();
	}
	
	//삭제 --> 삭제는 관리자 및 소모임장만 가능
	@GetMapping("/delete")
	public String delete(@RequestParam int clubNo, HttpSession session) {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 2. 모임 존재 확인
		ClubDto origin = clubDao.selectOne(clubNo);
		if(origin == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
		if(loginId.equals(origin.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
		clubDao.delete(clubNo);
		return "redirect:list";
	}
	
	@GetMapping("/list")
		public String list(Model model, @ModelAttribute PageVO pageVO) {
			List<ClubListVO> clubList = clubDao.selectListWithPaging(pageVO);
			model.addAttribute("clubList", clubList);
			return "/WEB-INF/views/club/list.jsp";
		}
	
	
}
