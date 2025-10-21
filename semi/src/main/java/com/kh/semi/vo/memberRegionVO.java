package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class memberRegionVO {
	String memberId;
	int regionNo;
	String regionType; //집/직장/관심지역
}
