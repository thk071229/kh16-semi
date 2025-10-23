package com.kh.semi.restcontroller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semi.dao.BoardDao;
import com.kh.semi.dao.ReplyDao;
import com.kh.semi.dto.BoardDto;
import com.kh.semi.dto.ReplyDto;
import com.kh.semi.error.NeedPermissionException;
import com.kh.semi.error.TargetNotFoundException;
import com.kh.semi.vo.ReplyListVO;
import com.kh.semi.vo.ReplyVO;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/reply")
public class ReplyRestController {
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private BoardDao boardDao;

	@PostMapping("/check")
	public ReplyVO check(@RequestParam int boardNo) {
		boolean result = replyDao.check(boardNo);
		int count = replyDao.countByBoardNo(boardNo);
		
		ReplyVO replyVO = new ReplyVO();
		
		replyVO.setReply(result); //댓글 여부
		replyVO.setCount(count); //댓글 수
		
		return replyVO;
	}
	
	@PostMapping("/list")
	public List<ReplyListVO> list(@RequestParam int replyTarget, HttpSession session){
		String loginId = (String)session.getAttribute("loginId");//null일 수 있음(=비회원)
		
		BoardDto boardDto = boardDao.selectOne(replyTarget);//게시글 정보 조회
		if(boardDto == null) throw new TargetNotFoundException("존재하지 않는 글");
		
		List<ReplyDto> list = replyDao.selectList(replyTarget);//우선 목록 조회를 하고
		
		List<ReplyListVO> result = new ArrayList<>();//비어있는 목록을 만든 뒤
		
		//하나씩 옮겨담아서 (list ---> result)
		for(ReplyDto replyDto : list) {
			//댓글 작성자인지 확인
			boolean owner = loginId != null && replyDto.getReplyWriter() != null
											&& loginId.equals(replyDto.getReplyWriter());
			//댓글 작성자가 게시글 작성자인지 확인
			boolean writer = boardDto.getBoardWriter() != null
								&& replyDto.getReplyWriter() != null
								&& boardDto.getBoardWriter().equals(replyDto.getReplyWriter());
			
			result.add(ReplyListVO.builder()
						.replyNo(replyDto.getReplyNo())
						.replyWriter(replyDto.getReplyWriter())
						.replyTarget(replyDto.getReplyTarget())
						.replyContent(replyDto.getReplyContent())
						.replyWtime(replyDto.getReplyWtime())
						.replyEtime(replyDto.getReplyEtime())
						.owner(owner)
						.writer(writer)
					.build());
		}
		
		return result;
	}
	@PostMapping("/write")
	public void write(@ModelAttribute ReplyDto replyDto, HttpSession session) {
		//시퀀스 번호 생성
		int sequence = replyDao.sequence();
		//시퀀스 번호 설정
		replyDto.setReplyNo(sequence);
		String loginId = (String) session.getAttribute("loginId");
		//댓글 작성자 설정
		replyDto.setReplyWriter(loginId);
		
		replyDao.insert(replyDto);
		
		ReplyVO replyVO = new ReplyVO();
		
		int count = replyDao.countByBoardNo(replyDto.getReplyTarget());
		
		replyVO.setReply(true);
		replyVO.setCount(count);
		
		//게시글 정보도 업데이트
		boardDao.updateBoardReply(count, replyDto.getReplyTarget());
	}
	
	@PostMapping("/edit")
	public void delete(HttpSession session, @ModelAttribute ReplyDto replyDto) {
		String loginId = (String)session.getAttribute("loginId");
		
		ReplyDto findDto = replyDao.selectOne(replyDto.getReplyNo());
		if(findDto == null) throw new TargetNotFoundException("존재하지 않는 댓글");
		
		boolean owner = loginId.equals(findDto.getReplyWriter());//본인인지 확인
		if(owner == false) throw new NeedPermissionException("본인과 관리자만 삭제할 수 있습니다");
		
		
		replyDao.update(replyDto);
	}
	
	@PostMapping("/delete")
	public void delete(HttpSession session, @RequestParam int replyNo) {
	String loginId = (String)session.getAttribute("loginId");
		
		ReplyDto replyDto = replyDao.selectOne(replyNo);
		if(replyDto == null) throw new TargetNotFoundException("존재하지 않는 댓글");
		
		boolean owner = loginId.equals(replyDto.getReplyWriter());//본인인지 확인
		if(owner == false) throw new NeedPermissionException("본인과 관리자만 삭제할 수 있습니다");
		
		replyDao.delete(replyNo);
		
		ReplyVO replyVO = new ReplyVO();
		
		//삭제 후 댓글 수 조회
		int count = replyDao.countByBoardNo(replyDto.getReplyTarget());
		
		//VO의 상태와 count값 업데이트
		replyVO.setReply(true);
		replyVO.setCount(count);
		
		//게시글 정보도 업데이트
		boardDao.updateBoardReply(count, replyDto.getReplyTarget());
		
	}
}
