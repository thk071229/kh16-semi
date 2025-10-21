package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ClubListVO {

	public int clubNo;
	public String clubFounder;
	public String clubName;
	public int clubRegion;
	public int clubCategory;
	public String regionName;
	public String categoryName;
}
