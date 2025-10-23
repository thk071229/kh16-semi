package com.kh.semi.vo;

import lombok.Data;

@Data
//좋아요 처리용 VO
public class BoardLikeVO {
	private boolean like;
	private int count;
}
