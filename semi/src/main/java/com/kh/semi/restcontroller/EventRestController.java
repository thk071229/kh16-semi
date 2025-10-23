package com.kh.semi.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.EventAttendeeDao;
import com.kh.semi.vo.EventAttendeeVO;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/event")
public class EventRestController {
	
	@Autowired
	private EventAttendeeDao eventAttendeeDao;
	
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
	
	
	// 좋아요 설정
	@GetMapping("/action")
	public EventAttendeeVO action(HttpSession session, @RequestParam int eventNo) {
		String loginId = (String)session.getAttribute("loginId");
		
		EventAttendeeVO eventAttendeeVO=new EventAttendeeVO();
		if(eventAttendeeDao.check(loginId, eventNo)) { // 좋아요를 누른 이력이 있으면
			eventAttendeeDao.delete(loginId,eventNo);
			eventAttendeeVO.setAttend(false);
		}
		else { // 좋아요를 누를 이력이 없으면
			eventAttendeeDao.insert(loginId, eventNo);
			eventAttendeeVO.setAttend(true);
		}
		int count = eventAttendeeDao.countByEventNo(eventNo);
		eventAttendeeVO.setCount(count);
		return eventAttendeeVO;

	}
}
