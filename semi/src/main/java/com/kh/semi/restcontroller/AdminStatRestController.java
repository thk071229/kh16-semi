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
						.type("bar")
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
						.type("bar")
						.labels(labels)
						.data(data)
						.build();
	}
	
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
						.type("bar")
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
						.type("bar")
						.labels(labels)
						.data(data)
						.build();
	}
}
