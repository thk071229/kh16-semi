package com.kh.semi.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semi.dto.ClubMemberDto;
import com.kh.semi.mapper.ClubMemberMapper;

@Repository
public class ClubMemberDao {

	@Autowired
	private ClubMemberMapper clubMemberMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void insert(ClubMemberDto clubMemberDto) {
		String sql = "insert into club_member(club_no, club_member, club_member_role) "
				+ "values(?,?,?)";
		Object[] params = {clubMemberDto.getClubNo(), clubMemberDto.getClubMember(), clubMemberDto.getClubMemberRole()};
		jdbcTemplate.update(sql, params);
	}
	// 클럽 회원 등급 변경
	public boolean updateRole(ClubMemberDto clubMemberDto){
	  String sql = "update club_member set club_member_role = ? where club_no = ? and member_id = ?";
	  Object[] params = {clubMemberDto.getClubMemberRole(), clubMemberDto.getClubNo(), clubMemberDto.getClubMember()};
	  return jdbcTemplate.update(sql, params) > 0;
	}
	// 조회
	public ClubMemberDto selectOne(int clubNo) {
		String sql = "select * from club_member where club_no = ?";
		Object[] params = {clubNo};
		List<ClubMemberDto> list = jdbcTemplate.query(sql, clubMemberMapper, params);
		return list.isEmpty() ? null : list.get(0);
	}
}
