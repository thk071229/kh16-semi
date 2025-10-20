package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.EventDto;

@Component
public class EventMapper implements RowMapper<EventDto>{

	@Override
	public EventDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		EventDto eventDto = new EventDto();
		eventDto.setEventNo(rs.getInt("event_no"));
		eventDto.setEventClub(rs.getInt("event_club"));
		eventDto.setEventWriter(rs.getString("event_writer"));
		eventDto.setEventTitle(rs.getString("event_title"));
		eventDto.setEventContent(rs.getString("event_content"));
		eventDto.setEventRegionX(rs.getDouble("event_region_x"));
		eventDto.setEventRegionY(rs.getDouble("event_region_y"));
		eventDto.setEventWtime(rs.getTimestamp("event_wtime"));
		eventDto.setEventEtime(rs.getTimestamp("event_etime"));

		return eventDto;
	}



}
