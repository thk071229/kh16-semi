package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberClubListVO {
	private String memberId;
	private int clubNo;
	private String clubName;
	private int clubCategory;
	private int clubRegion;
	private String categoryName;
	private String regionName;
}
