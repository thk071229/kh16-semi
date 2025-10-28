package com.kh.semi.dto;

import java.util.List;

import com.kh.semi.vo.ClubListVO;
import com.kh.semi.vo.ClubMemberListVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ClubListDto {
	private List<ClubListVO> clubList;
	private int clubTotalCount;
	private List<ClubListVO> clubRecommendList;
	private int recommendTotalCount;
	private List<ClubMemberListVO> clubMemberList;
	private int clubMemberTotalCount;
	
}
