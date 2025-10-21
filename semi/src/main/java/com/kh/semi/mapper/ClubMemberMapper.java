package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.ClubMemberDto;

@Component
public class ClubMemberMapper implements RowMapper<ClubMemberDto>{

	@Override
	public ClubMemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ClubMemberDto.builder()
				.clubNo(rs.getInt("club_no"))
				.clubMember(rs.getString("club_member"))
				.clubMemberRole(rs.getString("club_member_role"))
				.clubMemberJoin(rs.getTimestamp("club_member_join"))
				.build();
	}

}
