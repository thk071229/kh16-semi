package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ReplyDto;
import com.kh.semi.mapper.ReplyMapper;

@Repository
public class ReplyDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ReplyMapper replyMapper;
	
	//게시글 별 댓글 존재 유무 판단
	public boolean check(int boardNo) {
		//count 조회를 통해서 좋아요 존재 유무 판단
		String sql = "select count(*) from reply "
				+ "where reply_target = ?";
		Object[] params = {boardNo};
		int count = jdbcTemplate.queryForObject(sql, int.class, params);
		//count가 1 이상이면 좋아요 존재(true), 아니면 false
		return count > 0;
	}
	
	//댓글은 전체가 아니라 회원 또는 글 별로 조회
	//작성자별 댓글 목록
	public List<ReplyDto> selectList(String replyWriter) {
		String sql = "select * from reply "
				+ "where reply_writer = ? order by reply_no desc";
		Object[] params = {replyWriter};
		return jdbcTemplate.query(sql, replyMapper, params);
	}
	
	//게시글 별 댓글 목록
	public List<ReplyDto> selectList(int replyTarget) {
		String sql = "select * from reply "
				+ "where reply_target = ? order by reply_no asc";
		Object[] params = {replyTarget};
		return jdbcTemplate.query(sql, replyMapper, params);
	}
	
	//댓글 삭제
	public boolean delete(int replyNo) {
		String sql = "delete from reply where reply_no = ?";
		Object[] params = {replyNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	//시퀀스 생성
	public int sequence() {
		String sql = "select reply_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	//댓글 등록
	public void insert(ReplyDto replyDto) {
		String sql = "insert into reply(reply_no, reply_writer, reply_target, reply_content) "
						+ "values(?, ?, ?, ?)";
		Object[] params = {
				replyDto.getReplyNo(), replyDto.getReplyWriter(),
				replyDto.getReplyTarget(), replyDto.getReplyContent()
		};
		jdbcTemplate.update(sql, params);
	}
	
	//댓글 수정
	public boolean update(ReplyDto replyDto) {
		String sql = "update reply "
							+ "set reply_content = ? , reply_etime = systimestamp "
							+ "where reply_no = ?";
		Object[] params = {replyDto.getReplyContent(), replyDto.getReplyNo()};
		return jdbcTemplate.update(sql, params) > 0;
	}
	
	//댓글 상세
	public ReplyDto selectOne(int replyNo) {
		String sql = "select * from reply where reply_no = ?";
		Object[] params = {replyNo};
		List<ReplyDto> list = jdbcTemplate.query(sql, replyMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//게시글에 담긴 댓글 수 카운트
	public int countByBoardNo(int boardNo) {
		String sql = "select count(*) from reply "
				+ "where reply_target = ?";
		Object[] params = {boardNo};
		return jdbcTemplate.queryForObject(sql, int.class, params);
	}
	
	//특정 회원이 댓글을 남긴 게시글을 조회하기 위한 list
	public List<Integer> selectReplyListByMemberId(String memberId){
		String sql = "select reply_target from reply where reply_writer = ?";
		Object[] params = {memberId};
		return jdbcTemplate.queryForList(sql, int.class, params);
	}
}
