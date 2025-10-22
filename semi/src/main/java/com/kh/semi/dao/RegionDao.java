package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.RegionDto;
import com.kh.semi.mapper.RegionMapper;

@Repository
public class RegionDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private RegionMapper regionMapper;
	
	//이름으로 조회
	public RegionDto findByRegionName(String regionName){
	  String sql = "select * from region where region_name = ?";
	  Object[] params = {regionName};
	  List<RegionDto> list = jdbcTemplate.query(sql, regionMapper, params);
	  return list.isEmpty() ? null : list.get(0);
	}

	// 시퀀스 생성
	public int sequence(){
	  String sql = "select region_seq.nextval from dual";
	  return jdbcTemplate.queryForObject(sql, int.class);
	}
	  
	//새 지역 생성
	public void insert(RegionDto regionDto){
	  String sql = "insert into region(region_no, region_name, region_depth1, region_depth2) values(?,?,?,?)";
	  Object[] params = {regionDto.getRegionNo(), regionDto.getRegionName(), 
			  							regionDto.getRegionDepth1(), regionDto.getRegionDepth2()};
	  jdbcTemplate.update(sql, params);
	}
}
