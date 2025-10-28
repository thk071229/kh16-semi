package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.ClubEventCountVO;

@Component
public class ClubEventCountMapper implements RowMapper<ClubEventCountVO>{

	@Override
	public ClubEventCountVO mapRow(ResultSet rs, int rowNum) throws SQLException {

		ClubEventCountVO clubEventCountVO = new ClubEventCountVO();
		clubEventCountVO.setEventClub(rs.getInt("event_club"));
		clubEventCountVO.setClubName(rs.getString("club_name"));
		clubEventCountVO.setClubProfile(rs.getObject("club_profile", Integer.class));
		clubEventCountVO.setRegionName(rs.getString("region_name"));
		clubEventCountVO.setCategoryName(rs.getString("category_name"));
		clubEventCountVO.setEventCount(rs.getInt("event_count"));
		clubEventCountVO.setMemberCount(rs.getInt("member_count"));
		return clubEventCountVO;
	}

}
