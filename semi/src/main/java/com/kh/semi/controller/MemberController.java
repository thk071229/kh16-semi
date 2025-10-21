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

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:joinFinish";
	}
	@PostMapping("/joinFinish")
	public String joinFinish() {
		//회원 관심 지역&카테고리 설정 페이지
		return "/WEB-INF/views/member/joinFinish.jsp";
	}

	//로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, HttpSession session) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		//if(findDto == null) return "redirect:에러페이지";
		
		boolean isLogin = findDto.getMemberPw().equals(memberDto.getMemberPw());
		
		//session에 원하는 요소 저장
		if(isLogin) {
			session.setAttribute("loginId", findDto.getMemberId());
			session.setAttribute("loginLevel", findDto.getMemberLevel());
			
			return "redirect:/";
		}
		else {
			return "redirect:/"; //return "redirect:에러페이지";
		}
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("loginId");
		session.removeAttribute("loginLevel");
		return "redirect:/";
	}
	
	//회원 상세페이지
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		//if(memberDto == null) 
		//	throw new TargetNotfoundException("존재하지 않는 회원");
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/detail.jsp";
	}
	
	//마이페이지 매핑
	@RequestMapping("/mypage")
	public String mypage(Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/mypage.jsp";
	}
	
	//회원 탈퇴
	@GetMapping("/drop")
	public String drop() {
		return "/WEB-INF/views/member/drop.jsp";
	}
	/*@PostMapping("/drop")
	public String drop(HttpSession session, @RequestParam String memberPw) {
		String loginId = (String) session.getAttribute("loginId");
		//boolean result = memberService.drop(loginId, memberPw);
		
		//if(result) {
		//	session.removeAttribute("loginId");
		//	session.removeAttribute("loginLevel");
		//	return "redirect:goodbye";
		//}
		//else {
		//	return "redirect:에러페이지";
		//}
	}*/
	@RequestMapping("/goodbye")
	public String goodbye() {
		return "/WEB-INF/views/member/goodbye.jsp";
	}
	
	//수정
	//회원이 자기 자신의 정보 수정
	@GetMapping("/edit")
	public String edit(Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		MemberDto findDto= memberDao.selectOne(loginId);
		boolean isValid = memberDto.getMemberId().equals(findDto.getMemberId());
		//if(!isValid) {
		//	return "redirect:에러페이지";
		//}
		
		memberDto.setMemberId(loginId);
		memberDao.updateMember(memberDto);
		
		return "redirect:mypage";
	}
	
	//비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/member/password.jsp";
	}
	@PostMapping("/password")
	public String password(HttpSession session, 
			@RequestParam String currentPw, @RequestParam String changePw) {
		String loginId = (String) session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		boolean isValid = memberDto.getMemberPw().equals(currentPw);
		//if(isValid == false) return "redirect:password?error";
		
		memberDao.updateMemberPw(loginId, changePw);
		
		return "redirect:mypage";
	}
	
}
