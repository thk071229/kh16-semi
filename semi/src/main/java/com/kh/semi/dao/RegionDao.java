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
	
	//전체 지역 조회
	public List<RegionDto> selectList(){
		String sql = "select * from region order by region_depth1 asc";
		return jdbcTemplate.query(sql, regionMapper);
	}
	public RegionDto selectOne(int regionNo) {
		String sql = "select * from region where region_no=?";
		Object[] params = {regionNo};
		List<RegionDto> list = jdbcTemplate.query(sql, regionMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	//depth1목록
	public List<String> selectDepth1(){
		String sql = "select distinct region_depth1 from region "
				+ "where region_depth1 is not null "
				+ "order by region_depth1 asc";
		return jdbcTemplate.queryForList(sql, String.class);
	}
	//depth2목록
	public List<String> selectDepth2(String regionDepth1){
		String sql = "select distinct "
				+ "case "
				+ "when instr(region_depth2, ' ') > 0 "
				+ "then substr(region_depth2, 1, instr(region_depth2, ' ') - 1) "
				+ "else "
				+ "region_depth2 "
				+ "end as simplified_region_depth2 "
				+ "from region "
				+ "where region_depth1=? and region_depth2 is not null "
				+ "order by simplified_region_depth2 asc";
		Object[] params = {regionDepth1};
		return jdbcTemplate.queryForList(sql, String.class, params);
	}
	public List<RegionDto> selectByDepth1(String regionDepth1) {
		String sql = "select * from region where region_depth1=? "
				+ "order by region_depth1 asc";
		Object[] params = {regionDepth1};
		return jdbcTemplate.query(sql, regionMapper, params);
	}
	public List<RegionDto> selectByDepth2(String regionDepth2) {
		String sql = "select * from region where region_depth2=? "
				+ "order by region_depth2 asc";
		Object[] params = {regionDepth2};
		return jdbcTemplate.query(sql, regionMapper, params);
	}
		
	//이름으로 조회
	public RegionDto findByRegionName(String regionName){
	  String sql = "select * from region where region_name = ?";
	  Object[] params = {regionName};
	  List<RegionDto> list = jdbcTemplate.query(sql, regionMapper, params);
	  return list.isEmpty() ? null : list.get(0);
	}
	//번호로 조회
	public String selectNameByNo(int regionNo) {
		String sql = "select region_name from region "
						+ "where region_no = ?";
		Object[] params = {regionNo};
		return jdbcTemplate.queryForObject(sql, String.class, params);
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
