package com.kh.semi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.semi.dao.EventAttendeeDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.dto.EventDto;
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.vo.EventAttendeeVO;

@Service
public class EventService {

 @Autowired
 	private EventDao eventDao; 
 @Autowired
 	private EventAttendeeDao eventAttendeeDao;
 @Autowired
  	private MemberService memberService;
 
 	@Transactional
 	public EventAttendeeVO actionAttendance(String loginId, int eventNo) {
	 
		// 참가인원이 최대값보다 클 때
		EventDto eventDto = eventDao.selectOne(eventNo);
		int currentAttend = eventDto.getEventAttend();
		int maxAttend = eventDto.getEventMaxPeople();
		if(currentAttend > maxAttend) throw new UnauthorizationException("참가 인원이 최대값을 초과했습니다");
	
		EventAttendeeVO eventAttendeeVO=new EventAttendeeVO();
		if(eventAttendeeDao.check(loginId, eventNo)) { // 좋아요를 누른 이력이 있으면
			eventAttendeeDao.delete(loginId,eventNo);
			eventAttendeeVO.setAttend(false);
		}
		else { // 참여 기록 확인한 뒤
			eventAttendeeDao.insert(loginId, eventNo);
			eventAttendeeVO.setAttend(true);
		}
		
		int count = eventAttendeeDao.countByEventNo(eventNo);
		eventDao.updateEventAttend(count, eventNo);
		eventAttendeeVO.setCount(count);
		//포인트갱신
		memberService.refreshMemberPoint(loginId);
	
		return eventAttendeeVO;
 }
	
}
