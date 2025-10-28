package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ClubCountVO {
		private int clubNo;
		private String clubName;
		private Integer clubProfile;
		private String regionName;
		private String categoryName;
		private int clubLike;
		private int eventCount;
		private int boardCount;
		private int memberCount;
}
