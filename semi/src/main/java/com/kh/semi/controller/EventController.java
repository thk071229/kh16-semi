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

import com.kh.semi.dao.EventDao;
import com.kh.semi.dto.EventDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.vo.EventListVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	private EventDao eventDao;

	// 등록
	@GetMapping("/add")
	public String add(Model model, @RequestParam int clubNo) {
		List<EventDto> eventDto = eventDao.selectList(clubNo);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 소모임");
		model.addAttribute("clubNo",clubNo);
		return "/WEB-INF/views/event/add.jsp";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute EventDto eventDto, HttpSession session) {

		String loginId = (String) session.getAttribute("loginId");
		eventDto.setEventWriter(loginId); // 로그인 ID -> 작성자 등록
		
		int eventNo = eventDao.sequence(); // 시퀀스 번호 생성 및 등록
		eventDto.setEventNo(eventNo);

		eventDao.insert(eventDto); // 등록
		return "redirect:detail?eventNo="+eventNo;
	}
	
	
	// 정모게시글 전체
	@RequestMapping("/home")
	public String list(Model model) {
		List<EventListVO> eventDto = eventDao.selectList();
		model.addAttribute("eventDto", eventDto);
		return "/WEB-INF/views/event/home.jsp";
	}
	
	
	// 정모게시글 목록
	@RequestMapping("/list")
	public String list(Model model,@RequestParam int clubNo) {
		List<EventListVO> eventDto = eventDao.selectListWithClub(clubNo);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 소모임");
		List<EventListVO> beforeDto = eventDao.selectListBefore(clubNo);
		List<EventListVO> afterDto = eventDao.selectListAfter(clubNo);
		model.addAttribute("clubNo",clubNo);
		model.addAttribute("eventDto", eventDto);	
		model.addAttribute("beforeDto", beforeDto);		
		model.addAttribute("afterDto", afterDto);		
		return "/WEB-INF/views/event/list.jsp";
	}
	
	
	// 정모게시글 상세
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam int eventNo) {
		EventDto eventDto = eventDao.selectOne(eventNo);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 이벤트번호");
		model.addAttribute("eventDto", eventDto);
		return "/WEB-INF/views/event/detail.jsp";
	}

	// 수정
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam int eventNo) {
		EventDto eventDto = eventDao.selectOne(eventNo);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 정모 정보");
		model.addAttribute("eventDto", eventDto);
		return "/WEB-INF/views/event/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute EventDto eventDto) {
		EventDto findDto = eventDao.selectOne(eventDto.getEventNo());
		if(findDto==null) throw new TargetNotFoundException("존재하지 않는 이벤트");
		eventDao.update(eventDto);
		return "redirect:detail?eventNo="+findDto.getEventNo();
	}
	
	// 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int eventNo) {
		EventDto eventDto = eventDao.selectOne(eventNo);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 이벤트번호");
		eventDao.delete(eventNo);
		return "redirect:list?clubNo="+eventDto.getEventClub();
	}
		

	
}
