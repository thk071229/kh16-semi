package com.kh.semi.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ClubMemberListVO {
	
	private int clubNo;
	private String clubMember;//member_id
	private String clubMemberRole;
	private Timestamp clubMemberJoin;
	//회원 닉네임
	private String memberNickname;

}
