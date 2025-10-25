package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.mapper.BoardListMapper;
import com.kh.semi.mapper.ClubListMapper;
import com.kh.semi.mapper.EventListMapper;
import com.kh.semi.mapper.MemberCategoryListMapper;
import com.kh.semi.mapper.MemberClubListMapper;
import com.kh.semi.mapper.StatMapper;
import com.kh.semi.vo.StatVO;

//차트 구현을 위한 statDao(title, value로 별칭을 붙여서 조회)
@Repository
public class StatDao {
	
	@Autowired
	private StatMapper statMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//카테고리별 모임 현황
	public List<StatVO> countByClubCategory() {
		String sql = "select category_name title, count(*) value from club_list "
				+ "group by category_name order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	
	//지역별 모임 현황
	public List<StatVO> countByClubRegion(){
		String sql = "select region_name title, count(*) value from club_list "
				+ "group by region_name order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	
	//카테고리별 정모 현황(종료된 정모 기준)
	public List<StatVO> countByEventCategory(){	
		String sql = "select category_name title, count(*) value "
				+ "from ("
				+ "select * from event_list "
				+ "where event_date < sysdate "
				+ ") as end_events "
				+ "group by category_name order by max(event_date) desc, value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	
	public List<StatVO> countByEventRegion(){
		String sql = "select region_name title, count(*) value "
				+ "from ("
				+ "select * from event_list "
				+ "where event_date < sysdate "
				+ ") as end_events "
				+ "group by region_name order by max(event_date) desc, value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
}