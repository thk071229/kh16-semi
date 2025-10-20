package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.BoardDto;

@Component
public class BoardMapper implements RowMapper<BoardDto>{

	@Override
	public BoardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		return BoardDto.builder()
				.boardNo(rs.getInt("board_no"))
				.boardClub(rs.getInt("board_club"))
				.boardWriter(rs.getString("board_writer"))
				.boardNotice(rs.getString("board_notice"))
				.boardTitle(rs.getString("board_title"))
				.boardContent(rs.getString("board_content")) 
				.boardWtime(rs.getTimestamp("board_wtime"))
				.boardEtime(rs.getTimestamp("board_etime"))
				.boardRead(rs.getInt("board_read"))
				.build();

	}

}
