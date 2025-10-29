package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.MemberDto;

@Component
public class MemberMapper implements RowMapper<MemberDto>{

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return MemberDto.builder()
					.memberId(rs.getString("member_id"))
					.memberPw(rs.getString("member_pw"))
					.memberNickname(rs.getString("member_nickname"))
					.memberEmail(rs.getString("member_email"))
					.memberGender(rs.getString("member_gender"))
					.memberBirth(rs.getDate("member_birth"))
					.memberPoint(rs.getInt("member_point"))
					.memberLevel(rs.getString("member_level"))
					.memberJoin(rs.getTimestamp("member_join"))
					.memberAuthority(rs.getString("member_authority"))
				.build();
	}
	
}
