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
	@Autowired
	private AttachmentService attachmentService;
	
	//소모임 등록
	@GetMapping("/add")
	public String add(Model model) {
		 List<CategoryDto> categoryList = categoryDao.selectList(); 
		 model.addAttribute("categoryList", categoryList);
		return "/WEB-INF/views/club/add.jsp";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute ClubDto clubDto, HttpSession session, 
			@RequestParam String regionName) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {//로그인중이 아니면 로그인 페이지로 이동
			return "/WEB-INF/views/member/login.jsp";
		}
		clubDto.setClubLeader(loginId);
		clubService.createClub(clubDto, regionName);
		
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
		ClubListVO clubDto = clubDao.selectOneFromClubList(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		
		// 3. 권한 확인
		if(loginId.equals(clubDto.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
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
		if(loginId.equals(clubDto.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
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
		if(loginId.equals(origin.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
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
	
	@GetMapping("/list")
		public String list(Model model, @ModelAttribute PageVO pageVO) {
			List<ClubListVO> clubList = clubDao.selectListWithPaging(pageVO);
			model.addAttribute("clubList", clubList);
			return "/WEB-INF/views/club/list.jsp";
		}
	//소모임 Home으로 이동
	@GetMapping("/home")
	public String home(HttpSession session, @RequestParam int clubNo,Model model) {
		String loginId = (String)session.getAttribute("loginId");
		
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 소모임");
		model.addAttribute("clubDto", clubDto);
		
		//필요없을듯?
		ClubMemberDto clubMemberDto = clubMemberDao.selectOne(clubNo);
		if(clubMemberDto == null) throw new TargetNotFoundException("존재하지 않는 소모임");
		model.addAttribute("clubMemberDto", clubMemberDto);
		
		return "/WEB-INF/views/club/home.jsp";
	}
	
	@PostMapping("/join")
	public String insert(@ModelAttribute ClubMemberDto clubMemberDto, 
			HttpSession session, @RequestParam int clubNo, Model model) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("로그인이 필요합니다");
		
		ClubDto findDto = clubDao.selectOne(clubNo);
		if(findDto == null) throw new TargetNotFoundException("이미 가입한 소모임입니다");
		
		model.addAttribute("clubDto", findDto);
		clubMemberDto.setClubNo(findDto.getClubNo());
		clubMemberDto.setClubMember(loginId);
		clubMemberDto.setClubMemberRole("일반회원");
		clubMemberDao.insert(clubMemberDto);
		return "redirect:list";
	}
	@PostMapping("/drop")
	public String drop(Model model, @RequestParam int clubNo, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("로그인이 필요합니다");
		
		ClubMemberDto clubMemberDto = clubMemberDao.selectByClubMember(clubNo, loginId);
		model.addAttribute("clubMemberDto", clubMemberDto);
		boolean success = clubMemberDao.delete(clubNo, loginId);
		if(!success) throw new TargetNotFoundException("탈퇴에 실패하였습니다");
		return "redirect:list";
	}
}
