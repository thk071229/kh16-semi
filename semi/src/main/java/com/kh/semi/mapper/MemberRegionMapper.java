package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.MemberRegionDto;

@Component
public class MemberRegionMapper implements RowMapper<MemberRegionDto>{

	@Override
	public MemberRegionDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberRegionDto.builder()
					.memberId(rs.getString("member_id"))
					.regionNo(rs.getInt("region_no"))
					.regionType(rs.getString("region_type"))
				.build();
	}
	
}
