package com.kh.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.EventListVO;
import com.kh.semi.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/test")
public class TestController {
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private EventDao eventDao;
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@RequestMapping("/board")
	public String List(HttpSession session, Model model, 
			@ModelAttribute PageVO pageVO, @RequestParam int clubNo) {
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 소모임");
		
		String loginId = (String) session.getAttribute("loginId");
		
		model.addAttribute("loginId", loginId);
		model.addAttribute("clubNo", clubNo);
		
		ClubMemberDto clubMemberDto = clubMemberDao.selectByClubMember(clubNo, loginId);
		boolean isClubMember = loginId != null && clubMemberDto != null;
		model.addAttribute("isClubMember", isClubMember);
		
		return "/WEB-INF/views/sample.jsp";
	}
	
	@RequestMapping("/event")
	public String List(Model model, @RequestParam int clubNo, @ModelAttribute PageVO pageVO) {
		List<EventListVO> eventDto = eventDao.selectListWithPaging(clubNo, pageVO);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 소모임");
		
		ClubListVO clubList = clubDao.selectOneFromClubList(clubNo);
		model.addAttribute("clubRegionName",clubList.getRegionName());
		
		model.addAttribute("clubNo",clubNo);
		return "/WEB-INF/views/event/list-more.jsp";
	}
	@RequestMapping("/event/home")
	public String List(@ModelAttribute PageVO pageVO) {
		return "/WEB-INF/views/event/home-list-more.jsp";
	}
}
