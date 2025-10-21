package com.kh.semi.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class EventDto {

	private int eventNo;
	private int eventClub;
	private String eventWriter;
	private String eventTitle;
	private String eventContent;
	private double eventRegionX;
	private double eventRegionY;
	private Timestamp eventDate;
	private Timestamp eventWtime;
	private Timestamp eventEtime;
	
}
