package com.kh.semi.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.BuyDto;
import com.kh.semi.mapper.BuyMapper;

@Repository
public class BuyDao {

	@Autowired
	private BuyMapper buyMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void insert(BuyDto buyDto) {
		String sql = "insert into buy(buy_no, member_id) values(buy_seq.nextval, ?)";
		Object[] params = {buyDto.getMemberId()};
		jdbcTemplate.update(sql, params);
	}
	public int sequence() {
		String sql = "select buy_seq.nextval from dual ";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
}
