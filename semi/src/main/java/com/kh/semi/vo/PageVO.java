package com.kh.semi.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

//페이징의 공통데이터를 필드와 메소드로 정리하고 PageVO를 전달
@Data @NoArgsConstructor @AllArgsConstructor @Builder
//롬복에서 data불러와서 setter,getter,constructor,toString 생성
//설정해줘야 controller에서 클래스 자유롭게 사용 가능
public class PageVO {

	private int page = 1; 
	//현재 페이지 번호 - defaultValue를 1로 설정
	private int size = 10; 
	//한 페이지에 표시할 데이터(게시글) 수- defaultValue를 10으로 설정
	private String column, keyword; 
	//검색항목, 검색어-기본값 : null(안써도 됨)
	private int dataCount; //총 데이터(게시글) 개수
	private int blockSize = 10;//표시할 블록 개수
	//계산이 가능하도록 Getter 메소드 추가 생성
	public boolean isSearch() {
		return column != null && keyword != null;
	}
	
	public boolean isList() {
		return column == null || keyword == null;
	}
	
	public String getSearchParams() {//목록 or 검색 여부에 따라 주소에 추가될 파라미터를 반환
	if(isSearch()) {//검색일때 - size 및 컬럼, 키워드 반환
		return "&size="+size+"&column="+column+"&keyword="+keyword;
	}
	else {//목록일때 - size만 반환
		return "&size="+size;
	}
	}

	public int getBlockStart() {//블록의 시작 번호
		return (page - 1) / blockSize * blockSize + 1;
	}
	public int getBlockFinish() {//블록의 종료 번호
		int number = (page - 1) / blockSize * blockSize + blockSize;
		return Math.min(getTotalPage(), number);
	}
	
	public int getTotalPage() {
		return (dataCount - 1) / size + 1;
	}
	
	public int getBegin() {
		return page * size - (size - 1);
	}
	
	public int getEnd() {
		return page * size;
	}
	//가독성을 위해 메소드 추가 생성 (코드에 이름 붙이기)
	public boolean isFirstBlock() { //is는 논리형을 반환할 때 만드는 변수명(EL에서 추론 기능을 통해 생략 가능)
		return getBlockStart() == 1; //첫번째 블록인 경우를 작성(jsp에서 ==false로 쓰기 위함)
	}
	
	public int getPrevPage() {
		return getBlockStart() - 1;
	}
	
	public int getNextPage() {
		return getBlockFinish() + 1;
	}
	public boolean isLastBlock() {
		return getBlockFinish() == getTotalPage(); //마지막 블록인 경우를 작성(jsp에서 == false로 쓰기 위함)
	}
	public boolean isLastCount() {
		return getEnd() >= getDataCount();
	}
}
