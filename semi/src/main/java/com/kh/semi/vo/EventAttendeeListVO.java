package com.kh.semi.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class EventAttendeeListVO {

	private int eventNo;
	private int eventClub;
	private String eventTitle;
	private int eventAttend;
	private int eventMaxPeople;
	private String eventAddress;
	private Timestamp eventDate;
	// From club_list Table
	private String clubName;
	private String clubLeader;
	// From event_attendee Table
	private String attendMember;
	// From member Table
	private String memberNickname;
	private String attendMemberNickname;

}
