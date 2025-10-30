package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.BuyDto;

@Component
public class BuyMapper implements RowMapper<BuyDto>{

	@Override
	public BuyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return BuyDto.builder()
				.buyNo(rs.getInt("buy_no"))
				.memberId(rs.getString("member_id"))
				.buyTime(rs.getTimestamp("buy_time"))
				.build();
	}

}
