package com.kh.semi.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ChartVO {
	private String subject; 
	private String type; 
	private List<String> labels; 
	private List<Double> data; 
}
