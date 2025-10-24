package com.kh.semi.vo;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
//list 조회 시 보여줄 데이터
@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardListVO {
	private int boardNo;
	private int boardClub;
	private String boardWriter;
	private String boardNotice = "N";
	private String boardTitle;
	//private String boardContent; //데이터 용량 크니까 제외
	private Timestamp boardWtime;
	private Timestamp boardEtime;
	private int boardRead;
	private int boardLike;
	private int boardComment;
	
	private String memberId;
	private String memberNickname;
	private String memberLevel;
	
	private int clubNo;
	private String clubName;
	private String clubLeader;
	private String regionName;
	private String categoryName;
	
	//내가 추가한 게터 메소드
		//EL에서 ${boardDto.boardWriteTime}으로 부를 수 있는 메소드를 생성
			public String getBoardWriteTime() {
				LocalDateTime wtime = boardWtime.toLocalDateTime();//작성 시점을 LocalDateTime으로 변환
				LocalDate today = LocalDate.now(); //오늘 날짜를 구하고
				LocalDate wday = wtime.toLocalDate(); //작성 일자를 구해서
				
				if(wday.isBefore(today)) {
					return wtime.toLocalDate().toString();//날짜 반환
				}
				else {
					DateTimeFormatter fmt = DateTimeFormatter.ofPattern("HH:mm"); 
					//formatter 사용해서 시간 형식 변환
					return wtime.toLocalTime().format(fmt);//시간 반환
				}
			}
}
