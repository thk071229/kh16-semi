package com.kh.semi.VO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class memberCategoryVO {
	String memberId;
	int categoryNo;
}
