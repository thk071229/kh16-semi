package com.kh.semi.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.ClubDao;
import com.kh.semi.dto.BoardDto;
import com.kh.semi.dto.ClubDto;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.service.AttachmentService;
import com.kh.semi.vo.BoardListVO;
import com.kh.semi.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private ClubDao clubDao;
	@Autowired
	private AttachmentService attachmentService;
	
	//게시글 등록 매핑
	@GetMapping("/write")
	public String write(@RequestParam int clubNo, Model model) {
		//clubNo 존재여부 검증 코드 추가
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null){
		 throw new TargetNotFoundException("존재하지 않는 모임입니다");
		}
		model.addAttribute("clubNo", clubNo);
		return "/WEB-INF/views/board/write.jsp";
	}
	@PostMapping("/write")
	public String write(@ModelAttribute BoardDto boardDto, @RequestParam int clubNo, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		boardDto.setBoardWriter(loginId);
		
		int boardNo = boardDao.sequence();
		boardDto.setBoardNo(boardNo);
		
		boardDto.setBoardClub(clubNo);
		
		boardDao.insert(boardDto);
		
		return "redirect:detail?boardNo="+boardNo;
	}
	
	//게시글 상세 조회 매핑
	@RequestMapping("/detail")
	public String detail(@RequestParam int boardNo, Model model) {
		BoardDto boardDto = boardDao.selectOne(boardNo);
		model.addAttribute("boardDto", boardDto);
		return "/WEB-INF/views/board/detail.jsp";
	}
	
	//게시글 목록 조회 매핑(페이지 구현) - 해당 모임의 게시글만 가져오므로 clubNo 필수
	@RequestMapping("/list")
	public String list(Model model, @ModelAttribute PageVO pageVO, @RequestParam int clubNo) {//변수 대신 VO 불러옴
		ClubDto clubDto = clubDao.selectOne(clubNo);
		if(clubDto == null) throw new TargetNotFoundException("존재하지 않는 모임입니다");
		
		//부모 파라미터 세팅
		pageVO.putParentParams("clubNo", clubNo);
		
		List<BoardListVO> boardList = boardDao.selectListWithPaging(pageVO, clubNo); //전체글
			//검색이든 목록이든 pageVO를 불러와서 한번에 처리하도록 DAO에 pageVO사용하는 메소드 생성
			//model.addAttribute("boardList", boardDao.selectList(column, keyword))
			//검색 결과 넣어주고
		List<BoardListVO> boardNoticeList = boardDao.selectListNotice(pageVO, clubNo); //공지글
		List<BoardListVO> result = new ArrayList<>(); //새로운 arrayList를 만들어서 두 리스트를 모두 추가
		result.addAll(boardNoticeList);
		result.addAll(boardList);
		
		model.addAttribute("boardList", result);
		model.addAttribute("noticeCount", boardNoticeList.size()); //공지사항 개수를 전달(배경색 칠하기 용)
		int dataCount = boardDao.count(pageVO, clubNo); //dao에 있는 count 메소드에서 검색일경우/목록일 경우 처리
		//총 게시글 수는 컨트롤러에서 설정해야함
		pageVO.setDataCount(dataCount);//pageVO에 dataCount값 설정해준다
		
		//ListRestController에서 필요한 type 변수를 직접 설정하여 화면에 전달
		model.addAttribute("type", "board");
		//부모 파라미터의 "key" 값을 parentParamsKey 라는 이름으로 화면에 전달
		model.addAttribute("parentParamsKey", "clubNo");
		//부모 파라미터의 값을 parentParams 라는 이름으로 화면에 전달
		model.addAttribute("clubNo", clubNo);
		model.addAttribute("pageVO", pageVO); //화면에 전달	
		return "/WEB-INF/views/board/list.jsp";
	}
	//게시글 목록 조회 매핑(페이지x)
//	@RequestMapping("/list")
//	public String list(Model model, @RequestParam(required=false) String column, 
//			@RequestParam(required=false) String keyword, 
//			@RequestParam int clubNo) {
//		
//		ClubDto clubDto = clubDao.selectOne(clubNo);
//		if(clubDto == null){
//		 throw new TargetNotFoundException("존재하지 않는 모임입니다");
//		}
//		
//		List<BoardListVO> boardList;
//		boolean isSearch = column != null && keyword != null;
//		if(isSearch) {
//			boardList = boardDao.selectList(column, keyword, clubNo);
//		}
//		else {	
//			boardList = boardDao.selectList(clubNo);
//		}
//			model.addAttribute("clubNo", clubNo);
//			model.addAttribute("boardList", boardList);
//		return "/WEB-INF/views/board/list.jsp";
//	}
	
	//게시글 목록 조회 매핑(selectListWithPaging 구현 후)
	
	//게시글 수정 화면 매핑
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo, Model model) {
		BoardDto boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null) throw new TargetNotFoundException("존재하지 않는 게시글"); //임시 Exception --> 추후 TargetNotfoundException + error 페이지 만들어서 수정
		model.addAttribute("boardDto", boardDto);
		return "/WEB-INF/views/board/edit.jsp";
	}
//	기존 게시글 수정 매핑
//	@PostMapping("/edit")
//	public String edit(@ModelAttribute BoardDto boardDto, @RequestParam int boardNo) {
//		boardDao.update(boardDto);
//		return "redirect:detail?boardNo="+boardDto.getBoardNo();
//	}
	//변경된 수정 처리 매핑
		@PostMapping("/edit")
		public String edit(@ModelAttribute BoardDto boardDto, @RequestParam long boardNo) {
			//기존 글 정보 조회
			BoardDto beforeDto = boardDao.selectOne(boardDto.getBoardNo());
			if(beforeDto == null) throw new TargetNotFoundException("존재하지 않는 게시글");
			
			//기존 글과 변경될 글의 이미지 번호 차이를 구하기 위한 코드
			
			//수정 전 첨부파일 번호
			Set<Integer> before = new HashSet<>(); //정렬이 필요하지 않으니까 HashSet사용
			Document beforeDocument = Jsoup.parse(beforeDto.getBoardContent()); //이전 글의 본문에 있는 내용 불러오기
			Elements beforeElements = beforeDocument.select(".custom-image");
			for(Element element : beforeElements) { //element = img 태그
				int attachmentNo = Integer.parseInt(element.attr("data-pk"));
				before.add(attachmentNo); //set에 저장
			}
			//수정 후 첨부파일 번호
			Set<Integer> after = new HashSet<>();
			Document afterDocument = Jsoup.parse(boardDto.getBoardContent());
			Elements afterElements = afterDocument.select(".custom-image");
			for(Element element : afterElements) { //element = img 태그
				int attachmentNo = Integer.parseInt(element.attr("data-pk"));
				after.add(attachmentNo); //set에 저장
			}
			
			//삭제할 첨부파일 번호 (before에만 있는 이미지 번호)
			Set<Integer> minus = new HashSet<>(before);
			minus.removeAll(after);
			
			//minus에 들어있는 번호가 '기존에 있었지만 사라진 이미지 번호'
			for(int attachmentNo : minus) {//minus에서 attachmentNo를 추출
				attachmentService.delete(attachmentNo);
			}
			
			boardDao.update(boardDto);
			
			return "redirect:detail?boardNo="+boardDto.getBoardNo();
		}
	//기존 게시글 삭제 매핑
//	@RequestMapping("/delete")
//	public String delete(@RequestParam int boardNo) {
//		BoardDto boardDto = boardDao.selectOne(boardNo);
//		if(boardDto == null) throw new TargetNotFoundException("존재하지 않는 게시글");
//		int clubNo = boardDto.getBoardClub();
//		ClubDto clubDto = clubDao.selectOne(clubNo);
//		boardDao.delete(boardNo);
//		
//		return "redirect:list?clubNo="+clubDto.getClubNo();
//	}
		//변경된 삭제(글 내부의 이미지를 지운 뒤 글 삭제)
		@RequestMapping("/delete")
		public String delete(@RequestParam int boardNo) {
		//글 정보를 불러온다
		BoardDto boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null) throw new TargetNotFoundException("존재하지 않는 글");
		int clubNo = boardDto.getBoardClub();
		ClubDto clubDto = clubDao.selectOne(clubNo);		
		//글 본문에 포함된 모든 <img>를 찾아서 해당하는 이미지의 글번호를 삭제
		//- summernote가 만든 html 형식의 글에서 원하는 항목을 탐색(Jsoup 사용)
		Document document = Jsoup.parse(boardDto.getBoardContent());
		Elements elements = document.select(".custom-image"); //<img>를 찾고
		for(Element element : elements) { //하나씩 반복하며
			//파일 번호 추출
			/*String src = element.attr("src"); //src 추출
			int equal = src.lastIndexOf("="); //= 의 위치를 찾아서
			int attachmentNo = Integer.parseInt(src.substring(equal + 1));*/
			int attachmentNo = Integer.parseInt(element.attr("data-pk"));
			attachmentService.delete(attachmentNo);
		}
		//글 삭제
		boardDao.delete(boardNo);
		
		return "redirect:list?clubNo="+clubDto.getClubNo();
		}
	
}
