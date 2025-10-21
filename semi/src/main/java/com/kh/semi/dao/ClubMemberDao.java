package com.kh.semi.dao;

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
}
