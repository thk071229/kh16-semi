<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 선택자를 이용해서 js 호출 후 pagination 처리 (기존의 a태그대신 버튼 이벤트로 변경 -->
<%-- 
	*페이지 내비게이터 사용 방법
	
	1. PageVO를 이용한 목록 조회(필수)
	1. controller 설정
		-pageVO.setdataCount(총 데이터 수) 설정
		*처음에 보여줄 size 값 default와 다르게 설정할 시
		-if(pageVO.getSize() == 4) pageVO.setSize(처음에 보여줄 데이터 수);
		//size 디폴트가 5라서 생긴 조건(size가 int라서 null 처리 불가능)
	2. 사용할 jsp page 상단에(style 태그 밑 추천) more-list-button.js 삽입
	3. (+선택 사항)
		-list 불러올때 pageVO 이외의 파라미터 값이 존재할 경우 (ex:clubNo) 
		-해당 Controller에서 pageVO.putParentParams(String, Integer); 
		//부모 파라미터 존재할 때는 반드시 설정해야합니다
	
--%>
<c:if test="${pageVO != null && pageVO.dataCount > 0}">
    <div class="pagination-more">
        <button type="button" class="btn btn-common btn-more"
            data-query="${pageVO.searchParamsInMore}${pageVO.parentParamsToString}" 
            data-count="${pageVO.dataCount}">
            더보기
        </button>
        <div class="no-data">
        	<h2>더이상 목록이 없습니다</h2>
        </div>
    </div>
</c:if>