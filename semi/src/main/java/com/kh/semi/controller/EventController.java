package com.kh.semi.controller;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.EventDao;
import com.kh.semi.dto.EventDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.vo.EventListVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/event")
public class EventController {

	@Autowired
	private EventDao eventDao;

	@Autowired
	private AttachmentService attachmentService;
	
	
	// 정모게시글 전체
	@RequestMapping("/home")
	public String list(Model model) {
		List<EventListVO> eventDto = eventDao.selectList();
		model.addAttribute("eventDto", eventDto);
		return "/WEB-INF/views/event/home.jsp";
	}
	
	// 등록
	@GetMapping("/add")
	public String add(Model model, @RequestParam int clubNo) {
		List<EventDto> eventDto = eventDao.selectList(clubNo);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 소모임");
		model.addAttribute("clubNo",clubNo);
		return "/WEB-INF/views/event/add.jsp";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute EventDto eventDto, HttpSession session,
								@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		String loginId = (String) session.getAttribute("loginId");
		eventDto.setEventWriter(loginId); // 로그인 ID -> 작성자 등록
		int eventNo = eventDao.sequence(); // 시퀀스 번호 생성 및 등록
		eventDto.setEventNo(eventNo);
		eventDao.insert(eventDto); // 등록
		
		if(attach.isEmpty()==false) {//첨부파일이 있으면
			int attachmentNo = attachmentService.save(attach);
			eventDao.connect(eventNo, attachmentNo);
		}
		
		return "redirect:detail?eventNo="+eventNo;
	}
	/// 대표이미지를 반환하는 매핑
	@GetMapping("image")
	public String image(@RequestParam int eventNo) {
		try {
			int attachmentNo = eventDao.findAttachment(eventNo);
			return "redirect:/attachment/download?attachmentNo="+attachmentNo;
		}
		catch(Exception e) {
			return "redirect:/images/error/no-image.png";
		}
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
	public String edit(@ModelAttribute EventDto eventDto,
							@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		EventDto beforeDto = eventDao.selectOne(eventDto.getEventNo());
		if(beforeDto==null) throw new TargetNotFoundException("존재하지 않는 이벤트");
		
		// 수정하면서 이미지를 삭제하면, attachment DB에 삭제 정보를 반영
		//기존 글과 변경될 글의 이미지 번호 차이를 구하기 위한 코드
		// - 기존 글의 번호추출 -> 저장
		Set<Integer> before = new HashSet<>();
		Document beforeDocument = Jsoup.parse(beforeDto.getEventContent());
		Elements beforeElements = beforeDocument.select(".custom-image");
		for(Element element : beforeElements) { // 하나씩 반복하며
			int attachmentNo = Integer.parseInt(element.attr("data-pk"));
			before.add(attachmentNo);
		}
	
		// - 수정된 글의 번호추출 -> 저장
		Set<Integer> after = new HashSet<>();
		Document afterDocument = Jsoup.parse(eventDto.getEventContent());
		Elements afterElements = afterDocument.select(".custom-image");
		for(Element element : afterElements) { // 하나씩 반복하며
			int attachmentNo = Integer.parseInt(element.attr("data-pk"));
			after.add(attachmentNo);
		}
		
		// before에만 있는 이미지 번호를 구하자! (차집합)
		// -  before에서 after를 뺌
		Set<Integer> minus = new HashSet<>(); 
		minus.addAll(before); //before를 넣어놓고
		minus.removeAll(after); // after에 있는 내용을 제거
		//minus에 들어있는 번호가 기존에 잇었지만 사라진 이미지 번호를 제거
		for(int attachmentNo : minus) {
			attachmentService.delete(attachmentNo);
		}
		
		//// 대표이미지 수정 메소드
		if(attach.isEmpty()==false) {//첨부파일이 있으면
			int beforeAttachmentNo = eventDao.findAttachment(eventDto.getEventNo());
			attachmentService.delete(beforeAttachmentNo);
			int afterAttachmentNo = attachmentService.save(attach);
			eventDao.connect(eventDto.getEventNo(), afterAttachmentNo);
		}
		
		
		eventDao.update(eventDto);
		return "redirect:detail?eventNo="+eventDto.getEventNo();
	}
	
	// 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam int eventNo) {
		EventDto eventDto = eventDao.selectOne(eventNo);
		if(eventDto==null) throw new TargetNotFoundException("존재하지 않는 이벤트번호");
		// 글 본문에 포함된 모든 <img>를 찾아서 해당하는 이미지의 글번호를 삭제
				// - summernote가 만든 html 형식의 글에서 원하는 항목을 탐색 (Jsoup 사용)
			Document document = Jsoup.parse(eventDto.getEventContent()); // HTML로 해석해서
			Elements elements = document.select(".custom-image"); // <img>를 찾고
			for(Element element : elements) { // 하나씩 반복하며
				int attachmentNo = Integer.parseInt(element.attr("data-pk"));
				attachmentService.delete(attachmentNo);
			}
			// 정모 대표이미지 삭제
			try {
				int attachmentNo = eventDao.findAttachment(eventNo);
				attachmentService.delete(attachmentNo);
			}
			catch(Exception e) {}
		eventDao.delete(eventNo);
		return "redirect:list?clubNo="+eventDto.getEventClub();
	}
		

	
}
