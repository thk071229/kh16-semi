<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
	*페이지 내비게이터 사용 방법(list 불러올때 pageVO 이외의 파라미터 값이 존재할 경우 (ex:clubNo)) 
	PageVO를 이용한 목록 조회(필수)
	해당 Controller에서 pageVO.putParentParams(String, Integer); 반드시 설정해야합니다
--%>
<%-- 페이지 내비게이터(더보기 방식)--%>
<%-- a태그로 구현 --%>
<c:if test = "${pageVO != null && pageVO.dataCount > 0 && pageVO.page < pageVO.totalPage}">
	<div class = "pagination-more">
			<a href = "list?${pageVO.searchParamsInMore}${pageVO.parentParamsToString}" class="btn btn-common btn-more">더보기</a>
	</div>
</c:if>

