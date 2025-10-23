package com.kh.semi.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyDto {
		private int replyNo;
		private String replyContent;
		private String replyWriter;
		private int replyTarget;
		private Timestamp replyWtime;
		private Timestamp replyEtime;

	}
