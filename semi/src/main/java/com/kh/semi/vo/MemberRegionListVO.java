package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberRegionListVO {
	String memberId;
	int regionNo;
	String regionType;
	String regionName;
	String regionDepth1;
	String regionDepth2;
}
