package com.kh.semi.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.mapper.StatMapper;
import com.kh.semi.vo.StatVO;

//차트 구현을 위한 statDao(title, value로 별칭을 붙여서 조회)
@Repository
public class StatDao {
	
	@Autowired
	private StatMapper statMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	//ChartSet1-percent
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
	//지역별 정모 현황(종료된 정모 기준)
	public List<StatVO> countByEventRegion(){
		String sql = "select region_name title, count(*) value "
				+ "from ("
				+ "select * from event_list "
				+ "where event_date < sysdate "
				+ ") as end_events "
				+ "group by region_name order by max(event_date) desc, value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	
	// 카테고리별 회원 현황
	public List<StatVO> countByMemberCategory() {
	    String sql = "select category_name title, count(distinct member_id) value " 
	    		+ "from member_category_list " 
	    		+ "group by category_name " 
	    		+ "order by value desc, title asc";
	    return jdbcTemplate.query(sql, statMapper);
	}

	// 지역별 회원 현황(나중에 member_region_list에 데이터 생성되면 출력됨)
	public List<StatVO> countByMemberRegion() {
	    String sql = "select region_name title, count(*) value "
	                 + "from ( "
	                 + "select member_id, region_name "
	                 + "from member_region_list "
	                 + "group by member_id, region_name "
	                 + ") t "
	                 + "group by region_name "
	                 + "order by value desc, title asc";

	    return jdbcTemplate.query(sql, statMapper);
	}

	// 회원 성비
	public List<StatVO> memberGenderRatio() {
	    String sql = "select member_gender title, count(*) value " 
	    			+ "from member " 
	    			+ "group by member_gender";
	    return jdbcTemplate.query(sql, statMapper);
	}

	// 회원 나이 비율 (2000년 기준 업/다운)
	//조건부 조회 위해 case사용
	public List<StatVO> memberAgeRatio() {
	    String sql = "select case when extract(year from member_birth) <= 2000 "
	    			+ "then '2000년 이전' " 
	    			+ "else '2000년 이후' end title, "
	                + "count(*) value from member "
	                + "group by case when extract(year from member_birth) <= 2000 "
	                + "then '2000년 이전' else '2000년 이후' end";

	    return jdbcTemplate.query(sql, statMapper);
	}

	//ChartSet2-ranking
	//인기 모임(회원 수 기준)
	public List<StatVO> clubRanking(){
		String sql = "select club_name title, "
				+ "member_count value from club_list "
				+ "group by club_name, member_count "
				+ "order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	//활동이 활발한 모임(정모 수 기준)
	public List<StatVO> eventRanking(){
		String sql = "select club_name title, event_count value "
				+ "from ("
				+ "select * from club_count "
				+ "where event_count > 0"
				+ ") "
				+ "group by club_name, event_count "
				+ "order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	//활동이 활발한 모임(작성 게시글 수 기준)
	public List<StatVO> boardRanking(){
		String sql = "select club_name title, board_count value "
				+ "from ("
				+ "select * from club_count "
				+ "where board_count > 0"
				+ ") "
				+ "group by club_name, board_count "
				+ "order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	
	//활동이 활발한 회원(작성 게시글 수 + 댓글 수 기준)
	public List<StatVO> memberRanking(){
		String sql = "select member title, count(*) value "
				+ "from ("
				+ "select reply_writer as member "
				+ "from reply "
				+ "union all "
				+ "select board_writer as member "
				+ "from board_list "
				+ "union all "
				+ "select member_id as member "
				+ "from event_attendee"
				+ ") t "
				+ "group by member "
				+ "order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	//인기 지역 랭킹
	public List<StatVO> regionRanking(){
		String sql = "select region_depth2 title, "
				+ "count(*) value from ( "
				+ "select region_depth2 "
				+ "from club_count "
				+ "union all "
				+ "select region_depth2 from member_region_list"
				+ ") "
				+ "where region_depth2 is not null "
				+ "group by region_depth2 order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	//인기 카테고리 랭킹
	public List<StatVO> categoryRanking(){
		String sql = "select category_name title, "
				+ "count(*) value from "
				+ "(select category_name "
				+ "from club_count union all "
				+ "select category_name "
				+ "from member_category_list) "
				+ "where category_name is not null "
				+ "group by category_name "
				+ "order by value desc, title asc";
		return jdbcTemplate.query(sql, statMapper);
	}
	
	
}