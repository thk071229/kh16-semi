package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ClubListVO {

	private int clubNo;
	private String clubLeader;
	private String clubName;
	private int clubRegion;
	private int clubCategory;
	private String regionName;
	private String categoryName;
	private int clubLike;
	private Integer clubProfile;
	private String clubIntroduce;
	private int memberCount;
}
