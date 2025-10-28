package com.kh.semi.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.CategoryDao;
import com.kh.semi.dto.CategoryDto;

@CrossOrigin
@RestController
@RequestMapping("/rest/category")
public class CategoryRestController {
	
	@Autowired
	private CategoryDao categoryDao;
	
	@RequestMapping("/list")
	public List<CategoryDto> list(){
		return categoryDao.selectList();
	}
}
