<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<div class="container w-700">
<div class="cell">
<form action = "write" method = "post" autocomplete="off">
	<input type = "hidden" name = "clubNo" value = "${clubNo}">
	<label>
	<input type = "checkbox" name = "boardNotice" value = "Y">
	<span>공지사항으로 등록</span>
	</label>
	<br>
	<input type = "text" name = "boardTitle" placeholder = "제목을 입력하세요" class="field w-100">
	<br>
	<textarea name = "boardContent" rows="5" placeholder = "내용을 입력하세요" class="field w-100"></textarea>
	<br>
	<button type = "submit">등록</button>
</form>
</div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>