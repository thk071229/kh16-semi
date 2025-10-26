package com.kh.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin/stat")
public class AdminStatController {
	
	@RequestMapping("/chart")
	public String chart() {
		return "/WEB-INF/views/admin/stat/chart.jsp";
	}
}
