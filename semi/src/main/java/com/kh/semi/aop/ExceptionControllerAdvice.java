package com.kh.semi.aop;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.kh.semi.error.NeedPermissionException;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.error.UnauthorizationException;

@ControllerAdvice
public class ExceptionControllerAdvice {

	@ExceptionHandler(TargetNotFoundException.class)
	public String notFound(TargetNotFoundException e, Model model) {
		model.addAttribute("title", e.getMessage());
		return "/WEB-INF/views/error/notFound.jsp";
	}
	@ExceptionHandler(UnauthorizationException.class)
	public String unauthorized(UnauthorizationException e, Model model) {
		model.addAttribute("title", e.getMessage());
		return "/WEB-INF/views/error/unauthorize.jsp";
	}
	@ExceptionHandler(NeedPermissionException.class)
	public String needPermission(NeedPermissionException e, Model model) {
		model.addAttribute("title", e.getMessage());
		return "/WEB-INF/views/error/needPermission.jsp";
	}
	@ExceptionHandler(Exception.class)
	public String all(Exception e) {
		e.printStackTrace();
		return "/WEB-INF/views/error/all.jsp";
	}
}
