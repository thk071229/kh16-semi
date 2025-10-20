package com.kh.semi.dao;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ClubDto;
import com.kh.semi.mapper.ClubMapper;

@Repository
public class ClubDao {


	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ClubMapper clubMapper;

	//등록
	public int sequence() {
		String sql = "select club_seq.nextval from dual ";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	public void insert(ClubDto clubDto) {
		String sql = "insert into club(club_no, club_founder, club_name, club_introduce, club_open) values(?,?,?,?,?)";
		Object[] params = {clubDto.getClubNo(), clubDto.getClubFounder(), clubDto.getClubName(), clubDto.getClubIntroduce(), clubDto.getClubOpen()};
		jdbcTemplate.update(sql, params);
	}
	//삭제
	public boolean delete(int clubNo) {
		String sql = "delete club where club_no = ?";
		Object[] params = {clubNo};
		return jdbcTemplate.update(sql, params) > 0;
	}
	//수정
	public boolean update(ClubDto clubDto) {
		String sql = "update club set club_founder = ?, club_name = ?, club_introduce = ?, club_open = ? where club_no = ?";
		Object[] params = {clubDto.getClubFounder(), clubDto.getClubName(), clubDto.getClubIntroduce(), clubDto.getClubOpen(), clubDto.getClubNo()};
		return jdbcTemplate.update(sql, params) > 0;
	}
	//상세
	public ClubDto selectOne(int clubNo) {
		String sql = "select * from club where club_no = ?";
		Object[] params = {clubNo};
		List<ClubDto> list = jdbcTemplate.query(sql, clubMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
	//목록(전체)
	public List<ClubDto> selectList() {
		String sql = "select * from club order by club_no desc";
		return jdbcTemplate.query(sql, clubMapper);
	}
	
	public List<ClubDto> selectList(String column, String keyword) {
		String sql = "select * from club where instr(#1, ?) order by club_no desc";
		sql = sql.replace("#1", column);
		Object[] params = {keyword};
		return jdbcTemplate.query(sql, clubMapper, params);
	}
	
}
