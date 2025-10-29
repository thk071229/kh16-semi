package com.kh.semi.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.PointUseDto;
import com.kh.semi.mapper.PointUseMapper;

@Repository
public class PointUseDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private PointUseMapper pointUseMapper;
	
	// 시퀀스 번호 생성
	public int sequence() {
		String sql ="select use_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql,int.class);
	}
	
	// 등록
	public void insert(PointUseDto pointUseDto) {
		String sql ="insert into point_use(use_no, use_id, use_type) "
						+ "values (?,?,?)";
		Object[] params = {pointUseDto.getUseNo(),pointUseDto.getUseId(),pointUseDto.getUseType(),};
	 jdbcTemplate.update(sql,params);	
	}
	
	
	
	
}
