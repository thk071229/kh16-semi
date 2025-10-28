package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ClubEventCountVO {
	private int eventClub;
	private String clubName;
	private Integer clubProfile;
	private String regionName;
	private String categoryName;
	private int eventCount;
	private int memberCount;
}
