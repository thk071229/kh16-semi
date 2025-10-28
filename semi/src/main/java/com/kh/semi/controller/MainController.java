package com.kh.semi.controller;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semi.dao.CountDao;
import com.kh.semi.dao.RegionDao;
import com.kh.semi.dto.RegionDto;
import com.kh.semi.vo.ClubCountVO;


@Controller
public class MainController {
	@Autowired
	private RegionDao regionDao;
	@Autowired
	private CountDao countDao;

	@RequestMapping("/")
	public String main(Model model) {
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
		
		// 카운트한 정보 모델로 전달 (정모 횟수 / 게시글 횟수)
		List<ClubCountVO> clubEventCountVO = countDao.selectListWithEventCount();
		List<ClubCountVO> clubBoardCountVO = countDao.selectListWithBoardCount();
		List<ClubCountVO> clubLikeCountVO = countDao.selectListWithLikeCount();
		model.addAttribute("clubEventCountVO", clubEventCountVO);
		model.addAttribute("clubBoardCountVO", clubBoardCountVO);
		model.addAttribute("clubLikeCountVO", clubLikeCountVO);
		
		
		model.addAttribute("firstDepthList", firstDepthList);
		model.addAttribute("secondDepthList", secondDepthList);
		
		return "/WEB-INF/views/main.jsp";
	}

}
