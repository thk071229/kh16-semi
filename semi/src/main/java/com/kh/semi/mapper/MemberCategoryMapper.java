package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.MemberCategoryDto;

@Component
public class MemberCategoryMapper implements RowMapper<MemberCategoryDto>{

	@Override
	public MemberCategoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberCategoryDto.builder()
					.memberId(rs.getString("member_id"))
					.categoryNo(rs.getInt("category_no"))
				.build();
	}
	
}
