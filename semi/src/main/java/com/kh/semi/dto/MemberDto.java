package com.kh.semi.dto;

import java.sql.Timestamp;
import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberDto {
	private String memberId;
	private String memberPw;
	private String memberNickname;
	private String memberEmail;
	private String memberGender;
	private LocalDate memberBirth;
	private int memberPoint;
	private String memberLevel;
	private Timestamp memberJoin;
}
