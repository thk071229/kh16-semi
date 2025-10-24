package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberCategoryListVO {
	private String memberId;
	private int categoryNo;
	private String categoryName;
}
