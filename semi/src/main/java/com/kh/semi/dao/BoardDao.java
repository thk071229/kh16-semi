package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.BoardDto;
import com.kh.semi.mapper.BoardMapper;

@Repository
public class BoardDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private BoardMapper boardMapper;
	
	//시퀀스 생성
	public int sequence() {
		String sql = "select board_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//게시물 등록
	public void insert(BoardDto boardDto) {
		String sql = "insert into board (board_no, board_club, board_writer, "
				+ "board_notice, board_title, board_content, board_wtime) "
				+ "values (?, ?, ?, ?, ?, ?, systimestamp)";
		Object[] params = {boardDto.getBoardNo(),boardDto.getBoardClub(), 
				boardDto.getBoardWriter(), boardDto.getBoardNotice(), 
				boardDto.getBoardTitle(), boardDto.getBoardContent()};
		jdbcTemplate.update(sql, params);
	}
	
	//게시글 상세 조회 구문
	public BoardDto selectOne(int boardNo) {
		String sql = "select * from board where board_no = ?";
		Object[] params = {boardNo};
		List<BoardDto> list = jdbcTemplate.query(sql, boardMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//게시글 전체 조회 + 검색(페이지 사용) - PageVO, BoardListVO(board_list view 생성), BoardListMapper 생성 후 구현
//	public List<BoardListVO> selectListWithPaging(PageVO pageVO){
//		String sql = "select board_no, board_title, board_writer, "
//				+ "board_notice, board_wtime, board_etime, board_read "
//				+ "from board order by ";
//	}
	
	//게시글 전체 조회(임시)
	public List<BoardDto> selectList(int clubNo) {
		String sql = "select * from board where board_club = ? order by board_no desc";
		Object[] params = {clubNo};
		return jdbcTemplate.query(sql, boardMapper, params);
	}
	//게시글 수정
	public boolean update(BoardDto boardDto) {
		String sql = "update board set board_title = ?, board_content = ?, "
				+ "board_notice = ?, board_etime = systimestamp where board_no = ?";
		Object[] params = {boardDto.getBoardTitle(), boardDto.getBoardContent(),
				boardDto.getBoardNotice(), boardDto.getBoardNo()};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	//게시글 삭제
	public boolean delete(int boardNo) {
		String sql = "delete board where board_no = ?";
		Object[] params = {boardNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	//게시글 좋아요
	//게시글 좋아요 조회
	//공지사항 조회
	//게시글 수 조회
	
}
