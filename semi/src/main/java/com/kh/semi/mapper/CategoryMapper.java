package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.CategoryDto;

@Component
public class CategoryMapper implements RowMapper<CategoryDto>{

	@Override
	public CategoryDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return CategoryDto.builder()
					.categoryNo(rs.getInt("category_no"))
					.categoryName(rs.getString("category_name"))
				.build();
	}
	
}
