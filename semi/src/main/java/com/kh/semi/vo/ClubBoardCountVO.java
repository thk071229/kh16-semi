package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ClubBoardCountVO {
	private int boardClub;
	private String clubName;
	private String regionName;
	private String categoryName;
	private int boardCount;
	private int memberCount;
}
