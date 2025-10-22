package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.MemberRegionListVO;

@Component
public class MemberRegionListMapper implements RowMapper<MemberRegionListVO>{

	@Override
	public MemberRegionListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberRegionListVO.builder()
					.memberId(rs.getString("member_id"))
					.regionNo(rs.getInt("region_no"))
					.regionType(rs.getString("region_type"))
					.regionName(rs.getString("region_name"))
					.regionDepth1(rs.getString("region_depth1"))
					.regionDepth2(rs.getString("region_depth2"))
				.build();
	}
	
}
