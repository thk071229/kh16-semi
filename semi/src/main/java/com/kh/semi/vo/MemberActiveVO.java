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
	private int memberPointUse;
	
	int eventImportance = 20; // 정모 참여시 가중치
	int boardImportance = 5; // 게시글 작성시 가중치
	int PointUseImportance = -500; // 생성권 구매 가중치
	
	public int memberPoint() {
		int resultPoint = memberEventAttend*eventImportance
							+ memberBoardWrite*boardImportance
							+ memberPointUse*PointUseImportance;
		return resultPoint;
	}
										
	
}
