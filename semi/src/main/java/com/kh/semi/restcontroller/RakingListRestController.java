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
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.CountDao;
import com.kh.semi.vo.ClubCountVO;
import com.kh.semi.vo.PageVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/ranking")
public class RakingListRestController {
	@Autowired
	private CountDao countDao;
	
	
	@PostMapping("/clubLike")
	public Map<String, Object> clubListRanking(@ModelAttribute PageVO pageVO){
		pageVO.setDataCount(countDao.clubLikeListCount(pageVO));
		List<ClubCountVO> list = countDao.selectLikeListWithPaging(pageVO);
		List<ClubCountVO> clubLikeList = new ArrayList<>();
		
		for(ClubCountVO clubCountVO : list) {
			clubLikeList.add(ClubCountVO.builder()
					.clubName(clubCountVO.getClubName())
					.clubCategory(clubCountVO.getClubCategory())
					.categoryName(clubCountVO.getCategoryName())
					.clubLike(clubCountVO.getClubLike())
					.clubNo(clubCountVO.getClubNo())
					.clubProfile(clubCountVO.getClubProfile())
					.clubRegion(clubCountVO.getClubRegion())
					.eventCount(clubCountVO.getEventCount())
					.boardCount(clubCountVO.getBoardCount())
					.memberCount(clubCountVO.getMemberCount())
					.regionName(clubCountVO.getRegionName())
					.build()
					);
		}
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("list", clubLikeList);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
	@PostMapping("/clubEvent")
	public Map<String, Object> clubEventRanking(@ModelAttribute PageVO pageVO){
		pageVO.setDataCount(countDao.eventListCount(pageVO));
		List<ClubCountVO> list = countDao.selectEventListWithPaging(pageVO);
		
		List<ClubCountVO> clubEventList = new ArrayList<>();
		
		for(ClubCountVO clubCountVO : list) {
			clubEventList.add(ClubCountVO.builder()
					.clubName(clubCountVO.getClubName())
					.clubCategory(clubCountVO.getClubCategory())
					.categoryName(clubCountVO.getCategoryName())
					.clubLike(clubCountVO.getClubLike())
					.clubNo(clubCountVO.getClubNo())
					.clubProfile(clubCountVO.getClubProfile())
					.clubRegion(clubCountVO.getClubRegion())
					.eventCount(clubCountVO.getEventCount())
					.boardCount(clubCountVO.getBoardCount())
					.memberCount(clubCountVO.getMemberCount())
					.regionName(clubCountVO.getRegionName())
					.build()
					);
		}
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
	
	@PostMapping("/clubBoard")
	public Map<String, Object> clubBoardRanking(@ModelAttribute PageVO pageVO){
		pageVO.setDataCount(countDao.boardListCount(pageVO));
		List<ClubCountVO> list = countDao.selectBoardListWithPaging(pageVO);
		
		List<ClubCountVO> clubBoardList = new ArrayList<>();
		
		for(ClubCountVO clubCountVO : list) {
			clubBoardList.add(ClubCountVO.builder()
					.clubName(clubCountVO.getClubName())
					.clubCategory(clubCountVO.getClubCategory())
					.categoryName(clubCountVO.getCategoryName())
					.clubLike(clubCountVO.getClubLike())
					.clubNo(clubCountVO.getClubNo())
					.clubProfile(clubCountVO.getClubProfile())
					.clubRegion(clubCountVO.getClubRegion())
					.eventCount(clubCountVO.getEventCount())
					.boardCount(clubCountVO.getBoardCount())
					.memberCount(clubCountVO.getMemberCount())
					.regionName(clubCountVO.getRegionName())
					.build()
					);
		}
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("list", list);
		result.put("hasMore", pageVO.hasMore());
		
		return result;
	}
}
