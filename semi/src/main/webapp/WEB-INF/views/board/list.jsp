<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	table {
		border : 1px solid black;
	}
</style>
<div class="container w-700">
<div class="cell">
<h1>리스트</h1>
</div>
<div class="cell">
<table>
	<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>조회수</th>
			<th>좋아요</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var = "boardDto" items = "${boardList}">
		<td>${boardDto.boardNo}</td>
		<td>${boardDto.boardTitle}</td>
		<td>${boardDto.boardWriter}</td>
		<td>${boardDto.boardRead}</td>
		<td>${boardDto.boardWriteTime}</td>
		</c:forEach>
	</tbody>
</table>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>