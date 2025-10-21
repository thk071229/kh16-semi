package com.kh.semi.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.kh.semi.dto.AttachmentDto;

@Component
public class AttachmentMapper implements RowMapper<AttachmentDto>{

	@Override
	public AttachmentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		return AttachmentDto.builder()
				.attachmentNo(rs.getInt("attachment_no"))
				.attachmentName(rs.getString("attachment_name"))
				.attachmentSize(rs.getLong("attachment_size"))
				.attachmentType(rs.getString("attachment_type"))
				.attachmentTime(rs.getTimestamp("attachment_time"))
				.build();
	}

}
