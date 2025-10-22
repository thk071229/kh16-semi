package com.kh.semi.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ClubDto {
	private int clubNo;
	private String clubLeader;//모임장(member_id)
	private String clubName;
	private String clubIntroduce;
	private int clubRegion;
	private int clubCategory;
	private String clubOpen;
	private Timestamp clubJoin;
}
