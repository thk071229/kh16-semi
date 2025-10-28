package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data  @NoArgsConstructor @Builder @AllArgsConstructor
public class MemberActiveVO {

	private String memberId;
	private String memberNickname;
	private int memberEventAttend;
	private int memberBoardWrite;
	
	int eventImportance = 10; // 정모 참여시 가중치
	int boardImportance = 3; // 게시글 작성시 가중치
	
	public int memberPoint() {
		int resultPoint = memberEventAttend*eventImportance+ memberBoardWrite*boardImportance;
		return resultPoint;
	}
										
	
}
