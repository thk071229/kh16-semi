package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.mapper.ClubBoardCountMapper;
import com.kh.semi.mapper.ClubEventCountMapper;
import com.kh.semi.vo.ClubBoardCountVO;
import com.kh.semi.vo.ClubEventCountVO;

@Repository
public class CountDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ClubEventCountMapper clubEventCountMapper;
	@Autowired
	private ClubBoardCountMapper clubBoardCountMapper;
	
	// 홈화면 조회 : 정모 많이한 클럽
	public List<ClubEventCountVO> selectListWithEventCount(){
		String sql = "select * from club_event_count order by event_count desc";
		return jdbcTemplate.query(sql, clubEventCountMapper);
	}
	// 홈화면 조회 : 게시글 많이 쓴 클럽
	public List<ClubBoardCountVO> selectListWithBoardCount(){
		String sql = "select * from club_board_count order by board_count desc";
		return jdbcTemplate.query(sql, clubBoardCountMapper);
	}
	
}
