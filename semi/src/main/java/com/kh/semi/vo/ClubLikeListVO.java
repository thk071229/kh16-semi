package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ClubLikeListVO {

	// 소모임 정보 
	private int clubNo;
	private String clubName;
	private String clubIntroduce;
	private Integer clubProfile;
	
	//카테고리 정보
	private int categoryNo;
	private String categoryName;
	
	//지역 정보
	private int regionNo;
	private String regionName;
	
	//좋아요 누른 사람
	private String memberId;
}
