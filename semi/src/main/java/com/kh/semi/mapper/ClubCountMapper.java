package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.ClubCountVO;

@Component
public class ClubCountMapper implements RowMapper<ClubCountVO>{

	@Override
	public ClubCountVO mapRow(ResultSet rs, int rowNum) throws SQLException {

		ClubCountVO clubCountVO = new ClubCountVO();
		clubCountVO.setClubNo(rs.getInt("club_no"));
		clubCountVO.setClubName(rs.getString("club_name"));
		clubCountVO.setClubProfile(rs.getObject("club_profile", Integer.class));
		clubCountVO.setRegionName(rs.getString("region_name"));
		clubCountVO.setCategoryName(rs.getString("category_name"));
		clubCountVO.setClubLike(rs.getInt("club_like"));
		clubCountVO.setEventCount(rs.getInt("event_count"));
		clubCountVO.setBoardCount(rs.getInt("board_count"));
		clubCountVO.setMemberCount(rs.getInt("member_count"));
		return clubCountVO;
	}

}
