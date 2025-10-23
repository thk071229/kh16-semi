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
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.MemberCategoryDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberRegionDao;
import com.kh.semi.dao.RegionDao;
import com.kh.semi.dto.CategoryDto;
import com.kh.semi.dto.MemberCategoryDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.service.MemberService;
import com.kh.semi.vo.MemberCategoryListVO;
import com.kh.semi.vo.MemberClubListVO;
import com.kh.semi.vo.MemberRegionListVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MemberCategoryDao memberCategoryDao;
	@Autowired
	private MemberRegionDao memberRegionDao;
	@Autowired
	private MemberService memberService;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private RegionDao regionDao;
	@Autowired
	private ClubDao clubDao;
	
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/member/join.jsp";
	}
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:joinFinish?memberId=" + memberDto.getMemberId();
	}
	//회원 가입 후 관심 지역 & 관심 카테고리 등록
	@GetMapping("/joinFinish")
	public String joinFinish(@RequestParam String memberId, Model model) {
		//회원 ID를 다음 단계에서 사용하도록 JSP에 전달
		model.addAttribute("memberId", memberId);
		//category list를 다음 단계에서 사용하도록 JSP에 전달
		List<CategoryDto>categoryList = categoryDao.selectList();
		model.addAttribute("categoryList", categoryList);
				
		return "/WEB-INF/views/member/joinFinish.jsp";
	}
	@PostMapping("/joinFinish")
	public String joinFinish(
			@RequestParam String memberId,
			@ModelAttribute MemberCategoryDto memberCategoryDto) {
				
		//관심 지역 & 카테고리 등록 처리
		//regionDto에서 지역 번호를 꺼내서 넣음
		
		
		memberCategoryDto.setMemberId(memberId);
		memberCategoryDao.insert(memberCategoryDto);
		
		return "redirect:/";
	}

	//로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, HttpSession session) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		if(findDto == null) return "redirect:login?error";
		
		boolean isLogin = findDto.getMemberPw().equals(memberDto.getMemberPw());
		
		//session에 원하는 요소 저장
		if(isLogin) {
			session.setAttribute("loginId", findDto.getMemberId());
			session.setAttribute("loginLevel", findDto.getMemberLevel());
			
			return "redirect:/";
		}
		else {
			return "redirect:login?error"; 
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
		if(memberDto == null) throw new TargetNotFoundException("존재하지 않는 회원");
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/member/detail.jsp";
	}
	
	//마이페이지 매핑
	@RequestMapping("/mypage")
	public String mypage(Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		
		//회원이 선택한 선호지역 리스트
		List<MemberRegionListVO>regionList = memberRegionDao.selectVOList(loginId);
		//회원이 선택한 카테고리 리스트
		List<MemberCategoryListVO>categoryList = memberCategoryDao.selectVOList(loginId);
		//회원이 가입한 소모임 리스트
		List<MemberClubListVO>clubList = clubDao.selectClubList(loginId);
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("regionList", regionList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("clubList", clubList);
		return "/WEB-INF/views/member/mypage.jsp";
	}
	
	//회원 탈퇴
	@GetMapping("/drop")
	public String drop() {
		return "/WEB-INF/views/member/drop.jsp";
	}
	@PostMapping("/drop")
	public String drop(HttpSession session, @RequestParam String memberPw) {
		String loginId = (String) session.getAttribute("loginId");
		boolean result = memberService.drop(loginId, memberPw);
		
		if(result) {
			session.removeAttribute("loginId");
			session.removeAttribute("loginLevel");
			return "redirect:goodbye";
		}
		else {
			return "redirect:drop?error";
		}
	}
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
		boolean isValid = memberDto.getMemberPw().equals(findDto.getMemberPw());
		if(!isValid) {//비밀번호 불일치
			return "redirect:edit?error";
		}
		
		memberDto.setMemberId(loginId);
		memberDao.updateMember(memberDto);
		
		return "redirect:mypage";
	}
	
	//선호지역 수정
	/*
	 * @GetMapping("/editRegion") public String editRegion(Model model, HttpSession
	 * session) { String loginId = (String)session.getAttribute("loginId");
	 * List<MemberRegionListVO>regionList = memberRegionDao.selectVOList(loginId);
	 * model.addAttribute("regionList", regionList); return
	 * "/WEB-INF/views/member/editRegion.jsp"; }
	 * 
	 * @PostMapping("/editRegion") public String
	 * editRegion(@ModelAttribute("regions") MemberRegionDto[] memberRegions,
	 * 
	 * @RequestParam("oldRegionNo") int[] oldRegionNos, HttpSession session) { //
	 * memberRegionDto와 수정 전의 regionNo를 배열로 받아온다 String loginId = (String)
	 * session.getAttribute("loginId");
	 * 
	 * for (int i = 0; i < memberRegions.length; i++) {
	 * memberRegions[i].setMemberId(loginId);
	 * memberRegionDao.update(memberRegions[i], oldRegionNos[i]); }
	 * 
	 * return "redirect:/mypage"; }
	 * 
	 * //카테고리 수정
	 * 
	 * @GetMapping("/editCategory") public String editCategory(Model model,
	 * HttpSession session) { String loginId = (String)
	 * session.getAttribute("loginId");
	 * 
	 * // 회원이 선택한 카테고리 List<MemberCategoryListVO> categoryList =
	 * memberCategoryDao.selectVOList(loginId); // 전체 카테고리 List<CategoryDto>
	 * allCategoryList = categoryDao.selectList();
	 * 
	 * model.addAttribute("categoryList", categoryList);
	 * model.addAttribute("allCategoryList", allCategoryList);
	 * 
	 * return "/WEB-INF/views/member/editCategory.jsp"; }
	 * 
	 * // POST – 수정 처리
	 * 
	 * @PostMapping("/editCategory") public String
	 * editCategory(@RequestParam("categoryNos") List<Integer> categoryNos,
	 * HttpSession session) { String loginId = (String)
	 * session.getAttribute("loginId"); memberCategoryDao.updateCategories(loginId,
	 * categoryNos); return "redirect:/mypage"; }
	 */
	
	@GetMapping("/editCategory")
	public String editCategory(Model model, HttpSession session) {
		//사용자 아이디 전달
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginId);
		
		//category list를 다음 단계에서 사용하도록 JSP에 전달
		List<CategoryDto>categoryList = categoryDao.selectList();
		model.addAttribute("categoryList", categoryList);
		
		//사용자의 선호 카테고리 조회해서 전달
		MemberCategoryDto memberCategoryDto = memberCategoryDao.selectById(loginId);
		model.addAttribute("oldMemberCategoryDto", memberCategoryDto);
		
		return "/WEB-INF/views/member/editCategory.jsp";
	}
	
	@PostMapping("/editCategory")
	public String editCategory(@ModelAttribute CategoryDto categoryDto, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberCategoryDto memberCategoryDto = memberCategoryDao.selectById(loginId);
		int oldCategoryNo = memberCategoryDto.getCategoryNo();
		memberCategoryDto.setCategoryNo(categoryDto.getCategoryNo());
		memberCategoryDao.update(memberCategoryDto, oldCategoryNo);
		
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
		if(isValid == false) return "redirect:password?error";
		
		memberDao.updateMemberPw(loginId, changePw);
		
		return "redirect:mypage";
	}
	
	//첨부파일을 반환하는 매핑
	@GetMapping("/profile")
	public String profile(@RequestParam String memberId) {
		try {
			int attachmentNo = memberDao.findAttachment(memberId);
			return "redirect:/attachment/download?attachmentNo="+attachmentNo;
		}
		catch(Exception e) {
			return "redirect:/images/error/no-image.png";
		}
	}
	
}
