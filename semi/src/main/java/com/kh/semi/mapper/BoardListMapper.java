package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.vo.BoardListVO;
//list 조회를 위한 Mapper
@Component
public class BoardListMapper implements RowMapper<BoardListVO>{

	@Override
	public BoardListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		return BoardListVO.builder()
				.boardNo(rs.getInt("board_no"))
				.boardClub(rs.getInt("board_club"))
				.boardNotice(rs.getString("board_notice"))
				.boardTitle(rs.getString("board_title"))
				.boardWriter(rs.getString("board_writer"))
				.boardWtime(rs.getTimestamp("board_wtime"))
				.boardEtime(rs.getTimestamp("board_etime"))
				.boardRead(rs.getInt("board_read"))
				.boardLike(rs.getInt("board_like"))
				.boardComment(rs.getInt("board_comment"))
				.memberId(rs.getString("member_id"))
				.memberNickname(rs.getString("member_nickname"))
				.memberLevel(rs.getString("member_level"))
				.clubNo(rs.getInt("club_no"))
				.clubName(rs.getString("club_name"))
				.regionName(rs.getString("region_name"))
				.categoryName(rs.getString("category_name"))
				.build();
	}

}
