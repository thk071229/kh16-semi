package com.kh.semi.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.CategoryDao;
import com.kh.semi.dto.CategoryDto;

@Controller
@RequestMapping("/admin/category")
public class AdminCategoryController {
	@Autowired
	private CategoryDao categoryDao;
	
	//목록
	@RequestMapping("/list")
	public String list(Model model) {
		List<CategoryDto> categoryList = categoryDao.selectList();
		model.addAttribute("categoryList", categoryList);
		return "/WEB-INF/views/admin/category/list.jsp";
	}
	
	//추가
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/category/add.jsp";
	}
	
	@PostMapping("/add")
	public String add(@ModelAttribute CategoryDto categoryDto) {
		int categoryNo = categoryDao.sequence();
		categoryDto.setCategoryNo(categoryNo);
		categoryDao.insert(categoryDto);
		
		return "redirect:list";
	}
}
