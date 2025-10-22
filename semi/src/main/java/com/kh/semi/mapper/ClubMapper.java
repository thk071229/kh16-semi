package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.ClubDto;


@Component
public class ClubMapper implements RowMapper<ClubDto>{

	@Override
	public ClubDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ClubDto clubDto = new ClubDto();
		clubDto.setClubNo(rs.getInt("club_no"));
		clubDto.setClubLeader(rs.getString("club_leader"));
		clubDto.setClubName(rs.getString("club_name"));
		clubDto.setClubIntroduce(rs.getString("club_introduce"));
		clubDto.setClubRegion(rs.getInt("club_region"));
		clubDto.setClubCategory(rs.getInt("club_category"));
		clubDto.setClubOpen(rs.getString("club_open"));
		clubDto.setClubJoin(rs.getTimestamp("club_join"));
		return clubDto;
	}

}
