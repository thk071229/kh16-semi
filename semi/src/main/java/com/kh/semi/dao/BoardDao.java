package com.kh.semi.dao;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.BoardDto;
import com.kh.semi.mapper.BoardListMapper;
import com.kh.semi.mapper.BoardMapper;
import com.kh.semi.vo.BoardListVO;
import com.kh.semi.vo.PageVO;

@Repository
public class BoardDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private BoardListMapper boardListMapper;
	
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
	
	//게시글 전체 조회 + 검색(페이지 사용) - PageVO 생성 후 if 문으로 구현
	public List<BoardListVO> selectListWithPaging(PageVO pageVO, int clubNo){
		if(pageVO.isList()) {//목록이라면
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from board_list where board_club = ? "
					+ "order by board_no desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			
			Object[] params = {clubNo, pageVO.getBegin(), pageVO.getEnd()};
			//모듈화 전처럼 begin, end 변수를 만들어서 사용하는게 아니라
			//pageVO에서 getter 메소드를 만들어서 불러온다
			return jdbcTemplate.query(sql, boardListMapper, params);
		}
		else {//검색이라면 
				//- pageVO를 사용하므로 직접 컬럼, 키워드 변수를 만들지말고 VO에서 불러온다
			Set<String> allowList = Set.of("board_title", "board_writer");
			if(!allowList.contains(pageVO.getColumn())) return List.of();
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from board_list "
					+ "where instr(#1, ?) > 0 and board_club = ? "
					+ "order by #1 asc, board_no desc"
					+ ")TMP "
					+ ")where rn between ? and ?";
			
			
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] params = {pageVO.getKeyword(), clubNo, pageVO.getBegin(), pageVO.getEnd()};
			return jdbcTemplate.query(sql, boardListMapper, params);
		}
	}
	
	//공지사항 조회 메소드
	public List<BoardListVO> selectListNotice(PageVO pageVO, int clubNo){
		if(pageVO.isList()) {
			String sql = "select *from board_list where board_notice = 'Y' and board_club = ?"
					+ "order by board_no desc";
			Object[] params = {clubNo};
		return jdbcTemplate.query(sql, boardListMapper, params);
		}
		else {
			String sql = "select * from board_list where board_notice = 'Y' "
					+ "and instr (#1, ?) > 0 and board_club = ?"
					+ "order by board_no desc";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] params = {pageVO.getKeyword(), clubNo};
		return jdbcTemplate.query(sql, boardListMapper, params);	
		}
	}
	
	//게시글 카운트 메소드(클럽 내에서 페이지별로 보여주기 위함)
	public int count(PageVO pageVO, int clubNo) { //if문을 사용해서 합친다 - int로 반환
		// 컨트롤러에서 pageVO만을 전달해서 불러올수있도록
	if(pageVO.isList()) { //목록일 경우
	String sql = "select count(*) from board_list where board_club = ?";
	Object[] params = {clubNo};
	return jdbcTemplate.queryForObject(sql, int.class, params);
	}
	else { //검색일 경우
	String sql = "select count(*) from board_list where instr (#1, ?) > 0 and board_club = ?";
	sql = sql.replace("#1", pageVO.getColumn());
	Object[] params = {pageVO.getKeyword(), clubNo};
	return jdbcTemplate.queryForObject(sql, int.class, params);
	}
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
	
	//게시글 좋아요 수 갱신
	public boolean updateBoardLike(int boardLike, int boardNo) {
		String sql = "update board set board_like = ? where board_no = ?";
		Object[] params = {boardLike, boardNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	public boolean updateBoardLike(int boardNo) {
		String sql = "update board "
				+ "set board_like = "
				+ "(select count(*) "
				+ "from board_like where board_no =?) "
				+ "where board_no = ?";
		Object[] params = {boardNo, boardNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	
}
