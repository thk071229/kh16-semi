package com.kh.semi.restcontroller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.StatDao;
import com.kh.semi.vo.ChartVO;
import com.kh.semi.vo.StatVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/admin/stat")
public class AdminStatRestController {
	@Autowired
	private StatDao statDao;
	
	//모임 관련 매핑
	@PostMapping("/club/category")
	public ChartVO clubCountByCategory() {
		//데이터 받아오기
		List<StatVO> list = statDao.countByClubCategory();
		
		//각 label 과 data를 저장하도록 빈 리스트 생성
		List<String> labels = new ArrayList<>();
		List<Double> data = new ArrayList<>();
		
		//라벨과 데이터 저장
		for(StatVO statVO : list) {
			labels.add(statVO.getTitle());
			data.add(statVO.getValue());
		}
		//ChartVO의 형태로 반환
		return ChartVO.builder()
						.subject("카테고리 별 모임 수")
						.type("doughnut")
						.labels(labels)
						.data(data)
						.build();
	}
	
	@PostMapping("/club/region")
	public ChartVO clubCountByRegion() {
		//데이터 받아오기
		List<StatVO> list = statDao.countByClubRegion();
		
		//각 label 과 data를 저장하도록 빈 리스트 생성
		List<String> labels = new ArrayList<>();
		List<Double> data = new ArrayList<>();
		
		//라벨과 데이터 저장
		for(StatVO statVO : list) {
			labels.add(statVO.getTitle());
			data.add(statVO.getValue());
		}
		//ChartVO의 형태로 반환
		return ChartVO.builder()
						.subject("지역 별 모임 수")
						.type("doughnut")
						.labels(labels)
						.data(data)
						.build();
	}
	//정모 관련 매핑
	@PostMapping("/event/category")
	public ChartVO eventCountByCategory() {
		//데이터 받아오기
		List<StatVO> list = statDao.countByClubRegion();
		
		//각 label 과 data를 저장하도록 빈 리스트 생성
		List<String> labels = new ArrayList<>();
		List<Double> data = new ArrayList<>();
		
		//라벨과 데이터 저장
		for(StatVO statVO : list) {
			labels.add(statVO.getTitle());
			data.add(statVO.getValue());
		}
		//ChartVO의 형태로 반환
		return ChartVO.builder()
						.subject("지역 별 모임 수")
						.type("doughnut")
						.labels(labels)
						.data(data)
						.build();
	}
	
	@PostMapping("/event/region")
	public ChartVO eventCountByRegion() {
		//데이터 받아오기
		List<StatVO> list = statDao.countByClubRegion();
		
		//각 label 과 data를 저장하도록 빈 리스트 생성
		List<String> labels = new ArrayList<>();
		List<Double> data = new ArrayList<>();
		
		//라벨과 데이터 저장
		for(StatVO statVO : list) {
			labels.add(statVO.getTitle());
			data.add(statVO.getValue());
		}
		//ChartVO의 형태로 반환
		return ChartVO.builder()
						.subject("지역 별 모임 수")
						.type("doughnut")
						.labels(labels)
						.data(data)
						.build();
	}
	//회원 관련 매핑
	@PostMapping("/member/category")
	public ChartVO memberCountByCategory() {
	    List<StatVO> list = statDao.countByMemberCategory();
	    List<String> labels = new ArrayList<>();
	    List<Double> data = new ArrayList<>();
	    for(StatVO statVO : list) {
	        labels.add(statVO.getTitle());
	        data.add(statVO.getValue());
	    }
	    return ChartVO.builder()
	            .subject("카테고리 별 회원 수")
	            .type("doughnut")
	            .labels(labels)
	            .data(data)
	            .build();
	}

	@PostMapping("/member/region")
	public ChartVO memberCountByRegion() {
	    List<StatVO> list = statDao.countByMemberRegion();
	    List<String> labels = new ArrayList<>();
	    List<Double> data = new ArrayList<>();
	    for(StatVO statVO : list) {
	        labels.add(statVO.getTitle());
	        data.add(statVO.getValue());
	    }
	    return ChartVO.builder()
	            .subject("지역 별 회원 수")
	            .type("doughnut")
	            .labels(labels)
	            .data(data)
	            .build();
	}

	@PostMapping("/member/gender")
	public ChartVO memberGenderRatio() {
	    List<StatVO> list = statDao.memberGenderRatio();
	    List<String> labels = new ArrayList<>();
	    List<Double> data = new ArrayList<>();
	    for(StatVO statVO : list) {
	        labels.add(statVO.getTitle());
	        data.add(statVO.getValue());
	    }
	    return ChartVO.builder()
	            .subject("회원 성비")
	            .type("doughnut")
	            .labels(labels)
	            .data(data)
	            .build();
	}

	@PostMapping("/member/age")
	public ChartVO memberAgeRatio() {
	    List<StatVO> list = statDao.memberAgeRatio();
	    List<String> labels = new ArrayList<>();
	    List<Double> data = new ArrayList<>();
	    for(StatVO statVO : list) {
	        labels.add(statVO.getTitle());
	        data.add(statVO.getValue());
	    }
	    return ChartVO.builder()
	            .subject("회원 나이 비율")
	            .type("doughnut")
	            .labels(labels)
	            .data(data)
	            .build();
	}

}
