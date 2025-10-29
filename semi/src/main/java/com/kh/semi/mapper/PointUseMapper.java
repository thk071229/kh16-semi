package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.PointUseDto;

@Component
public class PointUseMapper implements RowMapper<PointUseDto>{

	@Override
	public PointUseDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return PointUseDto.builder()
				.useNo(rs.getInt("use_no"))
				.useId(rs.getString("use_id"))
				.useType(rs.getString("use_type"))
				.useTime(rs.getTimestamp("use_time"))
				.build();
	}

}
