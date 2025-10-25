package com.kh.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.semi.dao.StatDao;

@Controller
@RequestMapping("/admin/stat")
public class AdminStatController {
	
	@Autowired
	private StatDao statDao;

	@RequestMapping("/chart")
	public String chart() {
		return "/WEB-INF/views/admin/stat/chart.jsp";
	}
}
