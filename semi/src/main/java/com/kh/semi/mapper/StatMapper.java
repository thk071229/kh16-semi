package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.StatVO;

@Component
public class StatMapper implements RowMapper<StatVO>{

	@Override
	public StatVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			StatVO statVO = new StatVO();
			statVO.setTitle(rs.getString("title"));
			statVO.setValue(rs.getDouble("value"));
		return statVO;
	}
	
}
