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
		memberActiveVO.setMemberNickname(rs.getString("memberNickname"));
		memberActiveVO.setMemberEventAttend(rs.getInt("memberEventAttend"));
		memberActiveVO.setMemberBoardWrite(rs.getInt("memberBoardWrite"));
		
		
		return memberActiveVO;
	}

}
