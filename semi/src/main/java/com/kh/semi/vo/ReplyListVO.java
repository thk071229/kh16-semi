package com.kh.semi.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyListVO {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	
	private int replyNo;
	private String replyWriter;
	private int replyTarget;
	private Timestamp replyWtime;
	private Timestamp replyEtime;
	
}
