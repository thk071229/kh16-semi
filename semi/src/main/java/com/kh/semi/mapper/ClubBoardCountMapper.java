package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.ClubBoardCountVO;

@Component
public class ClubBoardCountMapper implements RowMapper<ClubBoardCountVO>{

	@Override
	public ClubBoardCountVO mapRow(ResultSet rs, int rowNum) throws SQLException {

		ClubBoardCountVO clubBoardCountVO = new ClubBoardCountVO();
		clubBoardCountVO.setBoardClub(rs.getInt("board_club"));
		clubBoardCountVO.setClubName(rs.getString("club_name"));
		clubBoardCountVO.setClubProfile(rs.getObject("club_profile", Integer.class));
		clubBoardCountVO.setRegionName(rs.getString("region_name"));
		clubBoardCountVO.setCategoryName(rs.getString("category_name"));
		clubBoardCountVO.setBoardCount(rs.getInt("board_count"));
		clubBoardCountVO.setMemberCount(rs.getInt("member_count"));
		return clubBoardCountVO;
	}

}
