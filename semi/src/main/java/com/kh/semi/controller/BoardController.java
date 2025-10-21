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

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dto.BoardDto;
import com.kh.semi.vo.BoardListVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	private BoardDao boardDao;
	
	//게시글 등록 매핑
	@GetMapping("/write")
	public String write(@RequestParam int clubNo, Model model) {
		//clubNo 존재여부 검증 코드 추가
		//ClubDto clubDto = clubDao.selectOne(clubNo);
		//if(clubDto == null){
		// throw new RuntimeException("존재하지 않는 모임입니다");
		//}
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
		
		return "redirect:detail?boardNo="+boardNo;
	}
	
	//게시글 상세 조회 매핑
	@RequestMapping("/detail")
	public String detail(@RequestParam int boardNo, Model model) {
		return "/WEB-INF/views/board/detail.jsp";
	}
	
	//게시글 목록 조회 매핑(페이지x)
	@RequestMapping("/list")
	public String list(Model model, @RequestParam(required=false) String column, 
			@RequestParam(required=false) String keyword, 
			@RequestParam int clubNo) {
		List<BoardListVO> boardList;
		boolean isSearch = column != null && keyword != null;
		if(isSearch) {
			boardList = boardDao.selectList(column, keyword, clubNo);
		}
		else {	
			boardList = boardDao.selectList(clubNo);
		}
			model.addAttribute("boardList", boardList);
		return "/WEB-INF/views/board/list.jsp";
	}
	
	//게시글 목록 조회 매핑(selectListWithPaging 구현 후)
	
	//게시글 수정 매핑
	@GetMapping("/edit")
	public String edit(@RequestParam int boardNo, Model model) {
		BoardDto boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null) throw new RuntimeException("존재하지 않는 게시글"); //임시 Exception --> 추후 TargetNotfoundException + error 페이지 만들어서 수정
		return "/WEB-INF/views/board/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute BoardDto boardDto, @RequestParam int boardNo) {
		return "redirect:detail?boardNo="+boardDto.getBoardNo();
	}
	
	//게시글 삭제 매핑
	@RequestMapping("/delete")
	public String delete(@RequestParam int boardNo) {
		BoardDto boardDto = boardDao.selectOne(boardNo);
		if(boardDto == null) throw new RuntimeException("존재하지 않는 게시글");
		boardDao.delete(boardNo);
		return "redirect:list";
	}
}
