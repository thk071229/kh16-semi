<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt"%>
<div class="container w-700">
<h1>상세</h1>
<div class="cell">
	<h1>${boardDto.boardTitle}</h1>
	<hr>
	<a href = "/member/detail?memberId=${boardDto.boardWriter}">
	${boardDto.boardWriter}
	</a>
	<fmt:formatDate value ="${boardDto.boardWtime}" pattern = "yyyy-MM-dd HH:mm"/>
	${boardDto.boardRead}
	<hr>
	<div class="cell"  style = "min-height:200px; vertical-align : top; padding : 10px;">
	${boardDto.boardContent}
	</div>
	<hr>
	<div class="cell">
	좋아요 : ${boardDto.boardLike}
	댓글 : ${boardDto.boardComment}
	</div>
</div>
	<div>
		<a href="list?clubNo=${boardDto.boardClub}">목록으로</a>
		<a href="edit?boardNo=${boardDto.boardNo}">수정하기</a>
		<a href="delete?boardNo=${boardDto.boardNo}">삭제하기</a>
		<a href="write?clubNo=${boardDto.boardClub}">새 글 등록</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>