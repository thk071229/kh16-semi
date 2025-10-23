package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberClubListVO {
	String memberId;
	int clubNo;
	String clubName;
	int clubCategory;
	int clubRegion;
	String categoryName;
	String regionName;
}
