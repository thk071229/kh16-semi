package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class EventAttendeeDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	// 등록
	public void insert(String memberId, int eventNo) {
		String sql = "insert into event_attendee(member_id, event_no) "
					+ "values(?,?)";
		Object[] params = {memberId, eventNo};
		jdbcTemplate.update(sql,params);
	}
	
	//검사
	public boolean check(String memberId, int eventNo) {
		if(memberId == null) return false;
		String sql = "select count(*) from event_attendee where member_id=? and event_no=?";
		Object[] params = {memberId, eventNo};
		int count = jdbcTemplate.queryForObject(sql, int.class, params);
		return count>0;
	}
	
	//삭제
	public boolean delete(String memberId, int eventNo) {
		String sql = "delete event_attendee where member_id=? and event_no=?";
		Object[] params = {memberId, eventNo};
		return jdbcTemplate.update(sql,params)>0;
	}
	
	// 정모에 참여하는 참여자 수
	public int countByEventNo(int eventNo) {
		String sql = "select count(*) from event_attendee where event_no=?";
		Object[] params = {eventNo};
		return jdbcTemplate.queryForObject(sql, int.class, params);
	}
	
	// 회원번호로 참여 정모 찾기
	public List<Integer> selectListByMemberId(String memberId){
		String sql ="select event_no from event_attendee where member_id=?";
		Object[] params ={memberId};
		return jdbcTemplate.queryForList(sql,int.class, params);
	}
}
