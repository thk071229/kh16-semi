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

import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.vo.PageVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/list")
public class ListRestController {
	@Autowired
	private ClubDao clubDao;
	@Autowired
	private EventDao eventDao;
	@Autowired 
	private MemberDao memberDao;
	
	@PostMapping("/more")
	public Map<String, Object> more(@ModelAttribute PageVO pageVO){
		Map<String, Object> result = new HashMap<>();
		//load할 list
		List<?> list = new ArrayList<>();
		int count;
		pageVO.setSize(5);
		switch(pageVO.getType()){
			case "club":
				count = clubDao.count(pageVO);
				pageVO.setDataCount(count);
				list = clubDao.selectListWithPaging(pageVO);
				break;
				
			case "event":
				count = eventDao.count(pageVO);
				list = eventDao.selectListWithPaging(pageVO);
				break;
				
			case "member":
				count = memberDao.count(pageVO);
				pageVO.setDataCount(count);
				list = memberDao.selectListWithPaging(pageVO);
				break;
		}
		
		result.put("list", list);
		result.put("pageVO", pageVO);
		
		return result;
	}
}
