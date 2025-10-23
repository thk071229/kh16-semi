package com.kh.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.vo.PageVO;

@Controller
@RequestMapping("/admin/club")
public class AdminClubController {
	@Autowired
	private ClubDao clubDao;
	@Autowired
	private AttachmentService attachmentService;
	
	
	
	//목록 & 검색
	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute(value = "pageVO") PageVO pageVO) {
		model.addAttribute("clubList", clubDao.selectListWithPaging(pageVO));
		pageVO.setDataCount(clubDao.count(pageVO));
		return "/WEB-INF/views/admin/club/list.jsp";
	}
	
	//삭제
	@RequestMapping("/drop")
	public String drop(@RequestParam int clubNo) {
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto==null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		//club의 이미지가 있는지 확인하여 삭제
		/*try {
			int attachmentNo = clubDao.findAttachment(clubNo);
			attachmentService.delete(attachmentNo);
		} catch(Exception e) {}*/
		
		clubDao.delete(clubNo);
		return "redirect:list";
	}
	
}
