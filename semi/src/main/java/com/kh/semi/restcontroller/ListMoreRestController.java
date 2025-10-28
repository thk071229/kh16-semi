package com.kh.semi.restcontroller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dao.CountDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.vo.BoardListVO;
import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.ClubMemberListVO;
import com.kh.semi.vo.EventListVO;
import com.kh.semi.vo.PageVO;


@CrossOrigin
@RestController
@RequestMapping("/rest/more")
public class ListMoreRestController {
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private ClubMemberDao clubMemberDao;
	
	@Autowired
	private EventDao eventDao;
	
	@Autowired
	private CountDao countDao;
	
	//board의 데이터
	@PostMapping("/board")
	public Map<String, Object> boardMore(@ModelAttribute PageVO pageVO, @RequestParam int clubNo){
		
		pageVO.setDataCount(boardDao.count(pageVO, clubNo));
		
		List<BoardListVO> boardList = boardDao.selectListWithPaging(pageVO, clubNo);
		List<BoardListVO> noticeList = boardDao.selectListNotice(pageVO, clubNo);
		
		
		List<BoardListVO> allList = new ArrayList<>();
		
		allList.addAll(noticeList);
		allList.addAll(boardList);
		
		//공지글 카운트 저장하기 위해 새로운 Map 생성
		Map<String, Object> result = new HashMap<>();
		
		//비어있는 List 생성
		List<BoardListVO> list = new ArrayList<>();
		
		//하나씩 옮겨 담기
		for(BoardListVO boardListVO : allList) {
			list.add(BoardListVO.builder()
					.boardNo(boardListVO.getBoardNo())
					.boardTitle(boardListVO.getBoardTitle())
					.boardClub(boardListVO.getBoardClub())
					.boardWriter(boardListVO.getBoardWriter())
					.boardNotice(boardListVO.getBoardNotice())
					.boardLike(boardListVO.getBoardLike())
					.boardComment(boardListVO.getBoardComment())
					.boardEtime(boardListVO.getBoardEtime())
					.boardWtime(boardListVO.getBoardWtime())
					.boardRead(boardListVO.getBoardRead())
					.memberId(boardListVO.getMemberId())
					.memberLevel(boardListVO.getMemberLevel())
					.memberNickname(boardListVO.getMemberNickname())
					.clubNo(boardListVO.getClubNo())
					.clubName(boardListVO.getClubName())
					.clubLeader(boardListVO.getClubLeader())
					.regionName(boardListVO.getRegionName())
					.categoryName(boardListVO.getCategoryName())
					.build());
		}
		
		result.put("noticeCount", noticeList.size());
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		return result;
	}
	
	//전체 모임 리스트
	@PostMapping("/club")
	public List<ClubListVO> clubMore(PageVO pageVO){

		pageVO.setDataCount(clubDao.count(pageVO));
		
		List<ClubListVO> clubList = clubDao.selectListWithPaging(pageVO);
		List<ClubListVO> result = new ArrayList<>();
		
		for(ClubListVO clubListVO : clubList) {
			result.add(ClubListVO.builder()
					.clubNo(clubListVO.getClubNo())
					.clubLeader(clubListVO.getClubLeader())
					.clubCategory(clubListVO.getClubCategory())
					.clubRegion(clubListVO.getClubRegion())
					.clubName(clubListVO.getClubName())
					.clubLike(clubListVO.getClubLike())
					.clubProfile(clubListVO.getClubProfile())
					.clubIntroduce(clubListVO.getClubIntroduce())
					.regionName(clubListVO.getRegionName())
					.categoryName(clubListVO.getCategoryName())
					.memberCount(clubListVO.getMemberCount())
					.build());
		}
		return result;
	}
	//추천 모임 리스트
	@PostMapping("/recommendClub")
	public List<ClubListVO> clubLikeMore(PageVO pageVO){
		pageVO.setDataCount(clubDao.countByClubLike(pageVO));
		
		List<ClubListVO> clubLikeList = clubDao.selectClubListOrderByLikesWithPaging(pageVO);
		
		List<ClubListVO> result = new ArrayList<>();
		
		for(ClubListVO clubListVO : clubLikeList) {
			result.add(ClubListVO.builder()
					.clubNo(clubListVO.getClubNo())
					.clubName(clubListVO.getClubName())
					.clubCategory(clubListVO.getClubCategory())
					.clubIntroduce(clubListVO.getClubIntroduce())
					.clubLeader(clubListVO.getClubLeader())
					.clubLike(clubListVO.getClubLike())
					.clubProfile(clubListVO.getClubProfile())
					.clubRegion(clubListVO.getClubRegion())
					.memberCount(clubListVO.getMemberCount())
					.regionName(clubListVO.getRegionName())
					.categoryName(clubListVO.getCategoryName())
					.build());
			
		}
		return result;
	}
	//모임 회원 목록 페이징
	@PostMapping("/clubMember")
	public List<ClubMemberListVO> memberMore(PageVO pageVO, int clubNo){
		ClubListVO clubListVO = clubDao.selectOneFromClubList(clubNo);
		pageVO.setDataCount(clubListVO.getMemberCount());
		
		List<ClubMemberListVO> memberList = clubMemberDao.selectMemberListWithPaging(pageVO, clubNo);
		
		List<ClubMemberListVO> result = new ArrayList<>();
		
		for(ClubMemberListVO clubMemberList : memberList) {
			result.add(ClubMemberListVO.builder()
						.clubMember(clubMemberList.getClubMember())
						.clubMemberJoin(clubMemberList.getClubMemberJoin())
						.clubMemberRole(clubMemberList.getClubMemberRole())
						.clubNo(clubMemberList.getClubNo())
						.memberNickname(clubMemberList.getMemberNickname())
						.build());
		}
		return result;
	}
	
	//정모 리스트
	@PostMapping("/event")
	public List<EventListVO> eventMore(PageVO pageVO, int clubNo){
		List<EventListVO> eventList = eventDao.selectListWithPaging(clubNo, pageVO);
		
		List<EventListVO> result = new ArrayList<>();
		
		for(EventListVO eventListVO : eventList) {
			result.add(EventListVO.builder()
						.eventNo(clubNo)
						.eventTitle(null)
						.eventClub(clubNo)
						.eventWriter(null)
						.eventAttend(clubNo)
						.eventMaxPeople(clubNo)
						.eventDate(null)
						.eventAddress(null)
						.clubName(null)
						.clubCategory(clubNo)
						.clubLeader(null)
						.clubRegion(clubNo)
						.regionName(null)
						.categoryName(null)
						.memberNickname(null)
						.build());
		}
		return result;
	}
	//다가오는 정모
	@PostMapping("/beforeEvent")
	public List<EventListVO> beforeMore(PageVO pageVO, int clubNo){
		pageVO.setDataCount(eventDao.beforeCount(pageVO, clubNo));
		
		List<EventListVO> beforeList = eventDao.selectBeforeListWithPaging(clubNo, pageVO);
		
		List<EventListVO> result = new ArrayList<>();
		
		for(EventListVO eventListVO : beforeList) {
			result.add(EventListVO.builder()
					.eventNo(eventListVO.getEventNo())
					.eventClub(eventListVO.getEventClub())
					.eventTitle(eventListVO.getEventTitle())
					.eventAddress(eventListVO.getEventAddress())
					.eventAttend(eventListVO.getEventAttend())
					.eventDate(eventListVO.getEventDate())
					.eventMaxPeople(eventListVO.getEventMaxPeople())
					.eventWriter(eventListVO.getEventWriter())
					.clubCategory(eventListVO.getClubCategory())
					.clubLeader(eventListVO.getClubLeader())
					.clubName(eventListVO.getClubName())
					.clubRegion(eventListVO.getClubRegion())
					.categoryName(eventListVO.getCategoryName())
					.regionName(eventListVO.getRegionName())
					.memberNickname(eventListVO.getMemberNickname())
					.build());
		}
		return result;
	}
	
	//완료된 정모
	@PostMapping("/afterEvent")
	public List<EventListVO> afterMore(PageVO pageVO, int clubNo){
		pageVO.setDataCount(eventDao.afterCount(pageVO, clubNo));
		
		List<EventListVO> afterList = eventDao.selectAfterListWithPaging(clubNo, pageVO);
		
		List<EventListVO> result = eventDao.selectAfterListWithPaging(clubNo, pageVO);
		
		for(EventListVO eventListVO : afterList) {
			result.add(EventListVO.builder()
					.eventNo(eventListVO.getEventNo())
					.eventClub(eventListVO.getEventClub())
					.eventTitle(eventListVO.getEventTitle())
					.eventAddress(eventListVO.getEventAddress())
					.eventAttend(eventListVO.getEventAttend())
					.eventDate(eventListVO.getEventDate())
					.eventMaxPeople(eventListVO.getEventMaxPeople())
					.eventWriter(eventListVO.getEventWriter())
					.clubCategory(eventListVO.getClubCategory())
					.clubLeader(eventListVO.getClubLeader())
					.clubName(eventListVO.getClubName())
					.clubRegion(eventListVO.getClubRegion())
					.categoryName(eventListVO.getCategoryName())
					.regionName(eventListVO.getRegionName())
					.memberNickname(eventListVO.getMemberNickname())
					.build());
		}
		return result;
	}
}
