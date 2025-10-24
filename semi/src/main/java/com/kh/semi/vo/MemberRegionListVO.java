package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberRegionListVO {
	private String memberId;
	private int regionNo;
	private String regionType;
	private String regionName;
	private String regionDepth1;
	private String regionDepth2;
}
