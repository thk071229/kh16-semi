package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.ReplyDto;

@Component
public class ReplyMapper implements RowMapper<ReplyDto>{

	@Override
	public ReplyDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return ReplyDto.builder()
				.replyNo(rs.getInt("reply_no"))
				.replyContent(rs.getString("reply_content"))
				.replyWriter(rs.getString("reply_writer"))
				.replyTarget(rs.getInt("reply_target"))
				.replyWtime(rs.getTimestamp("reply_wtime"))
				.replyEtime(rs.getTimestamp("reply_etime"))
				.build();
	}
	
}
