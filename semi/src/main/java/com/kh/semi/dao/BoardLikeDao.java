package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardLikeDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//좋아요 등록
	public void insert(String memberId, int boardNo) {
		String sql = "insert into board_like (member_id, board_no) "
				+ "values (?, ?)";
		Object[] params = {memberId, boardNo};
		jdbcTemplate.update(sql, params);
	}
	
	//검사
	public boolean check(String memberId, int boardNo) {
		//memberId가 없으면 검사x
		if(memberId == null) return false;
		//count 조회를 통해서 좋아요 존재 유무 판단
		String sql = "select count(*) from board_like "
				+ "where member_id = ? and board_no = ?";
		Object[] params = {memberId, boardNo};
		int count = jdbcTemplate.queryForObject(sql, int.class, params);
		//count가 1 이상이면 좋아요 존재(true), 아니면 false
		return count > 0;
	}
	//좋아요 삭제(취소)
	public boolean delete(String memberId, int boardNo) {
		String sql = "delete board_like "
				+ "where member_id = ? and board_no = ?";
		Object[] params = {memberId, boardNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	//게시글이 받은 좋아요 개수
	public int countByBoardNo(int boardNo) {
		String sql = "select count(*) from board_like "
				+ "where board_no = ?";
		Object[] params = {boardNo};
		return jdbcTemplate.queryForObject(sql, int.class, params);
	}
	//특정 멤버가 좋아요 한 게시글을 조회하기 위한 list
	public List<Integer> selectLikeListByMemberId(String memberId){
		String sql = "select board_no from board_like where member_id = ?";
		Object[] params = {memberId};
		return jdbcTemplate.queryForList(sql, int.class, params);
	}
}
