package com.kh.semi.dto;

import java.util.List;

import com.kh.semi.vo.EventListVO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class EventListDto {
	private List<EventListVO> eventList;
	private int eventTotalCount;
	private List<EventListVO> beforeEventList;
	private int beforeTotalCount;
	private List<EventListVO> afterEventList;
	private int afterTotalCount;
}
