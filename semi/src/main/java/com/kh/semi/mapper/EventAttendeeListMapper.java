package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.EventAttendeeListVO;

@Component
public class EventAttendeeListMapper implements RowMapper<EventAttendeeListVO>{

	@Override
	public EventAttendeeListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		EventAttendeeListVO eventAttendeeListVO = new EventAttendeeListVO();
		eventAttendeeListVO.setEventNo(rs.getInt("event_no"));
		eventAttendeeListVO.setEventClub(rs.getInt("event_club"));
		eventAttendeeListVO.setEventTitle(rs.getString("event_title"));
		eventAttendeeListVO.setEventAttend(rs.getInt("event_attend"));
		eventAttendeeListVO.setEventMaxPeople(rs.getInt("event_max_people"));
		eventAttendeeListVO.setEventAddress(rs.getString("event_address"));
		eventAttendeeListVO.setEventDate(rs.getTimestamp("event_date"));
		// From club_list Table
		eventAttendeeListVO.setClubName(rs.getString("club_name"));
		eventAttendeeListVO.setClubRegion(rs.getInt("club_region"));
		eventAttendeeListVO.setRegionName(rs.getString("region_name"));
		eventAttendeeListVO.setClubCategory(rs.getInt("club_category"));
		eventAttendeeListVO.setCategoryName(rs.getString("club_category"));
		// From event_attendee Table
		eventAttendeeListVO.setMemberId(rs.getString("member_id"));

		
		return eventAttendeeListVO;
	}



}
