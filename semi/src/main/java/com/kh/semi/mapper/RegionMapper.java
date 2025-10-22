package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.RegionDto;

@Component
public class RegionMapper implements RowMapper<RegionDto>{

	@Override
	public RegionDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return RegionDto.builder()
				.regionNo(rs.getInt("region_no"))
				.regionName(rs.getString("region_name"))
				.regionDepth1(rs.getString("region_depth1"))
				.regionDepth2(rs.getString("region_depth2"))
				.build();
	}

}
