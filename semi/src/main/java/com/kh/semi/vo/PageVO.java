package com.kh.semi.vo;

import java.util.HashMap;
import java.util.Map;

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
	private int size = 4; 
	//한 페이지에 표시할 데이터(게시글) 수- defaultValue를 4로 설정
	private String column, keyword; 
	//검색항목, 검색어-기본값 : null(안써도 됨)
	private int dataCount; //총 데이터(게시글) 개수
	private int blockSize = 10;//표시할 블록 개수
	//부모 파라미터 저장하기 위한 필드 생성
	private Map<String, Integer> parentParams;
	//더보기 버튼 사용 시 필요한 리스트 타입
	private String type;
	
	/// 지역검색용 pageVO에 추가
	private String regionDepth1;
	private String regionDepth2;
	
	public boolean noRegion() {
			return (regionDepth1 == null || regionDepth1.isEmpty())
			|| (regionDepth2 == null || regionDepth2.isEmpty());
	}
	
	
	
	//외부에서 호출하기 위한 게터메소드
	public Map<String, Integer> getParentParams(){
		if(parentParams == null) {
			parentParams = new HashMap<>();
		}
		return parentParams;
	}
	public int getParentParamsValue(){
		Integer result = 0;
		if(parentParams == null || parentParams.isEmpty()) {
			return result;
		}
		for(String key : parentParams.keySet()) {
			Integer value = parentParams.get(key);
			if(value != null) { //value가 존재할 경우
				result = value;
				return (int)result;
			}
		} 
		return result;
	}
	//계산이 가능하도록 Getter 메소드 추가 생성
	public boolean isSearch() {
		return column != null && keyword != null;
	}
	
	public boolean isList() {
		return column == null || keyword == null;
	}
	//더보기 pagination에서 사용할 boolean 메소드
	public boolean hasMore() {
		int totalSize = size * page;
		return dataCount > totalSize && dataCount != 0; 
	}
	//더보기 pagination에서 사용할 size 계산 게터 메소드
	public String getSearchParamsInMore() {
			  int totalSize = size * page;
			  if (page < getTotalPage()) {
			        totalSize += size;  
			    }

			    if (totalSize > dataCount) {
			        totalSize = dataCount;
			    }

			    if (isSearch()) {
			        return "&size=" + totalSize + "&column=" + column + "&keyword=" + keyword;
			    } else {
			        return "&size=" + totalSize;
			    }
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
	
	//parentParams에 key, value 값을 넣기 위한 getter 메소드
	public void putParentParams(String key, Integer value) {
		getParentParams().put(key, value);
	}
	
	//parentParams에 담긴 key, value 값을 String으로 변환하는 메소드
	public String getParentParamsToString() {
		if(parentParams == null || parentParams.isEmpty()) {
			return "";
		}
		String result = "";
		for(String key : parentParams.keySet()) {
			Integer value = parentParams.get(key);
			if(value != null) {
				result += "&" + key + "=" + value;
			}
		}
		return result;
	}
}
