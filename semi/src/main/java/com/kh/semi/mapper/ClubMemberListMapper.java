package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.ClubMemberListVO;

@Component
public class ClubMemberListMapper implements RowMapper<ClubMemberListVO>{

	@Override
	public ClubMemberListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ClubMemberListVO.builder()
				.clubNo(rs.getInt("club_no"))
				.clubMember(rs.getString("club_member"))
				.clubMemberRole(rs.getString("club_member_role"))
				.clubMemberJoin(rs.getTimestamp("club_member_join"))
				.memberNickname(rs.getString("member_nickname"))
				.build();
	}

}
