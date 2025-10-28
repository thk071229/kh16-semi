package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.mapper.ClubCountMapper;
import com.kh.semi.vo.ClubCountVO;

@Repository
public class CountDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ClubCountMapper clubCountMapper;

	// 홈화면 조회 : 정모 많이한 클럽
	public List<ClubCountVO> selectListWithEventCount(){
		String sql = "select * from club_count where event_count > 0 "
				+"order by event_count desc";
		return jdbcTemplate.query(sql, clubCountMapper);
	}
	// 홈화면 조회 : 게시글 많이 쓴 클럽
	public List<ClubCountVO> selectListWithBoardCount(){
		String sql = "select * from club_count where board_count > 0 "
				+"order by board_count desc";
		return jdbcTemplate.query(sql, clubCountMapper);
	}
	
	// 홈화면 조회 : 좋아요 많이 받은 클럽
	public List<ClubCountVO> selectListWithLikeCount(){
		String sql = "select * from club_count where club_like > 0 "
						+"order by club_like desc";
		return jdbcTemplate.query(sql, clubCountMapper);
	}
	
	//페이징 추가
	
}
