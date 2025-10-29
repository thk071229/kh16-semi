package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.RegionDao;
import com.kh.semi.dto.RegionDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/region")
public class RegionRestCotroller {

	@Autowired
	private RegionDao regionDao;

	@GetMapping("/depth1List") 
	public List<String> depth1List() {
		return regionDao.selectDepth1();
	}
	
	@GetMapping("/depth2List")
	public List<String> depth2List(@RequestParam String regionDepth1) {
		return regionDao.selectDepth2(regionDepth1);
	}
	
	@GetMapping("/dtoListBy1")
	public List<RegionDto> dtoListBy1(@RequestParam String regionDepth1){
		return regionDao.selectByDepth1(regionDepth1);
	}
	
	@GetMapping("/dtoListBy2")
	public List<RegionDto> dtoListBy2(@RequestParam String regionDepth2) {
		return regionDao.selectByDepth2(regionDepth2);
	}

}
