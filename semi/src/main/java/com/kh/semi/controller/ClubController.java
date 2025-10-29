package com.kh.semi.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semi.dao.CategoryDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dao.ClubMemberDao;
import com.kh.semi.dao.CountDao;
import com.kh.semi.dao.MemberDao;
import com.kh.semi.dao.MemberRegionDao;
import com.kh.semi.dto.CategoryDto;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.dto.MemberDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.error.UnauthorizationException;
import com.kh.semi.service.ClubService;
import com.kh.semi.vo.ClubCountVO;
import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.ClubMemberListVO;
import com.kh.semi.vo.MemberRegionListVO;
import com.kh.semi.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/club")
public class ClubController {

	@Autowired
	private ClubDao clubDao;
	@Autowired
	private ClubMemberDao clubMemberDao;
	@Autowired
	private ClubService clubService;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private CountDao countDao;
	@Autowired
	private MemberRegionDao memberRegionDao;
	@Autowired
	private MemberDao memberDao;
	
	
	//소모임 Home으로 이동
		@GetMapping("/home")
		public String home(HttpSession session, @RequestParam int clubNo, Model model, @ModelAttribute PageVO pageVO) {
			String loginId = (String)session.getAttribute("loginId");
			
			// 1. 모임 정보 조회
			ClubDto clubDto = clubDao.selectOne(clubNo);
			if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 소모임");
			model.addAttribute("clubDto", clubDto);
			//+추가 클럽멤버 정보 수정
			List<ClubMemberListVO> memberList = clubMemberDao.selectListWithNickname(clubNo);
					
			model.addAttribute("memberList", memberList);
			if(loginId != null) {
				ClubMemberDto clubMemberDto = clubMemberDao.selectByClubMember(clubNo, loginId);
				model.addAttribute("clubMemberDto", clubMemberDto); 
			}
			
			return "/WEB-INF/views/club/home-more.jsp";
		}
	//소모임 등록
	@GetMapping("/add")
	public String add(Model model, HttpSession session) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {//로그인중이 아니면 로그인 페이지로 이동
			return "redirect:/member/login";
		}
		MemberDto memberDto = memberDao.selectOne(loginId);
		model.addAttribute("memberDto", memberDto);
		 List<CategoryDto> categoryList = categoryDao.selectList(); 
		 model.addAttribute("categoryList", categoryList);
		return "/WEB-INF/views/club/add.jsp";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute ClubDto clubDto, HttpSession session, 
			@RequestParam String regionName, 
			@RequestParam(required = false) String regionDepth1, 
			@RequestParam(required = false) String regionDepth2,
			@RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) {//로그인중이 아니면 로그인 페이지로 이동
			return "/WEB-INF/views/member/login.jsp";
		}
		
		clubDto.setClubLeader(loginId);
		clubService.createClub(clubDto, regionName, regionDepth1, regionDepth2, attach);
		
		return "redirect:addFinish";
	}
	@GetMapping("/addFinish")
	public String addFinish() {
		return "/WEB-INF/views/club/addFinish.jsp";
	}
	
	//수정
	@GetMapping("/edit")
	public String edit(Model model, HttpSession session, @RequestParam int clubNo) {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 2. 모임 존재 확인
		ClubListVO clubList = clubDao.selectOneFromClubList(clubNo);
		if(clubList == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
		if(loginId.equals(clubList.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
		model.addAttribute("clubList", clubList);
		
		ClubDto clubDto = clubDao.selectOne(clubNo);
		model.addAttribute("clubDto", clubDto);
		
		List<CategoryDto> categoryList = categoryDao.selectList();
		model.addAttribute("categoryList", categoryList);
		return "/WEB-INF/views/club/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute ClubDto clubDto, HttpSession session, @RequestParam MultipartFile attach) throws IllegalStateException, IOException {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
				
		// 2. 모임 존재 확인
		ClubDto origin = clubDao.selectOne(clubDto.getClubNo());
		if(origin == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		clubDto.setClubLeader(origin.getClubLeader());
				
		// 3. 권한 확인
		if(loginId.equals(clubDto.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
		
		clubService.updateClub(clubDto, attach);
		
		return "redirect:home?clubNo=" + clubDto.getClubNo();
	}
	
	//삭제 --> 삭제는 관리자 및 소모임장만 가능
	@GetMapping("/delete")
	public String delete(@RequestParam int clubNo, HttpSession session) {
		// 1. 로그인 확인
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) throw new TargetNotFoundException("존재하지 않는 회원");
		
		// 2. 모임 존재 확인
		ClubDto origin = clubDao.selectOne(clubNo);
		if(origin == null) throw new TargetNotFoundException("존재하지 않는 모임");
		
		// 3. 권한 확인
		if(loginId.equals(origin.getClubLeader()) == false) throw new UnauthorizationException("권한 부족");
		clubDao.delete(clubNo);
		return "redirect:list";
	}
	@GetMapping("/recommandList")
	public String recommandList(Model model,
			//@ModelAttribute PageVO pageVO,
			@RequestParam(defaultValue="1") int eventPage,
			@RequestParam(defaultValue="1") int boardPage,
			@RequestParam(defaultValue="1") int likePage,
			HttpSession session
) {
		String loginId = (String)session.getAttribute("loginId");
		if(loginId == null) return "redirect:/member/login?error2";
		
		//로그인 아이디로 Depth1,2 들어있는 VO 조회
		// - 이후, 밑에서 각각에 적용시키기
		MemberRegionListVO memberRegionListVO = memberRegionDao.selectOne(loginId);
		model.addAttribute("regionDepth1",memberRegionListVO.getRegionDepth1());
		model.addAttribute("regionDepth2",memberRegionListVO.getRegionDepth2());
		
		/// 이벤트count용 PageVO 설정
		PageVO eventPageVO = new PageVO();
		eventPageVO.setPage(eventPage);
		eventPageVO.setRegionDepth1(memberRegionListVO.getRegionDepth1());
		eventPageVO.setRegionDepth2(memberRegionListVO.getRegionDepth2());
		eventPageVO.setDataCount(countDao.eventListCount(eventPageVO));
		
		/// 게시글count용 PageVO 설정
		PageVO boardPageVO = new PageVO();
		boardPageVO.setPage(boardPage);
		boardPageVO.setRegionDepth1(memberRegionListVO.getRegionDepth1());
		boardPageVO.setRegionDepth2(memberRegionListVO.getRegionDepth2());
		boardPageVO.setDataCount(countDao.boardListCount(boardPageVO));

		/// 좋아요순용 PageVO 설정
		PageVO likePageVO = new PageVO();
		likePageVO.setPage(boardPage);
		likePageVO.setRegionDepth1(memberRegionListVO.getRegionDepth1());
		likePageVO.setRegionDepth2(memberRegionListVO.getRegionDepth2());
		likePageVO.setDataCount(countDao.clubLikeListCount(likePageVO));
		
		/// 카운트한 정보 모델로 전달 (정모 횟수 / 게시글 횟수 / 좋아요 수)
		// - pageVO에 depth1, depth2 값을 미설정하면 일반 list
		// - 1,2 설정(비어있지 않으면)하면 그 값과 일치하는 검색
		List<ClubCountVO> clubEventCountVO = countDao.selectEventListWithPaging(eventPageVO);
		List<ClubCountVO> clubBoardCountVO = countDao.selectBoardListWithPaging(boardPageVO);
		List<ClubCountVO> clubLikeCountVO = countDao.selectLikeListWithPaging(likePageVO);
		model.addAttribute("clubEventCountVO", clubEventCountVO);
		model.addAttribute("clubBoardCountVO", clubBoardCountVO);
		model.addAttribute("clubLikeCountVO", clubLikeCountVO);
		model.addAttribute("eventPageVO", eventPageVO);
		model.addAttribute("boardPageVO", boardPageVO);
		model.addAttribute("likePageVO", likePageVO);
		
		return "/WEB-INF/views/club/recommandList.jsp";
	}
	//전체 모임 목록
	@GetMapping("/list")
	public String list(Model model, @ModelAttribute PageVO pageVO) {
		
		//1. 전체 목록 카운트
		int dataCount = clubDao.count(pageVO); 
		pageVO.setDataCount(dataCount);
		List<ClubListVO> clubList = clubDao.selectListWithPaging(pageVO);
		model.addAttribute("clubList", clubList);
		
		return "/WEB-INF/views/club/list.jsp";
	}
	
	//카테고리별 소모임 목록
	@RequestMapping("/category")
	public String category(@ModelAttribute(value="pageVO") PageVO pageVO, 
			@RequestParam(required = false) int categoryNo, 
			Model model) {
		
		pageVO.setDataCount(clubDao.clubCategoryCount(categoryNo));
		List <ClubCountVO> clubList = clubDao.selectListByCategoryWithPaging(pageVO, categoryNo);
		
		model.addAttribute("clubList", clubList);
		model.addAttribute("categoryDto", categoryDao.selectOne(categoryNo));
		
		return "/WEB-INF/views/club/category.jsp";
	}
	
	
}
