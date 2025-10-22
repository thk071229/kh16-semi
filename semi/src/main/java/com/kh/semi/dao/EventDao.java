package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.EventDto;
import com.kh.semi.mapper.EventMapper;

@Repository
public class EventDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private EventMapper eventMapper;

	
	// 시퀀스 번호 생성
	public int sequence() {
		String sql ="select event_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql,int.class);
	}
	
	// 등록
	public void insert(EventDto eventDto) {
		String sql = "insert into event "
				+ "(event_no, event_club, event_writer,event_title,event_content,event_date, event_max_people, "
				+ "event_address, event_region_x,event_region_y) "
				+ "values(?,?,?,?,?,?,?,?,?,?)";
		Object[] params = {
						 eventDto.getEventNo()
						,eventDto.getEventClub()
						,eventDto.getEventWriter()
						,eventDto.getEventTitle()
						,eventDto.getEventContent()
						,eventDto.getEventDate()
						,eventDto.getEventMaxPeople()
						,eventDto.getEventAddress()
						,eventDto.getEventRegionX()
						,eventDto.getEventRegionY()
					};
		jdbcTemplate.update(sql,params);
	}
	
	// 조회 (기본)
	public List<EventDto> selectList(){
		String sql = "select * from event order by event_date desc";
		return jdbcTemplate.query(sql, eventMapper);
	}
	
	// 조회 (int clubNo)
	public List<EventDto> selectList(int clubNo){
		String sql = "select * from event where event_club = ? "
		           		+ "order by event_date desc";
		Object[] params= {clubNo};
		return jdbcTemplate.query(sql, eventMapper, params);
	}
	
	
	/// 조회 - 진행중(현재시각전)
		public List<EventDto> selectListBefore(int clubNo){
			String sql = "select * from event"
							+" where event_club=? and event_date>sysdate"
							+" order by event_date desc";
			Object[] params= {clubNo};
			return jdbcTemplate.query(sql, eventMapper, params);
		}
	/// 조회 - 완료(현재시각후)
		public List<EventDto> selectListAfter(int clubNo){
			String sql = "select * from event"
							+" where event_club=? and event_date<sysdate"
							+" order by event_date desc";
			Object[] params= {clubNo};
			return jdbcTemplate.query(sql, eventMapper, params);
		}
	
	
	// 상세조회
	public EventDto selectOne(int eventNo) {
		String sql ="select * from event where event_no=?";
		Object[] params = {eventNo};
		List<EventDto> list = jdbcTemplate.query(sql, eventMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	
	// 삭제
	public boolean delete(int eventNo) {
		String sql = "delete event where event_no=?";
		Object[] params = {eventNo};
		return jdbcTemplate.update(sql,params)>0;
	}
	
	//수정
	public boolean update(EventDto eventDto) {
		String sql = "update event "
						+ "set event_title=?, event_content=?, event_date=?, event_max_people=?, "
						+ "event_address=?, event_region_x=?, event_region_y=?, event_etime=systimestamp "
						+ "where event_no=?";
		Object[] params = {
				eventDto.getEventTitle(), eventDto.getEventContent(), eventDto.getEventDate(),eventDto.getEventMaxPeople(),
				eventDto.getEventAddress(),eventDto.getEventRegionX(),eventDto.getEventRegionY(),
				eventDto.getEventNo()};
		return jdbcTemplate.update(sql,params)>0;
		}
			
	}
