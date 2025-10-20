package com.kh.semi.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardDto {
	private int boardNo;
	private int boardClub;
	private String boardWriter;
	private String boardNotice;
	private String boardTitle;
	private String boardContent;
	private Timestamp boardWtime;
	private Timestamp boardEtime;
	private int boardRead;
}
