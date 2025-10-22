package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.MemberCategoryListVO;

@Component
public class MemberCategoryListMapper implements RowMapper<MemberCategoryListVO>{

	@Override
	public MemberCategoryListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberCategoryListVO.builder()
					.memberId(rs.getString("member_id"))
					.categoryNo(rs.getInt("category_no"))
					.categoryName(rs.getString("category_name"))
				.build();
	}
	
}
