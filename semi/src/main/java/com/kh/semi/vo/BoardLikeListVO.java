package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardLikeListVO {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	
	//좋아요 누른 사람
	private String memberId;
}
