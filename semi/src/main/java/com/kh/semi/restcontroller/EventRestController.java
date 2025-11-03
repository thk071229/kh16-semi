package com.kh.semi.restcontroller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.EventAttendeeDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.dto.EventDto;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.service.EventService;
import com.kh.semi.vo.EventAttendeeVO;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/event")
public class EventRestController {
	
	@Autowired
	private EventDao eventDao;
	
	@Autowired
	private EventAttendeeDao eventAttendeeDao;
	
	@Autowired
	private AttachmentService attachmentService;
	
	@Autowired
	private EventService eventService;
	
	
	//참여자 확인
	@GetMapping("/check")
	public EventAttendeeVO check(HttpSession session, @RequestParam int eventNo) {
		String loginId = (String)session.getAttribute("loginId");
		boolean result = eventAttendeeDao.check(loginId, eventNo);
		int count = eventAttendeeDao.countByEventNo(eventNo);
		//VO처리
		EventAttendeeVO eventAttendeeVO = new EventAttendeeVO();
		eventAttendeeVO.setAttend(result); // 좋아요 여부
		eventAttendeeVO.setCount(count); // 좋아요 개수
		return eventAttendeeVO;
	}
	
	
	// 참여/불참 설정
	@GetMapping("/action")
	public EventAttendeeVO action(HttpSession session, @RequestParam int eventNo) {
		String loginId = (String)session.getAttribute("loginId");
		return eventService.actionAttendance(loginId,eventNo);
	}

	// 전체 정모 좌표 출력
	@GetMapping("/locations")
	public List<EventDto> Location(@RequestParam int clubNo){
		return eventDao.selectList(clubNo);
	}
	
	// 대표이미지 갱신
	@Transactional
	@PostMapping("/uploadMainImage")
	public Map<String, Object> updateMainImage(
									@RequestParam int eventNo,
									@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		Integer beforeAttachmentNo = eventDao.findAttachment(eventNo);
		if(beforeAttachmentNo != null) {
			attachmentService.delete(beforeAttachmentNo);
		}
		int newAttachmentNo = attachmentService.save(attach);
		eventDao.connect(eventNo,newAttachmentNo);
		
		return Map.of("eventNo", eventNo, "attachmentNo", newAttachmentNo);
	}

}
