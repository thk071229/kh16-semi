package com.kh.semi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/etc")
public class EtcController {
	
	@RequestMapping("/query")
	public String query() {
		return "/WEB-INF/views/etc/query.jsp";
	}
	@RequestMapping("/mainExplain")
	public String mainExplain() {
		return "/WEB-INF/views/etc/mainExplain.jsp";
	}
	@RequestMapping("/agree")
	public String agree() {
		return "/WEB-INF/views/etc/agree.jsp";
	}
	@RequestMapping("/serviceAgree")
	public String serviceAgree() {
		return "/WEB-INF/views/etc/serviceAgree.jsp";
	}
}
