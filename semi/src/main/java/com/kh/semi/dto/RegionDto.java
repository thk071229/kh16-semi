package com.kh.semi.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RegionDto {

	public int regionNo;
	public String regionName;
	public String regionDepth1;
	public String regionDepth2;
}
