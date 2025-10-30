package com.kh.semi.controller;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.CountDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.dao.MemberRegionDao;
import com.kh.semi.dao.RegionDao;
import com.kh.semi.dto.RegionDto;
import com.kh.semi.vo.ClubCountVO;
import com.kh.semi.vo.EventListVO;
import com.kh.semi.vo.MemberRegionListVO;
import com.kh.semi.vo.PageVO;

import jakarta.servlet.http.HttpSession;


@Controller
public class MainController {
	@Autowired
	private RegionDao regionDao;
	@Autowired
	private CountDao countDao;
	@Autowired
	private ClubDao clubDao;
	@Autowired
	private EventDao eventDao;
	@Autowired
	private MemberRegionDao memberRegionDao;

	@RequestMapping("/")
	public String main(Model model,
								@RequestParam(required=false) String regionDepth1,
								@RequestParam(required=false) String regionDepth2,
								@RequestParam(defaultValue="1") int eventPage,
								@RequestParam(defaultValue="1") int boardPage,
								@RequestParam(defaultValue="1") int likePage
			) {
	 	
	 	
		//지역 선택을 위해 지역 정보 화면 전달
		List<RegionDto> allList = regionDao.selectList();
		
		//depth값 저장을 위한 빈 리스트 생성
		List<String> firstDepthList = new ArrayList<>();
		List<String> secondDepthList = new ArrayList<>();
		
		//중복 제거를 위한 Set 생성
		Set<String> firstDepthSet = new HashSet<>();
		Set<String> secondDepthSet = new HashSet<>();
		
	
		for(RegionDto regionDto : allList) {
			boolean isValid = regionDto != null;
			
			String depth1 = isValid ? regionDto.getRegionDepth1() : null;
			String depth2 = isValid ? regionDto.getRegionDepth2() : null;
			
			if(isValid && depth1 != null && !firstDepthSet.contains(depth1)) {
				firstDepthList.add(depth1);
				firstDepthSet.add(depth1);
			}
			
			if(isValid && depth2 != null && !secondDepthSet.contains(depth2)) {
				secondDepthList.add(depth2);
				secondDepthSet.add(depth2);
			}
		}
		
		

		/// 이벤트count용 PageVO 설정
		PageVO eventPageVO = new PageVO();
		eventPageVO.setPage(eventPage);
		eventPageVO.setRegionDepth1(regionDepth1);
		eventPageVO.setRegionDepth2(regionDepth2);
		eventPageVO.setDataCount(countDao.eventListCount(eventPageVO));
		
		/// 게시글count용 PageVO 설정
		PageVO boardPageVO = new PageVO();
		boardPageVO.setPage(boardPage);
		boardPageVO.setRegionDepth1(regionDepth1);
		boardPageVO.setRegionDepth2(regionDepth2);
		boardPageVO.setDataCount(countDao.boardListCount(boardPageVO));

		/// 좋아요순용 PageVO 설정
		PageVO likePageVO = new PageVO();
		likePageVO.setPage(boardPage);
		likePageVO.setRegionDepth1(regionDepth1);
		likePageVO.setRegionDepth2(regionDepth2);
		likePageVO.setDataCount(countDao.clubLikeListCount(likePageVO));
		
		/// 카운트한 정보 모델로 전달 (정모 횟수 / 게시글 횟수 / 좋아요 수)
		// - pageVO에 depth1, depth2 값을 미설정하면 일반 list
		// - 1,2 설정(비어있지 않으면)하면 그 값과 일치하는 검색
		List<ClubCountVO> clubEventCountVO = countDao.selectEventListWithPaging(eventPageVO);
		List<ClubCountVO> clubBoardCountVO = countDao.selectBoardListWithPaging(boardPageVO);
		List<ClubCountVO> clubLikeCountVO = countDao.selectLikeListWithPaging(likePageVO);
		model.addAttribute("clubEventCountVO", clubEventCountVO);
		model.addAttribute("clubBoardCountVO", clubBoardCountVO);
		model.addAttribute("clubLikeCountVO", clubLikeCountVO);
		model.addAttribute("eventPageVO", eventPageVO);
		model.addAttribute("boardPageVO", boardPageVO);
		model.addAttribute("likePageVO", likePageVO);
		
		model.addAttribute("depth1", regionDepth1);
		model.addAttribute("depth2", regionDepth2);
		
		
		
		model.addAttribute("firstDepthList", firstDepthList);
		model.addAttribute("secondDepthList", secondDepthList);
		
		return "/WEB-INF/views/main.jsp";
	}

	@RequestMapping("/icon")
	public String icon() {
		return "/WEB-INF/views/icon.jsp";
	}


	@GetMapping("/search")
	public String search(@ModelAttribute(value="pageVO") PageVO pageVO, 
			@RequestParam(required=false) String keyword, Model model) {
		int resultCount = clubDao.searchResultCount(keyword);
		
		pageVO.setDataCount(resultCount);
		List<ClubCountVO> clubList = clubDao.selectListByResultWithPaging(pageVO, keyword);
		
		model.addAttribute("resultCount", resultCount);
		model.addAttribute("clubList", clubList);
		model.addAttribute("keyword", keyword);
		
		return "/WEB-INF/views/search.jsp";
	}
}