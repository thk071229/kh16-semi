package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.BoardLikeListVO;

@Component
public class BoardLikeListMapper implements RowMapper<BoardLikeListVO>{

	@Override
	public BoardLikeListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		return BoardLikeListVO.builder()
				.boardNo(rs.getInt("board_no"))
				.boardTitle(rs.getString("board_title"))
				.boardWriter(rs.getString("board_writer"))
				.memberId(rs.getString("member_id"))
				.build();
	}
	
}
