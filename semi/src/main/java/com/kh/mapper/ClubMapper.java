package com.kh.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.dto.ClubDto;

@Component
public class ClubMapper implements RowMapper<ClubDto>{

	@Override
	public ClubDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ClubDto clubDto = new ClubDto();
		clubDto.setClubNo(rs.getInt("club_no"));
		clubDto.setClubName(rs.getString("club_name"));
		clubDto.setClubIntroduce(rs.getString("club_introduce"));
		clubDto.setClubRegion(rs.getInt("club_region"));
		clubDto.setClubCategory(rs.getInt("club_category"));
		clubDto.setClubOpen(rs.getString("club_open"));
		clubDto.setClubJoin(rs.getTimestamp("club_join"));
		return clubDto;
	}

}
