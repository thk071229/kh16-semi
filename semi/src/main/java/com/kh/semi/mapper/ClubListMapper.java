package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.ClubListVO;

@Component
public class ClubListMapper implements RowMapper<ClubListVO>{

	@Override
	public ClubListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		return ClubListVO.builder()
				.clubNo(rs.getInt("club_no"))
				.clubFounder(rs.getString("club_founder"))
				.clubName(rs.getString("club_name"))
				.clubRegion(rs.getInt("club_region"))
				.clubCategory(rs.getInt("club_category"))
				.regionName(rs.getString("region_name"))
				.categoryName(rs.getString("club_category"))
				.build();
	}
}
