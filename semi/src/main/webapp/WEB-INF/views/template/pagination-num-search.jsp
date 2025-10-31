<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
.pagination {
	text-align: center;
}
.pagination > a {
	font-weight: 700;
    text-decoration: none;
    color: #64B698;
    border: none;
    padding: 0.5em;
    font-size: 16px;
    display: inline-block;
    min-width: 2.5em;
}
 
.pagination > a:hover {
    box-shadow: 0 0 0 2px #FFD6A5;
    border-radius: 5px;
}

.pagination > a.active {
    box-shadow: 0 0 0 2px #FFBF86;
    border-radius: 5px;
    color: #64B698;
}

</style>


<%-- 
	*페이지 내비게이터 사용 방법(list 불러올때 pageVO 이외의 파라미터 값이 존재할 경우 (ex:clubNo)) 
	해당 Controller에서 pageVO.putParentParams(String, Integer); 반드시 설정해야합니다
--%>
<%-- 페이지 내비게이터 (pageVO의 내용을 토대로 작성)--%>
<c:if test = "${pageVO != null && pageVO.dataCount > 0}">
	<div class="container">
		<div class="cell">
			<div class="pagination">
			<c:if test = "${pageVO.firstBlock == false}">
				<a href = "search?page=1${pageVO.searchParams}${pageVO.parentParamsToString}&keyword=${keyword}">&lt;&lt;</a>
				<%-- &{pageVO.blockStart > 1} = 첫 블록이 아니면 --%>
				<%-- 가독성을 위해 pageVO에 boolean 메소드 생성 --%>
				<%-- EL에서는 ==false 대신 not 사용 가능하나 선택사항 --%>
				<a href = "search?page=${pageVO.prevPage}${pageVO.searchParams}${pageVO.parentParamsToString}&keyword=${keyword}">&lt;</a>
				<%-- ${pageVO.blockStart - 1} = 이전 페이지 --%>
				<%-- 인덱스의 시작 경계인 start(ex:21(21-30블럭))에서 -1을 해줘야 이전 페이지(ex:20(11-20블럭))로 돌아감 --%>
				</c:if>
				<c:forEach var="i" begin = "${pageVO.blockStart}" end = "${pageVO.blockFinish}" step = "1">
					<%-- ${Math.min(finish, totalPage)} = Math.min 은 두 값 중 더 작은 값을 반환 --%>
					<%-- finish > totalPages ? totalPages : finish --%>
					<%-- finish 값이 totalPages보다 작으면 finish(원래의 end값) 반환, 크면 totalPages(마지막 페이지 값을 end로) 반환 --%>
					<c:choose>
						<c:when test = "${pageVO.page == i}"><a class="on">${i}</a></c:when>
						<%-- 현재 페이지일 경우 클릭하여 이동할 수 없도록 처리 --%>
						<c:otherwise>
						<%-- 현재 페이지가 아닐 경우 클릭하여 이동할 수 있도록 처리 --%>
							<a href = "search?page=${i}${pageVO.searchParams}${pageVO.parentParamsToString}&keyword=${keyword}">${i}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
					<c:if test = "${pageVO.lastBlock == false}">
					<%-- ${finish < totalPages} = 마지막 블럭이 아니면 --%>
					<%-- 현재 속해있는 페이지의 끝 값(finish)이 전체 페이지 수(totalPages) 보다 작을 때 표시 --%>
					<%-- 전체 페이지 : 45, 현재 페이지 : 34 일 때--%>
					<%-- 현재 페이지의 끝 값(finish) = 40 < 전체 페이지 수 (totalPages = 45) 이므로 다음 표시--%>
					<%-- 현재 페이지 : 42일 때 --%>
					<%-- 현재 페이지의 끝 값(finish) = 50 > 전체 페이지 수 (totalPages = 45) 이므로 다음 표시 x --%>
						<a href = "search?page=${pageVO.nextPage}${pageVO.searchParams}${pageVO.parentParamsToString}&keyword=${keyword}">&gt;</a>
						<%-- ${finish + 1} = 다음 페이지 --%>
						<%-- 인덱스의 끝 경계인 finish(ex:20(11-20블럭))에서 +1을 해줘야 다음 페이지(ex:21-30블럭))로 넘어감--%>
						<a href = "search?page=${pageVO.totalPage}${pageVO.searchParams}${pageVO.parentParamsToString}&keyword=${keyword}">&gt;&gt;</a>
				</c:if>
			</div>
		</div>
</div>
</c:if>