package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.MemberClubListVO;

@Component
public class MemberClubListMapper implements RowMapper<MemberClubListVO>{

	@Override
	public MemberClubListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberClubListVO.builder()
					.memberId(rs.getString("member_id"))
					.clubNo(rs.getInt("club_no"))
					.clubName(rs.getString("club_name"))
					.clubCategory(rs.getInt("club_category"))
					.clubRegion(rs.getInt("club_region"))
					.categoryName(rs.getString("category_name"))
					.regionName(rs.getString("region_name"))
				.build();
	}
	
}
