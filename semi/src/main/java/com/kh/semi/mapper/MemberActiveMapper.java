package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.MemberActiveVO;

@Component
public class MemberActiveMapper implements RowMapper<MemberActiveVO> {

	@Override
	public MemberActiveVO mapRow(ResultSet rs, int rowNum) throws SQLException {

		MemberActiveVO memberActiveVO = new MemberActiveVO();
		memberActiveVO.setMemberId(rs.getString("member_id"));
		memberActiveVO.setMemberNickname(rs.getString("member_nickname"));
		memberActiveVO.setMemberEventAttend(rs.getInt("member_event_attend"));
		memberActiveVO.setMemberBoardWrite(rs.getInt("member_board_write"));
		memberActiveVO.setMemberPointUse(rs.getInt("member_point_use"));
		return memberActiveVO;
	}

}
