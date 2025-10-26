package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.ClubLikeListVO;

@Component
public class ClubLikeListMapper implements RowMapper<ClubLikeListVO>{

	@Override
	public ClubLikeListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ClubLikeListVO.builder()
				.clubNo(rs.getInt("club_no"))
				.clubName(rs.getString("club_name"))
				.clubIntroduce(rs.getString("club_introduce"))
				.clubProfile(rs.getObject("club_profile", Integer.class))
				.categoryNo(rs.getInt("category_no"))
				.categoryName(rs.getString("category_name"))
				.regionNo(rs.getInt("region_no"))
				.regionName(rs.getString("region_name"))
				.memberId(rs.getString("member_id"))
				.build();
	}

}
