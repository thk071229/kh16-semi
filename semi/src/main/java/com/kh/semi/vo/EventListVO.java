package com.kh.semi.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class EventListVO {

	private int eventNo;
	private int eventClub;
	private String eventWriter;
	private String eventTitle;
	private int eventMaxPeople;
	private String eventAddress;
	private Timestamp eventDate;
	// From club_list Table
	private String clubName;
	private int clubRegion;
	private String regionName;
	private int clubCategory;
	private String categoryName;
	// From member Table
	private String memberNickname;
	
}
