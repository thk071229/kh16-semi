package com.kh.semi.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class MainController {
	@Autowired
	
	@RequestMapping("/")
	public String main() {
		return "/WEB-INF/views/main.jsp";
	}
}
