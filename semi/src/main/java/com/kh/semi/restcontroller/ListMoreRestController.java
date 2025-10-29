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
	public Map<String, Object> clubMore(PageVO pageVO){

		pageVO.setDataCount(clubDao.count(pageVO));
		
		List<ClubListVO> clubList = clubDao.selectListWithPaging(pageVO);
		List<ClubListVO> list = new ArrayList<>();
		
		for(ClubListVO clubListVO : clubList) {
			list.add(ClubListVO.builder()
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
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
	//추천 모임 리스트
	@PostMapping("/recommendClub")
	public Map<String, Object> clubLikeMore(PageVO pageVO){
		pageVO.setDataCount(clubDao.countByClubLike(pageVO));
		
		List<ClubListVO> clubLikeList = clubDao.selectClubListOrderByLikesWithPaging(pageVO);
		
		List<ClubListVO> list = new ArrayList<>();
		
		for(ClubListVO clubListVO : clubLikeList) {
			list.add(ClubListVO.builder()
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
		
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		return result;
	}
	//모임 회원 목록 페이징
	@PostMapping("/clubMember")
	public Map<String, Object> memberMore(PageVO pageVO, int clubNo){
		ClubListVO clubListVO = clubDao.selectOneFromClubList(clubNo);
		pageVO.setDataCount(clubListVO.getMemberCount());
		
		List<ClubMemberListVO> memberList = clubMemberDao.selectMemberListWithPaging(pageVO, clubNo);
		
		List<ClubMemberListVO> list = new ArrayList<>();
		
		for(ClubMemberListVO clubMemberList : memberList) {
			list.add(ClubMemberListVO.builder()
						.clubMember(clubMemberList.getClubMember())
						.clubMemberJoin(clubMemberList.getClubMemberJoin())
						.clubMemberRole(clubMemberList.getClubMemberRole())
						.clubNo(clubMemberList.getClubNo())
						.memberNickname(clubMemberList.getMemberNickname())
						.build());
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
	
	//정모 리스트
	@PostMapping("/event")
	public Map<String, Object> eventMore(@ModelAttribute PageVO pageVO, int clubNo){
		pageVO.setDataCount(eventDao.count(pageVO,clubNo));
		
		//정보를 담을 빈 리스트 생성
		List<EventListVO> allList = new ArrayList<>();
		List<EventListVO> eventList = eventDao.selectListWithPaging(clubNo, pageVO);
		
		//allList 데이터셋
		for(EventListVO eventListVO : eventList) {
			allList.add(EventListVO.builder()
						.eventNo(eventListVO.getEventNo())
						.eventTitle(eventListVO.getEventTitle())
						.eventClub(eventListVO.getEventClub())
						.eventWriter(eventListVO.getEventWriter())
						.eventAttend(eventListVO.getEventAttend())
						.eventMaxPeople(eventListVO.getEventMaxPeople())
						.eventDate(eventListVO.getEventDate())
						.eventAddress(eventListVO.getEventAddress())
						.clubName(eventListVO.getClubName())
						.clubCategory(eventListVO.getClubCategory())
						.clubLeader(eventListVO.getClubLeader())
						.clubRegion(eventListVO.getClubRegion())
						.regionName(eventListVO.getRegionName())
						.categoryName(eventListVO.getCategoryName())
						.memberNickname(eventListVO.getMemberNickname())
						.build());
		}
		//response로 전달될 데이터
		Map<String, Object> result = new HashMap<>();
		result.put("list", allList);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
	//다가오는 정모
	@PostMapping("/beforeEvent")
	public Map<String, Object> beforeMore(PageVO pageVO, int clubNo){
		pageVO.setDataCount(eventDao.beforeCount(pageVO, clubNo));
		
		List<EventListVO> beforeList = eventDao.selectBeforeListWithPaging(clubNo, pageVO);
		
		List<EventListVO> list = new ArrayList<>();
		
		for(EventListVO eventListVO : beforeList) {
			list.add(EventListVO.builder()
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
		
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
	
	//완료된 정모
	@PostMapping("/afterEvent")
	public Map<String, Object> afterMore(PageVO pageVO, int clubNo){
		pageVO.setDataCount(eventDao.afterCount(pageVO, clubNo));
		
		List<EventListVO> afterList = eventDao.selectAfterListWithPaging(clubNo, pageVO);
		
		List<EventListVO> list = new ArrayList<>();
		
		for(EventListVO eventListVO : afterList) {
			list.add(EventListVO.builder()
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
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
	@PostMapping("/homeEvent")
	public Map<String, Object> homeMore(@ModelAttribute PageVO pageVO){
		List<EventListVO> homeList;
		
		if(pageVO.getSelectedDate() != null) {
			int dateCount = eventDao.selectedDateCount(pageVO);
			pageVO.setDataCount(dateCount);
			homeList = eventDao.selectListHomeWithPagingByDate(pageVO);
		}
		else {
			int count = eventDao.afterEventCount(pageVO);
			pageVO.setDataCount(count);
			homeList = eventDao.selectListHomeWithPaging(pageVO);
		}
		
		
		//데이터 담을 객체 준비
		List<EventListVO> list = new ArrayList<>();
		Map<String, Object> result = new HashMap<>();
		
		for(EventListVO eventListVO : homeList) {
			list.add(EventListVO.builder()
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
		
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		return result;
	}
	
	}