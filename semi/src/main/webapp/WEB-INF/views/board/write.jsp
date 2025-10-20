<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action = "write" method = "post">
	<input type = "hidden" name = "clubNo" value = "${clubNo}">
	<label>
	<input type = "checkbox" name = "boardNotice" value = "Y">
	<span>공지사항으로 등록</span>
	</label>
	<input type = "text" name = "boardTitle" placeholder = "제목을 입력하세요">
	<textarea name = "boardContent" rows="5" placeholder = "내용을 입력하세요"></textarea>
	<button type = "submit">등록</button>
</form>