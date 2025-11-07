package com.kh.semi.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.BoardLikeDao;
import com.kh.semi.dao.CategoryDao;
import com.kh.semi.dao.CertDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubLikeDao;
import com.kh.semi.dao.EventDao;
import com.kh.semi.dao.MemberCategoryDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberRegionDao;
import com.kh.semi.dao.PointUseDao;
import com.kh.semi.dto.CategoryDto;
import com.kh.semi.dto.CertDto;
import com.kh.semi.dto.MemberCategoryDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.dto.PointUseDto;
import com.kh.semi.error.NeedPermissionException;
import com.kh.semi.error.NoImageException;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.service.EmailService;
import com.kh.semi.service.MemberService;
import com.kh.semi.vo.BoardListVO;
import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.EventAttendeeListVO;
import com.kh.semi.vo.EventListVO;
import com.kh.semi.vo.MemberCategoryListVO;
import com.kh.semi.vo.MemberClubListVO;
import com.kh.semi.vo.MemberRegionListVO;
import com.kh.semi.vo.PageVO;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
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
	private ClubDao clubDao;
	@Autowired
	private ClubLikeDao clubLikeDao;
	@Autowired
	private EventDao eventDao;
	@Autowired
	private AttachmentService attachmentService;
	@Autowired
	private EmailService emailService;
	@Autowired
	private CertDao certDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private BoardLikeDao boardLikeDao;
	@Autowired
	private PointUseDao pointUseDao;
	
	//ava.sql.Date 타입으로 변환할 때 빈 문자열을 허용하고 자동으로 null로 처리 해주는 메소드
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // 날짜 형식을 지정합니다 (HTML <input type="date">의 기본 형식인 yyyy-MM-dd)
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        // 엄격한 형식 검사
        dateFormat.setLenient(false);
        
        // CustomDateEditor를 등록하여 Date 타입 변환을 처리합니다.
        // 두 번째 인자 'true'는 'allowEmpty'를 의미합니다.
        // 폼에서 빈 문자열("")이 넘어오면 자동으로 null 값으로 처리됩니다.
        binder.registerCustomEditor(java.sql.Date.class, 
                                    new CustomDateEditor(dateFormat, true));
    }
	
	
	//이용약관 동의
	@GetMapping("/agree")
	public String agree() {
		return "/WEB-INF/views/member/agree.jsp";
	}
	
	//회원가입
	@GetMapping("/join")
	public String join(Model model) {
		//category list를 다음 단계에서 사용하도록 JSP에 전달
		List<CategoryDto>categoryList = categoryDao.selectList();
		model.addAttribute("categoryList", categoryList);
		return "/WEB-INF/views/member/join.jsp";
	}
	@PostMapping("/join")
	public String join(
			@ModelAttribute MemberDto memberDto, 
			HttpSession session,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException, MessagingException {
		
		memberDao.insert(memberDto);
		if(attach.isEmpty() == false) {//첨부파일이 비어있지 않다면(=있으면)
			int attachmentNo = attachmentService.save(attach);
			memberDao.connect(memberDto.getMemberId(), attachmentNo);
		}
		
		//가입 환영 메일 발송
		emailService.sendWelcomeMail(memberDto);
		
		return "redirect:firstLogin";
	}
	
	@GetMapping("/firstLogin")
	public String fistLogin() {
		return "/WEB-INF/views/member/firstLogin.jsp";
	}
	@PostMapping("/firstLogin")
	public String firstLogin(@ModelAttribute MemberDto memberDto, HttpSession session) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		if(findDto == null) return "redirect:firstLogin?error";
		
		boolean isLogin = findDto.getMemberPw().equals(memberDto.getMemberPw());
		
		//session에 원하는 요소 저장
		if(isLogin) {
			session.setAttribute("loginId", findDto.getMemberId());
			session.setAttribute("loginLevel", findDto.getMemberLevel());
			
			return "redirect:joinFinish";
		}
		else {
			return "redirect:firstLogin?error"; 
		}
	}
	
	//회원 가입 후 관심 지역 & 관심 카테고리 등록
	@GetMapping("/joinFinish")
	public String joinFinish(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("loginId");
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
			@RequestParam String regionName,
			@RequestParam String regionType,
			@RequestParam(required = false) String regionDepth1,
			@RequestParam(required = false) String regionDepth2,
			@ModelAttribute MemberCategoryDto memberCategoryDto) {
				
		//관심 지역 & 카테고리 등록 처리
		
		memberCategoryDto.setMemberId(memberId);
		memberCategoryDao.insert(memberCategoryDto);
		
		memberService.addMemberRegion(memberId, regionName, regionDepth1, regionDepth2, regionType);
		
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
			// 로그인 성공시 회원 포인트 갱신
			memberService.refreshMemberPoint(findDto.getMemberId());
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

		model.addAttribute("memberDto", memberDto);
		model.addAttribute("regionList", regionList);
		model.addAttribute("categoryList", categoryList);

		return "/WEB-INF/views/member/mypage.jsp";
	}
	
	//회원이 참여한 정모 목록 & 만든 정모 목록
	@RequestMapping("/memberClub")
	public String memberClub(Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		//회원이 가입한 소모임 리스트
		List<MemberClubListVO>clubList = clubDao.selectClubList(loginId);
		model.addAttribute("clubList", clubList);
		return "/WEB-INF/views/member/memberClub.jsp";
	}
	
	
	//회원이 참여한 정모 목록 & 만든 정모 목록
	@RequestMapping("/memberEvent")
	public String memberEvent(Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		
		//회원이 참여한 정모 리스트
		List<EventAttendeeListVO> eventAttendeeList = eventDao.selectListWithMember(loginId);
		//회원이 개최한 정모 리스트
		List<EventListVO> eventList = eventDao.selectListWithWriter(loginId);
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("eventAttendeeList", eventAttendeeList);
		model.addAttribute("eventList", eventList);
		
		return "/WEB-INF/views/member/memberEvent.jsp";
	}
	
	//회원이 작성한 게시글 목록
	@RequestMapping("/memberBoard")
	public String memberBoard(@ModelAttribute(value="pageVO")PageVO pageVO, Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		
		pageVO.setDataCount(boardDao.countByBoardWriter(loginId));
		List<BoardListVO> boardList = boardDao.selectListByBoardWriter(pageVO, loginId);
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("boardList", boardList);
		
		return "/WEB-INF/views/member/memberBoard.jsp";
	}
	
	//회원이 좋아요를 누른 게시글 목록
	@RequestMapping("/memberLike")
	public String memberLike(@ModelAttribute(value="pageVO")PageVO pageVO, Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		
		pageVO.setDataCount(boardLikeDao.countLike(loginId));
		List<BoardListVO> boardList = boardDao.selectListLikeWithPaging(pageVO, loginId);
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("boardList", boardList);
		
		return "/WEB-INF/views/member/memberLike.jsp";
	}
	
	//회원이 찜한 소모임 목록
	@RequestMapping("/memberLikeClub")
	public String memberLikeClub(@ModelAttribute(value="pageVO")PageVO pageVO, Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		
		pageVO.setDataCount(clubLikeDao.countByMemberId(loginId));
		List<ClubListVO> clubList = clubDao.selectListLikeWithPaging(pageVO, loginId);
		
		model.addAttribute("memberDto", memberDto);
		model.addAttribute("clubList", clubList);
		
		return "/WEB-INF/views/member/memberLikeClub.jsp";
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
	
	//선호하는 지역 수정
	@GetMapping("/editRegion")
	public String editRegion(Model model,HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginId);
		
		return "/WEB-INF/views/member/editRegion.jsp";
	}
	@PostMapping("/editRegion")
	public String editRegion(HttpSession session,
			@RequestParam String regionName,
			@RequestParam String regionType,
			@RequestParam(required = false) String regionDepth1,
			@RequestParam(required = false) String regionDepth2) {
		String memberId = (String) session.getAttribute("loginId");
		
		memberService.editMemberRegion(memberId, regionName, regionDepth1, regionDepth2, regionType);
		
		return "redirect:mypage";
	}
	
	//선호하는 카테고리 수정
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
		if(memberCategoryDto == null) {
			// 기존 데이터가 없으면 새로 insert
	        MemberCategoryDto newDto = new MemberCategoryDto();
	        newDto.setMemberId(loginId);
	        newDto.setCategoryNo(categoryDto.getCategoryNo());
	        memberCategoryDao.insert(newDto);
		}
		else {
			int oldCategoryNo = memberCategoryDto.getCategoryNo();
			memberCategoryDto.setCategoryNo(categoryDto.getCategoryNo());
			memberCategoryDao.update(memberCategoryDto, oldCategoryNo);
		}
		
		return "redirect:mypage";
	}
	
	
	//비밀번호 변경
	@GetMapping("/password")
	public String password() {
		return "/WEB-INF/views/member/password.jsp";
	}
	@PostMapping("/password")
	public String password(HttpSession session, 
			@RequestParam String currentPw, @RequestParam String memberPw) {
		String loginId = (String) session.getAttribute("loginId");
		MemberDto memberDto = memberDao.selectOne(loginId);
		boolean isValid = memberDto.getMemberPw().equals(currentPw);
		if(isValid == false) return "redirect:password?error";
		
		memberDao.updateMemberPw(loginId, memberPw);
		
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
	
	//아이디 및 비밀번호 찾기
	//아이디
	@GetMapping("/findMemberId")
	public String findMemberId() {
		return "/WEB-INF/views/member/findMemberId.jsp";
	}
	@PostMapping("/findMemberId")
	public String findMemberId(@ModelAttribute MemberDto memberDto) {
		//수신한 닉네임으로 사용자 정보를 조회 및 비교하고 존재한다면 이메일 발송
		MemberDto findDto = memberDao.selectOneByNickname(memberDto.getMemberNickname());
		if(findDto == null) return "redirect:findMemberId?error";
		boolean emailValid = memberDto.getMemberEmail().equals(findDto.getMemberEmail());
		if(emailValid == false) return "redirect:findMembrId?error";
		
		//이메일 발송
		emailService.sendEmail(
				findDto.getMemberEmail(), 
				"[SOSO] 아이디 찾기 결과", 
				findDto.getMemberNickname()+"님의 아이디는 ["
				+findDto.getMemberId()+"] 입니다"
		);
		
		return "redirect:findMemberIdFinish";
	}
	@RequestMapping("/findMemberIdFinish")
	public String findMemberIdFinish() {
		return "/WEB-INF/views/member/findMemberIdFinish.jsp";
	}
	
	//비밀번호
	//이메일에서 비밀번호 재설정 눌러서 오는 곳
	@GetMapping("/changeMemberPw")
	public String changeMemberPw(
			@RequestParam String memberId,
			@RequestParam String certNumber, 
			Model model) {
		//아이디로 이메일을 찾아서 인증내역 조회
		MemberDto memberDto = memberDao.selectOne(memberId); //아이디가 존재하는가
		if(memberDto == null) throw new TargetNotFoundException("존재하지 않는 회원");
		 
		CertDto certDto = certDao.selectOne(memberDto.getMemberEmail()); //인증내역이 존재하는가
		if(certDto == null) throw new NeedPermissionException("허가받지 않은 접근");
		
		boolean numberValid = certDto.getCertNumber().equals(certNumber); //인증번호가 일치하는가
		if(numberValid == false) throw new NeedPermissionException("허가받지 않은 접근");
		
		LocalDateTime current = LocalDateTime.now(); //현재시각
		LocalDateTime created = certDto.getCertTime().toLocalDateTime(); //인증생성시각
		
		Duration duration = Duration.between(created, current);
		boolean timeValid = duration.toSeconds() <= 600;//10분 0초
		if(timeValid == false) throw new NeedPermissionException("인증정보 만료됨");
		
		model.addAttribute("memberId", memberId);
		model.addAttribute("certNumber", certNumber);
		
		return "/WEB-INF/views/member/changeMemberPw.jsp";
	}
	@PostMapping("/changeMemberPw")
	public String changeMemberPw(
			@ModelAttribute MemberDto memberDto, 
			@RequestParam String certNumber) {
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		if(findDto == null) return "redirect:changeMemberPw?error";
		
		//아이디로 이메일을 찾아서 인증내역을 조회
		CertDto certDto = certDao.selectOne(findDto.getMemberEmail()); //인증내역이 존재하는가
		if(certDto == null) throw new NeedPermissionException("허가받지 않은 접근");
		boolean numberValid = certDto.getCertNumber().equals(certNumber); //인증번호가 일치하는가
		if(numberValid == false) throw new NeedPermissionException("허가받지 않은 접근");
		
		LocalDateTime current = LocalDateTime.now();//현재시각
		LocalDateTime created = certDto.getCertTime().toLocalDateTime();//인증생성시각
		Duration duration = Duration.between(created, current);
		
		boolean timeValid = duration.toSeconds() <= 600;//10분 0초까지
		if(timeValid == false) throw new NeedPermissionException("인증정보 만료됨");
		
		memberDao.updateMemberPw(memberDto);//비밀번호 변경
		certDao.delete(findDto.getMemberEmail());//인증정보 재사용 금지(삭제)
		
		return "redirect:changeMemberPwFinish";
	}
	@RequestMapping("/changeMemberPwFinish")
	public String changeMemberPwFinish() {
		return "/WEB-INF/views/member/changeMemberPwFinish.jsp";
	}
	
	@GetMapping("/findMemberPw")
	public String findMemberPw() {
		return "/WEB-INF/views/member/findMemberPw.jsp";
	}
	@PostMapping("/findMemberPw")
	public String findMemberPw(@ModelAttribute MemberDto memberDto) throws MessagingException, IOException {
		//검사 후 메일 발송
		MemberDto findDto = memberDao.selectOne(memberDto.getMemberId());
		if(findDto == null) return "redirect:findMemberPw?error";//아이디 없음
		boolean nicknameValid = memberDto.getMemberNickname().equals(findDto.getMemberNickname());
		if(nicknameValid == false) return "redirect:findMemberPw?error";//닉네임 불일치
		boolean emailValid = memberDto.getMemberEmail().equals(findDto.getMemberEmail());
		if(emailValid == false) return "redirect:findMemberPw?error";//이메일 불일치

		emailService.sendResetPassword(findDto);//비밀번호 재설정 메일 발송
		
		return "redirect:findMemberPwFinish";
	}
	@RequestMapping("/findMemberPwFinish")
	public String findMemberPwFinish() {
		return "/WEB-INF/views/member/findMemberPwFinish.jsp"; 
	}
	
	
	@GetMapping("/pointUse")
	public String pointUse(HttpSession session, Model model) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new UnauthorizationException("로그인이 필요합니다");
		
		MemberDto memberDto = memberDao.selectOne(loginId);
		model.addAttribute("memberDto", memberDto);
		
		return "/WEB-INF/views/member/pointUse.jsp";
	}
	@PostMapping("/pointUse")
	public String pointUse(HttpSession session) {
		// 로그인 여부 검사
		String loginId = (String)session.getAttribute("loginId");
		if(loginId==null) throw new TargetNotFoundException("로그인이 필요합니다");
		// 생성권한 이미 가지고 있는지 검사
		MemberDto memberDto = memberDao.selectOne(loginId);
		if(memberDto.getMemberAuthority().equals("y")) throw new NoImageException("이미 소모임 생성 권한을 가지고 있습니다");
		// 500포인트 이상 있는지 검사

		if(memberDto.getMemberPoint() < 500) throw new NoImageException("보유 포인트가 부족합니다");

		
		// 포인트 사용 기록
		PointUseDto pointUseDto = new PointUseDto();
		pointUseDto.setUseNo(pointUseDao.sequence()); // 시퀀스 생성해서 저장
		pointUseDto.setUseId(loginId);
		pointUseDto.setUseType("소모임 생성권");
		pointUseDao.insert(pointUseDto);
		
		// 포인트 사용시 포인트 갱신
		memberService.refreshMemberPoint(loginId);
		
		//권한 부여
		memberDao.updateMemberAuthority(loginId);
		
		return "redirect:/";
	}
	@PostMapping("/purchase")
		public String purchase(HttpSession session, Model model) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new UnauthorizationException("로그인이 필요합니다");
		
		MemberDto memberDto = memberDao.selectOne(loginId);
		model.addAttribute("memberDto", memberDto);
		
		memberService.updateMemberAuthorityWithBuy(loginId);
		
		return "redirect:/";
	}
	
}
