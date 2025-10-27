package com.kh.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.kh.semi.dao.CategoryDao;
import com.kh.semi.dto.CategoryDto;

@ControllerAdvice
public class GlobalModelController {
	@Autowired
	private CategoryDao categoryDao;
	
	@ModelAttribute("categoryList")
	public List<CategoryDto> categoryList() {
		return categoryDao.selectList();
	}
}
