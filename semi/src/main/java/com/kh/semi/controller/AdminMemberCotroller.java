package com.kh.semi.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.MemberDao;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.vo.PageVO;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberCotroller {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AttachmentService attachmentService;
	
	
	//조회
	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute(value="pageVO") PageVO pageVO) {
		model.addAttribute("memberList", memberDao.selectListWithPaging(pageVO));
		pageVO.setDataCount(memberDao.count(pageVO));
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam String memberId, Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) throw new TargetNotFoundException("존재하지 않는 회원");
		model.addAttribute("memberDto", memberDto);
		//##### 클럽 리스트 추가 필요
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	//탈퇴처리
	@RequestMapping("/drop")
	public String drop(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		//회원 프로필 이미지가 있는지 확인하여 삭제하는 코드 추가
		try {
			int attachmentNo = memberDao.findAttachment(memberId);
			attachmentService.delete(attachmentNo);
		} catch(Exception e) {/* 암것두 안함 */}
		
		memberDao.delete(memberId);
		return "redirect:list";
	}
	
	//회원정보 수정
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) throw new TargetNotFoundException("존재하지 않는 회원 정보");
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/admin/member/edit.jsp";
	} 
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto) {
		memberDao.updateMemberByAdmin(memberDto);
		return "redirect:detail?memberId="+memberDto.getMemberId();
	}
	
}
