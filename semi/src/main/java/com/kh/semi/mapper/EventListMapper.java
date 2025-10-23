package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.EventListVO;

@Component
public class EventListMapper implements RowMapper<EventListVO>{

	@Override
	public EventListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		EventListVO eventListVO = new EventListVO();
		eventListVO.setEventNo(rs.getInt("event_no"));
		eventListVO.setEventClub(rs.getInt("event_club"));
		eventListVO.setEventWriter(rs.getString("event_writer"));
		eventListVO.setEventTitle(rs.getString("event_title"));
		eventListVO.setEventMaxPeople(rs.getInt("event_max_people"));
		eventListVO.setEventAddress(rs.getString("event_address"));
		eventListVO.setEventDate(rs.getTimestamp("event_date"));
		// From club_list Table
		eventListVO.setClubName(rs.getString("club_name"));
		eventListVO.setClubRegion(rs.getInt("club_region"));
		eventListVO.setRegionName(rs.getString("region_name"));
		eventListVO.setClubCategory(rs.getInt("club_category"));
		eventListVO.setCategoryName(rs.getString("club_category"));
		// From member Table
		eventListVO.setMemberNickname(rs.getString("member_nickname"));
		
		return eventListVO;
	}



}
