package com.kh.semi.restcontroller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.vo.PageVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/list")
public class ListRestController {
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private ClubDao clubDao;
	
	@Autowired
	private EventDao eventDao;
	
	@PostMapping("/more")
	public List<?> list(@ModelAttribute PageVO pageVO, @RequestParam String type,
			@RequestParam(required = false) String parentParams) {
		switch(type.toLowerCase()) {
		case "board" :
			int clubNo = Integer.parseInt(parentParams);
			return boardDao.selectListWithPaging(pageVO, clubNo);
		case "club" :
			return clubDao.selectList(pageVO);

		default :
			return Collections.emptyList();
		}
	}
}
